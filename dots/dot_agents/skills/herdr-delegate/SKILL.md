---
name: herdr-delegate
description: "Delegate bounded work to Pi specialists, collect results, or continue an assignment. Load whenever delegation is warranted inside Herdr, including agent-selected delegation and explicit subagent requests. Requires a Herdr-managed parent pane; results are collected explicitly."
---

# Herdr delegation

Use independent Pi sessions in sibling panes. The parent owns assignments and pulls results into its context through file reads. This skill supplies a workflow, not an async runtime or permission sandbox.

## 1. Establish scope and availability

- This is the default delegation workflow inside Herdr. Keep small tasks local; delegation must have a concrete question or deliverable.
- Check `test "${HERDR_ENV:-}" = 1` before any Herdr control command. If it fails, work locally when feasible or ask the user to start the parent inside Herdr.
- Load the globally installed `herdr` skill completely before controlling panes or agents. Resolve its path from discovered skills (normally `~/.agents/skills/herdr/SKILL.md`). If missing, report the prerequisite and offer `npx skills add herdrdev/herdr --skill herdr -g`; do not silently install it. The official skill owns Herdr command syntax, readiness, IDs, and terminal safety.
- This workflow intentionally requests result files upfront, overriding the official skill's terminal-first output preference for these assignments only. Its other safety rules remain applicable.
- Read [PI-PROFILES.md](PI-PROFILES.md) before launching a child.
- For collection or continuation, inspect the existing assignment record first. Reuse findings and the exact live child where appropriate instead of launching a duplicate.

Completion: a bounded deliverable, an authorized execution method, and a verified Herdr caller context.

## 2. Choose the specialist and execution profile

Read [SPECIALISTS.md](SPECIALISTS.md). Choose one specialist per deliverable; parallelize only independent scopes. The parent remains the sole orchestrator. Children do not delegate.

Resolve an actual Pi model using `pi --list-models` and the installed help. Use only the `openai-codex` ChatGPT subscription route, with an explicit model and thinking level. Amp's marketing model names are not Pi model IDs. Catalog presence is not proof of working authentication: verify the child reports the expected provider/model and observe an accepted turn. On authentication, quota, or model failure, stop and report it; never fall back to a paid API or another provider.

Use explicit tools and resource loading. Disable general extension and skill discovery; load only reviewed necessities, including the local Herdr Pi integration if required for detection. Preserve project instructions. If those instructions require tools or orchestration excluded by the profile, report the conflict rather than silently bypassing them.

For repository-read-only specialists, use `read,grep,find,ls` and have the parent supply a fixed diff when needed. Result-file publication requires `write`: adding it makes read-only behavior a policy, not an enforced filesystem restriction. Disclose this distinction. If strict read-only tools are required, retain the restricted profile and let the parent capture the terminal answer into the result file instead. Do not enable shell access just to publish results.

Completion: record the exact provider/model, thinking, tools, extensions, capability instructions, and write policy.

## 3. Prepare a durable handoff

Create a unique private assignment directory outside the repository, for example with `mktemp -d "${TMPDIR:-/tmp}/herdr-delegate.XXXXXXXX"`. Runtime artifacts are local working data, not tracked skill files. Record its absolute path in the parent conversation; temporary storage is not an archive.

Create `assignment.md` containing:

- Assignment ID (the unique directory basename), parent Pi session ID/file when available, and caller Herdr pane/workspace IDs.
- Specialist, exact execution profile, absolute cwd, and source revision or dirty-worktree baseline.
- One goal, explicit scope and non-goals, relevant context, and acceptance criteria.
- Absolute paths to capability instructions and input artifacts. Explicitly require the child to read them before working; discovery alone does not load instructions.
- Absolute `result.md` path and the result contract below.
- Write ownership, allowed verification commands, and no nested delegation.

Use explicit revisions for reviews. For uncommitted changes, preserve a diff snapshot and identify relevant untracked files; exclude credentials and unrelated sensitive material. Do not modify the reviewed scope while the child relies on live files. If an immutable snapshot or worktree is needed, obtain approval for that location first.

Only one writer may work in a cwd at a time, including the parent. Concurrent implementation requires explicitly approved separate worktrees. No automatic commits, merges, or trust approvals.

Completion: a complete handoff on disk, with an unambiguous source baseline and result destination.

## 4. Launch and submit once

Follow the official `herdr` skill to create a no-focus sibling pane in the approved cwd, then start Pi with PI-PROFILES.md. Save returned pane identity and live name in `assignment.md` before submitting work. Save the exact Pi session identity when available; a friendly agent name is not a durable session identifier.

Send a short prompt telling the child to read the absolute assignment path and referenced capability instructions, execute that assignment, and publish its result. Treat prompt submission, observed activity, settled state, and usable result as separate evidence.

- If the result is needed now, use a bounded Herdr wait and then collect.
- For background work, submit without waiting, retain the identity record, and return control. Tell the user the assignment is running and needs explicit collection. Do not promise automatic completion notification.
- On timeout, blocked state, unknown state, or stalled submission, inspect before acting. Never blindly resend a possibly delivered assignment.

Completion: recorded launch/submission evidence, or a reported blocker with retained diagnostic context.

## 5. Collect and evaluate

Inspect the exact child and read `result.md` through the parent's file tool. That read is the return channel into the parent context. If the child is still working, treat any existing file as provisional. Herdr `idle`/`done` alone is not assignment success.

Require this result contract:

```text
# Result
Assignment: <exact assignment ID>
Status: complete | blocked | failed

## Outcome
Answer, findings, or changes made.

## Evidence
File/line references, source revisions, URLs, or relevant observations.

## Verification
Checks actually performed and outcomes; explicitly identify checks not run.

## Remaining issues
Uncertainties, blockers, and the exact question needed to proceed.

End of result: <exact assignment ID>
```

The child writes the full result only when ready to hand back control, then prints the assignment ID, status, and absolute path. The closing marker is a completeness check, not a guarantee of correctness or atomic publication. Require settled-state evidence plus a matching ID and complete result before accepting the handoff. Inspect terminal output if the file is missing, incomplete, or inconsistent.

For strict read-only children, collect terminal output and preserve it as a parent-written result with capture provenance. If the answer is truncated, request smaller numbered sections and collect all of them; do not pretend missing text was reviewed.

Evaluate evidence against acceptance criteria. For implementation, inspect the actual diff and verification results before declaring success. Update the record with the observed outcome and what the parent accepted. Summarize the useful findings to the user, including residual risks.

Completion: the parent consumed and evaluated the result, or accurately reported incomplete/blocked work.

## 6. Continue or retain

- For a clarification, reply to the exact idle child and keep the assignment ID. Archive the previous result before resubmission so it cannot be mistaken for the new answer.
- For a new deliverable, create a new assignment directory and ID. Reuse the exact idle child session when its context remains relevant, or start fresh for independent review.
- After a restart or compaction, use the record to rediscover live state. If exact identity cannot be verified, ask the user; never bind stale metadata to a new occupant.
- Leave panes, sessions, and artifacts available by default. Close only resources this workflow created, and only when the user requests cleanup. Keep partial work and diagnostics on failure.
