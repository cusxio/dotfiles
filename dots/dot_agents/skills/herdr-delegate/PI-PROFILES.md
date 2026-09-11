# Pi child execution profiles

The official `herdr` skill owns pane creation and agent control. This reference owns only Pi launch configuration. Consult installed `pi --help` and `pi --list-models` before resolving a profile.

## Subscription-only routing

Use `openai-codex` with an explicit model ID and thinking level. Starting preferences migrated from the user's previous configuration:

| Specialist | Model ID | Thinking |
|---|---|---|
| Search | `gpt-5.6-terra` | low |
| Read Session | `gpt-5.6-terra` | low |
| Reviewer | `gpt-5.6-terra` | medium |
| Librarian | `gpt-5.6-sol` | off |
| Implementer | `gpt-5.6-sol` | low |
| Oracle | `gpt-6-astra` | xhigh |

These are preferences, not availability or authentication guarantees. Verify them against the installed catalog. For harder implementation/review tasks, select a stronger available subscription model or higher supported thinking and record that choice. If the preferred model is unavailable, ask before substituting; authentication/quota failures never authorize paid API fallback.

## Tools and resources

- Strict local inspection: `read,grep,find,ls`. Parent provides the diff and captures the terminal result.
- Inspection with child-published results: add `write`, restricted by instructions to the assignment result path. This is a repository-read-only policy, not enforced filesystem isolation.
- Implementation: `read,grep,find,ls,bash,edit,write`, with explicit write ownership and permitted commands.
- External research: explicitly enable only reviewed research extensions and their tool names. Confirm any separate search-provider billing is authorized; ChatGPT model authentication does not cover external services.

Disable extension, skill, and prompt-template discovery. Explicitly load the local Herdr Pi integration if required for recognition. Locate it using installed Herdr integration documentation/status inside the managed session; if it is missing, report the prerequisite rather than enabling every extension or installing integrations without approval.

Preserve applicable project context. Read capability instructions explicitly from the assignment; use `--skill` only for selected skills whose full workflow is compatible with a non-delegating child.

## Launch shape

After creating the sibling pane through the official skill, pass native Pi arguments after Herdr's `--` separator. Resolve all variables first and quote arguments; never execute assignment prose through `eval`.

```bash
herdr agent start "$AGENT_NAME" --kind pi --pane "$CHILD_PANE" -- \
  --provider openai-codex --model "$MODEL_ID" --thinking "$THINKING" \
  --tools "$TOOLS" \
  --no-extensions -e "$HERDR_PI_INTEGRATION" \
  --no-skills --no-prompt-templates \
  --session-dir "$ASSIGNMENT_DIR/sessions" \
  --name "$ASSIGNMENT_ID"
```

Omit `-e` only if the installed recognition mechanism demonstrably works without that integration. Add explicit reviewed extensions/skills as necessary. Check startup evidence for the effective provider/model and resource configuration before submitting the handoff. Readiness does not prove model authentication; an accepted model turn supplies that evidence.

Use a fresh persisted session by default. Record the exact child session file/ID once available, alongside the Herdr identity. For continuation after exit, use only the verified session file/ID, saved cwd, and recorded profile; never `--continue` or a guessed display name. Confirm the old process is no longer writing the session before opening it elsewhere.

Submit the assignment path using the official skill's prompt command. Bounded waits are for immediate dependencies; background submission returns control and requires explicit later collection. Result files, not terminal lifecycle badges, carry the review or implementation outcome.
