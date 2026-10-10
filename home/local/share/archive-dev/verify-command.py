import contextlib
import importlib.util
import importlib.machinery
import io
import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_loader('archive', importlib.machinery.SourceFileLoader('archive', str(Path.home() / '.local/bin/archive-dev')))
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)

class ArchiveCommandTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(dir='/private/tmp')
        self.home = Path(self.temp.name) / 'home'
        self.dev = self.home / 'Documents/dev'
        self.dev.mkdir(parents=True)
        self.patches = [patch.object(m, 'HOME', self.home), patch.object(m, 'running_writers', return_value=[])]
        for p in self.patches: p.start()
    def tearDown(self):
        for p in reversed(self.patches): p.stop()
        self.temp.cleanup()
    def invoke(self, *args):
        with patch.object(sys, 'argv', ['archive-dev', *map(str,args)]), contextlib.redirect_stdout(io.StringIO()) as out:
            m.main()
        return out.getvalue()
    def folder(self, name='plain folder'):
        source = self.dev / name
        source.mkdir()
        (source / '.hidden').write_text('Hidden and uncommitted contents')
        return source
    def test_plain_folder_missing_tools_collision_and_rollback(self):
        source = self.folder()
        date = m.datetime.now().date().isoformat()
        occupied = self.dev / 'archive' / ('plain folder-archive-' + date)
        occupied.mkdir(parents=True)
        (occupied/'keep').write_text('untouched')
        legacy = self.home/'.local/share/opencode/storage/session/project/session.json'
        legacy.parent.mkdir(parents=True)
        legacy.write_text(json.dumps({'directory':str(source),'title':'original '+str(source)}))
        self.invoke(source)
        destination = Path(m.NEW)
        self.assertEqual(json.loads(legacy.read_text())['directory'],m.NEW)
        self.assertEqual(destination.name, 'plain folder-archive-' + date + '-2')
        self.assertFalse(source.exists())
        self.assertEqual((destination/'.hidden').read_text(), 'Hidden and uncommitted contents')
        self.assertEqual((occupied/'keep').read_text(),'untouched')
        backup = next((self.home/'.local/share/archive-dev/backups').iterdir())
        self.assertEqual(json.loads((backup/'result.json').read_text())['status'],'complete')
        self.invoke('--rollback',backup)
        self.assertTrue(source.exists())
        self.assertEqual(json.loads(legacy.read_text())['directory'],str(source))
        self.assertFalse(destination.exists())
        self.assertIn('already been rolled back',self.invoke('--rollback',backup))
    def test_dry_run_and_short_name(self):
        source = self.folder('project_with_under_scores')
        plan = json.loads(self.invoke(source.name,'--dry-run'))
        self.assertEqual(plan['source'],str(source))
        self.assertTrue(source.exists())
        self.assertFalse(Path(plan['destination']).exists())
        self.assertFalse((self.home/'.local/share/archive-dev').exists())
    def test_old_path_reuse_blocks_rollback(self):
        source = self.folder()
        self.invoke(source)
        destination = Path(m.NEW)
        source.mkdir()
        backup = next((self.home/'.local/share/archive-dev/backups').iterdir())
        with self.assertRaisesRegex(SystemExit,'old path has been reused'):
            self.invoke('--rollback',backup)
        self.assertTrue(source.exists())
        self.assertTrue(destination.exists())
    def test_active_tools_block_before_backups(self):
        source = self.folder()
        with patch.object(m,'running_writers',return_value=[{'pid':1}]):
            with self.assertRaisesRegex(SystemExit,'Nothing changed'):
                self.invoke(source)
        self.assertTrue(source.exists())
        self.assertFalse((self.home/'.local/share/archive-dev').exists())
    def test_unborn_git_repository(self):
        source = self.folder('new-repository')
        m.subprocess.run(['git','init','-q',str(source)],check=True)
        self.invoke(source)
        self.assertTrue((Path(m.NEW)/'.git').is_dir())
        self.assertFalse(source.exists())
    def test_subfolder_history_and_unrelated_sibling(self):
        source = self.folder('project')
        nested_cwd = str(source/'backend')
        unrelated_cwd = str(self.dev/'project-backend')
        base = self.home/'.pi/agent/sessions'
        # Choose a sibling with a different encoded name to verify prefix filtering.
        unrelated_cwd = str(self.dev/'project-unrelated')
        for cwd in [nested_cwd,unrelated_cwd]:
            folder = base/('--'+cwd.strip('/').replace('/','-')+'--')
            folder.mkdir(parents=True)
            (folder/'session.jsonl').write_text(json.dumps({'type':'session','cwd':cwd})+'\n'+json.dumps({'type':'message','text':'historical '+cwd})+'\n')
        unrelated = base/('--'+unrelated_cwd.strip('/').replace('/','-')+'--')
        original_unrelated = (unrelated/'session.jsonl').read_bytes()
        self.invoke(source)
        new_folder = base/('--'+(m.NEW+'/backend').strip('/').replace('/','-')+'--')
        records=[json.loads(line) for line in (new_folder/'session.jsonl').read_text().splitlines()]
        self.assertEqual(records[0]['cwd'],m.NEW+'/backend')
        self.assertEqual(records[1]['text'],'historical '+nested_cwd)
        self.assertEqual((unrelated/'session.jsonl').read_bytes(),original_unrelated)
    def test_invalid_source_and_symlink(self):
        source = self.folder()
        link = self.dev/'alias'
        link.symlink_to(source,target_is_directory=True)
        with self.assertRaisesRegex(SystemExit,'not a symlink'):
            self.invoke(link)
        with self.assertRaisesRegex(SystemExit,'direct child'):
            self.invoke(self.dev)
    def test_directory_matching_ignores_sql_wildcards(self):
        source = self.folder('my_project')
        m.configure_source(source)
        m.NEW = str(self.dev/'archive/my_project-archive-test')
        with m.sqlite3.connect(':memory:') as c:
            c.execute('create table session(directory text)')
            c.executemany('insert into session values(?)',[(str(source),),(str(source)+'/nested',),(str(self.dev/'myXproject/nested'),)])
            m.update_path_columns(c,'session',['directory'])
            values=[r[0] for r in c.execute('select directory from session')]
            self.assertEqual(values,[m.NEW,m.NEW+'/nested',str(self.dev/'myXproject/nested')])

if __name__ == '__main__':
    unittest.main()
