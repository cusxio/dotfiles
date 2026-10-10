"""Exercise archive migration and rollback in an isolated repository and stores."""
import importlib.util
import importlib.machinery
import json
import os
import shutil
from pathlib import Path
import sqlite3
import subprocess
import tempfile

spec = importlib.util.spec_from_loader('migration', importlib.machinery.SourceFileLoader('migration', str(Path.home() / '.local/bin/archive-dev')))
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
m.OLD = '/Users/x/Documents/dev/test-project'
m.NEW = '/Users/x/Documents/dev/archive/test-project-archive-2026-10-07'

# Read-only checks against the user's actual formats and saved offsets.
with m.dbopen(m.HOME / '.codex/state_5.sqlite', True) as c:
    rows = list(c.execute('select id,rollout_path,cwd from threads where cwd=?', (m.OLD,)))
with m.dbopen(m.HOME / '.codex/thread_history_1.sqlite', True) as c:
    checked = 0
    for sid, rollout, cwd in rows[:5]:
        p = Path(rollout)
        original = p.read_bytes()
        updated, n, ends, shifts = m.transform_jsonl(p, 'codex')
        before = original.splitlines(keepends=True)
        after = updated.splitlines(keepends=True)
        assert len(before) == len(after)
        for a, b in zip(before, after):
            d = json.loads(a)
            if d['type'] not in {'session_meta', 'turn_context'}:
                assert a == b
        for (offset,) in c.execute('select rollout_byte_offset from thread_turns where thread_id=? and rollout_byte_offset is not null', (sid,)):
            i = m.bisect.bisect_right(ends, offset) - 1
            new_offset = offset + (shifts[i] if i >= 0 else 0)
            assert original[offset:].split(b'\n', 1)[0] == updated[new_offset:].split(b'\n', 1)[0]
        checked += 1
print('Real Codex format, message preservation, and saved offsets checked:', checked)

