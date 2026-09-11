# Delegation

- When delegation is warranted inside Herdr (`HERDR_ENV=1`), load `herdr-delegate` and use it as the default workflow, even when the user has not named the skill. This standing authorization includes operating Herdr for delegated work; load the official `herdr` skill for command guidance.
- Outside Herdr, work locally when feasible or ask the user to start a Herdr-managed session. Do not substitute another delegation runtime.
- Use only the ChatGPT subscription route for child Pi models. Results require explicit collection; do not promise automatic completion notification.

## Budget

- Use one agent per question or deliverable. Before launching another, check active work and reuse completed findings; resume the existing agent for follow-ups when possible.
- Use `reviewer` for routine reviews. Escalate to `oracle` only for a specific unresolved question after consuming the review findings, or when the user explicitly requests Oracle. Send the findings and the remaining question rather than repeating the full review.
- Run agents in parallel only for distinct, non-overlapping questions or deliverables. Overlapping independent reviews, including Oracle plus Reviewer on the same scope, require explicit user approval; explain the added token cost before asking. An explicit request for a council or multiple independent reviews counts as approval for that scope.
- Use `implementer` for approved source changes, `search` for local code retrieval, and `librarian` for external code or documentation. Split research only when each assignment fills a distinct evidence gap.
- Keep small tasks in the parent session. Stop delegating when the requested result is supported; additional agents need a concrete unanswered question.
