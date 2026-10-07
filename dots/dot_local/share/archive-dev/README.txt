archive-dev

Archive a direct child folder of ~/Documents/dev and migrate its local coding
history. No dependencies beyond Python 3, Git for Git repositories, and the
macOS ps/lsof utilities used to inspect coding-tool processes.

Usage:
    archive-dev /Users/x/Documents/dev/my-project
    archive-dev my-project

Destination is selected automatically using the local date:
    ~/Documents/dev/archive/my-project-archive-YYYY-MM-DD

If that destination already exists, a numeric suffix is added, starting at -2.
An ordinary invocation performs the migration. Preview without modifying files:
    archive-dev my-project --dry-run

Finish and close coding-tool sessions before applying, including Codex chats,
Pi, and T3 Code. Stores are shared across projects. Stop the Codex daemon after
closing your Codex sessions:
    codex app-server daemon stop

The tool does not kill running sessions. If a coding-tool process remains,
it lists it and exits without changing files. A dry run works with tools open.

What moves:
- The entire source folder, including hidden files and uncommitted work.
- Local Codex directory associations, rollout metadata, and saved byte offsets.
- Claude Code and Pi path-indexed history folders, including project subfolders.
- Claude project settings and prompt-history paths; Pi parent-session references.
- Amp local thread workspace metadata and prompt-history directory associations.
  Matching last-used-thread cache pointers are reset, with backups for rollback.
- T3 Code project projections, project events, and provider runtime directories.
- OpenCode current database and legacy JSON directory metadata.

Historical conversation text and tool results stay unchanged. Missing tool
histories are skipped. This supports the local store formats inspected and
tested on this machine; it does not contact cloud services or change running
Docker containers. Plain folders and Git repositories with no commits work.
Linked Git worktrees should be archived through their main repository; symlink
source folders and the archive folder itself are rejected.

Backups:
    ~/.local/share/archive-dev/backups/<name>-<timestamp>/

Each backup folder contains the originals and manifest.json. On an error the
migration automatically restores its changes. After success, the command prints
the exact manual rollback command:
    archive-dev --rollback /absolute/path/to/backup-folder

Close coding tools before rollback. If you have recreated the original source
path, move that new folder aside before rollback. Repeating an already completed
rollback does nothing.

Verification commands:
    python3 ~/.local/share/archive-dev/verify-command.py
    python3 ~/.local/share/archive-dev/verify-history.py
    python3 ~/.local/share/archive-dev/verify.py

These operate on temporary stores and folders. Tests cover normal and unborn Git
repositories, linked-worktree repair, plain folders, missing tools, subfolder
history, date collision suffixes, dry runs, mixed JSON history, SQL wildcard
characters in names, Codex byte offsets, old OpenCode metadata, Amp pointer
reset, history preservation, active-process blocking, old-path reuse, and rollback.