with tempfile.TemporaryDirectory(prefix='dumc-migration-verification-', dir='/private/tmp') as temporary:
    root = Path(temporary)
    m.HOME = root / 'home'
    m.OLD = str(root / 'repository')
    m.NEW = str(root / 'archive/repository-archive')
    old = Path(m.OLD)
    old.mkdir()
    subprocess.run(['git', 'init', '-q', str(old)], check=True)
    (old / 'README.txt').write_text('Original repository contents\n')
    subprocess.run(['git', '-C', m.OLD, 'add', 'README.txt'], check=True)
    subprocess.run(['git', '-C', m.OLD, '-c', 'user.name=Verification', '-c', 'user.email=verification@example.invalid', 'commit', '-qm', 'Initial'], check=True)
    external = root / 'worktree'
    subprocess.run(['git', '-C', m.OLD, 'worktree', 'add', '-qb', 'linked', str(external)], check=True)
    (old / 'untracked.txt').write_text('Preserve uncommitted work\n')
    wtmeta = old / '.git/worktrees'
    original_link = (external / '.git').read_bytes()

    def write(p, data):
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(data)
    def jsonl(p, records):
        write(p, ''.join(json.dumps(r) + '\n' for r in records))
    codex = m.HOME / '.codex'
    codex.mkdir(parents=True)
    rollout = codex / 'sessions/one.jsonl'
    records = [
        {'type': 'session_meta', 'payload': {'id': 'one', 'cwd': m.OLD}},
        {'type': 'response_item', 'payload': {'text': 'Historical path: ' + m.OLD}},
        {'type': 'turn_context', 'payload': {'cwd': m.OLD, 'sandbox_policy': {'writable_roots': [m.OLD]}}},
        {'type': 'response_item', 'payload': {'text': 'Tool result must retain ' + m.OLD}}
    ]
    jsonl(rollout, records)
    original_rollout = rollout.read_bytes()
    starts = [0]
    for line in original_rollout.splitlines(keepends=True):
        starts.append(starts[-1] + len(line))
    with sqlite3.connect(codex / 'state_5.sqlite') as c:
        c.executescript('create table threads(id text,cwd text,rollout_path text,sandbox_policy text,agent_path text); create table project_roots(path text);')
        c.execute('insert into threads values(?,?,?,?,?)', ('one', m.OLD, str(rollout), json.dumps({'writable_roots':[m.OLD]}), None))
        c.execute('insert into project_roots values(?)', (m.OLD,))
    with sqlite3.connect(codex / 'thread_history_1.sqlite') as c:
        c.executescript('create table thread_turns(thread_id text,rollout_byte_offset integer,rollout_end_byte_offset integer); create table thread_history_projection_state(thread_id text,next_rollout_byte_offset integer); create table thread_items(item_json text);')
        c.execute('insert into thread_turns values(?,?,?)', ('one', starts[1], starts[4]))
        c.execute('insert into thread_history_projection_state values(?,?)', ('one', starts[4]))
        c.execute('insert into thread_items values(?)', (json.dumps({'text': m.OLD}),))
    write(codex / 'config.toml', '[projects.' + json.dumps(m.OLD) + ']\ntrust_level = "trusted"\n')
    cf = m.HOME / '.claude/projects' / m.re.sub('[^A-Za-z0-9]', '-', m.OLD)
    pf = m.HOME / '.pi/agent/sessions' / ('--' + m.OLD.strip('/').replace('/', '-') + '--')
    jsonl(cf / 'one.jsonl', [{'type':'user','cwd':m.OLD,'message':{'text':m.OLD}}])
    jsonl(pf / 'one.jsonl', [{'type':'session','cwd':m.OLD,'parentSession':str(pf / 'parent.jsonl')}, {'type':'message','message':{'text':m.OLD,'toolArgs':{'cwd':m.OLD}}}])
    write(m.HOME / '.claude.json', json.dumps({'projects':{m.OLD:{'setting':'keep'}},'githubRepoPaths':{'test':[m.OLD]}}))
    jsonl(m.HOME / '.claude/history.jsonl', [{'project':m.OLD,'display':m.OLD}])
    jsonl(m.HOME / '.local/share/amp/history.jsonl', [{'cwd':m.OLD,'text':m.OLD}])
    amp = m.HOME / '.local/share/amp/threads/one.json'
    write(amp,json.dumps({'env':{'initial':{'trees':[{'uri':'file://' + m.OLD}]}},'messages':[{'text':m.OLD}]}))
    pointer = m.HOME/'.local/share/amp/last-threads/old-path.json'
    write(pointer,json.dumps('one'))
    t3 = m.HOME / '.t3/userdata/state.sqlite'
    t3.parent.mkdir(parents=True)
    with sqlite3.connect(t3) as c:
        c.executescript('create table projection_projects(project_id text,workspace_root text); create table projection_threads(project_id text,worktree_path text); create table orchestration_events(event_type text,payload_json text); create table provider_session_runtime(runtime_payload_json text);')
        c.execute('insert into projection_projects values(?,?)', ('project',m.OLD))
        c.execute('insert into orchestration_events values(?,?)', ('project.created',json.dumps({'workspaceRoot':m.OLD})))
        c.execute('insert into orchestration_events values(?,?)', ('thread.message-sent',json.dumps({'text':m.OLD})))
        c.execute('insert into provider_session_runtime values(?)', (json.dumps({'cwd':m.OLD}),))
    opencode = m.HOME / '.local/share/opencode/opencode.db'
    opencode.parent.mkdir(parents=True)
    with sqlite3.connect(opencode) as c:
        c.executescript('create table project(worktree text,sandboxes text); create table session(directory text,path text); create table session_v2(directory text,path text);')
        c.execute('insert into project values(?,?)',(m.OLD,json.dumps([m.OLD+'/linked'])))
        c.execute('insert into session values(?,?)',(m.OLD,m.OLD))
    journal = m.Journal(root / 'backup')
    journal.save(wtmeta)
    journal.save(external / '.git')
    journal.save(codex / 'config.toml')
    if os.environ.get('PCO_VERIFY_NO_CLAUDE'):
        shutil.rmtree(cf)
    expected_folders = [str(m.remap(str(p))) for p in [cf, pf] if p.exists()]
    result = m.migrate(journal, [('one',str(rollout),m.OLD)], [amp])
    journal.rename(m.OLD,m.NEW)
    subprocess.run(['git','-C',m.NEW,'worktree','repair'],check=True)
    m.verify([('one',str(rollout),m.OLD)], expected_folders)
    assert (Path(m.NEW)/'untracked.txt').read_text() == 'Preserve uncommitted work\n'
    assert subprocess.check_output(['git','-C',str(external),'rev-parse','--show-toplevel'],text=True).strip() == str(external)
    assert json.loads(amp.read_text())['env']['initial']['trees'][0]['uri'] == 'file://' + m.NEW
    assert json.loads(amp.read_text())['messages'][0]['text'] == m.OLD
    assert not pointer.exists()
    moved_pi = m.HOME / '.pi/agent/sessions' / ('--' + m.NEW.strip('/').replace('/', '-') + '--') / 'one.jsonl'
    pi_rows = [json.loads(l) for l in moved_pi.read_text().splitlines()]
    assert pi_rows[0]['parentSession'] == str(moved_pi.parent / 'parent.jsonl')
    assert pi_rows[1]['message']['toolArgs']['cwd'] == m.OLD
    with sqlite3.connect(opencode) as c:
        assert json.loads(c.execute('select sandboxes from project').fetchone()[0]) == [m.NEW + '/linked']
    with sqlite3.connect(t3) as c:
        assert json.loads(c.execute("select payload_json from orchestration_events where event_type='thread.message-sent'").fetchone()[0])['text'] == m.OLD
        assert json.loads(c.execute('select runtime_payload_json from provider_session_runtime').fetchone()[0])['cwd'] == m.NEW
    with sqlite3.connect(codex/'thread_history_1.sqlite') as c:
        a,b = c.execute('select rollout_byte_offset,rollout_end_byte_offset from thread_turns').fetchone()
        moved_bytes=rollout.read_bytes()
        assert moved_bytes[a:b].splitlines()[0] == original_rollout[starts[1]:starts[4]].splitlines()[0]
        assert c.execute('select next_rollout_byte_offset from thread_history_projection_state').fetchone()[0] == len(moved_bytes)
        assert json.loads(c.execute('select item_json from thread_items').fetchone()[0])['text'] == m.OLD
    m.rollback(root/'backup')
    assert Path(m.OLD).exists() and not Path(m.NEW).exists()
    assert (external/'.git').read_bytes() == original_link
    assert rollout.read_bytes() == original_rollout
    assert json.loads(pointer.read_text()) == 'one'
    with sqlite3.connect(codex/'state_5.sqlite') as c:
        assert c.execute('select cwd from threads').fetchone()[0] == m.OLD
    print('PASS: all six stores, linked worktree repair, uncommitted files, history preservation, offset repair, and rollback')
