import importlib.util
import importlib.machinery
import json
from pathlib import Path
import tempfile

spec = importlib.util.spec_from_loader('migration', importlib.machinery.SourceFileLoader('migration', str(Path.home() / '.local/bin/archive-dev')))
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
m.OLD = '/Users/x/Documents/dev/test-project'
m.NEW = '/Users/x/Documents/dev/archive/test-project-archive-2026-10-07'
with tempfile.TemporaryDirectory(dir='/private/tmp') as root:
    path = Path(root) / 'history.jsonl'
    string = json.dumps('Old prompt referencing ' + m.OLD).encode() + b'\n'
    record = json.dumps({'cwd':m.OLD,'text':'Keep original prompt ' + m.OLD}).encode() + b'\n'
    original = string + record + b'null\n42\n["saved", "prompt"]\n'
    path.write_bytes(original)
    for tool in ['amp','claude','pi','codex']:
        updated, changed, _, _ = m.transform_jsonl(path, tool)
        lines = updated.splitlines(keepends=True)
        assert lines[0] == string
        assert lines[2:] == original.splitlines(keepends=True)[2:]
        entry = json.loads(lines[1])
        assert entry['text'] == 'Keep original prompt ' + m.OLD
        assert entry['cwd'] == (m.OLD if tool == 'codex' else m.NEW)
        assert changed == (0 if tool == 'codex' else 1)
    path.write_bytes(b'\n' + original + b'\n')
    updated, _, _, _ = m.transform_jsonl(path,'amp')
    assert updated.startswith(b'\n') and updated.endswith(b'\n\n')
print('PASS: mixed JSON history preserves prompts, scalar/list records and blank lines; only directory metadata changes.')
