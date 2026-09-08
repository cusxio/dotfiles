# Delegation budget

- Use one agent per question or deliverable. Before launching another, check active work and reuse completed findings; resume the existing agent for follow-ups when possible.
- Use `reviewer` for routine reviews. Escalate to `oracle` only for a specific unresolved question after consuming the review findings, or when the user explicitly requests Oracle. Send the findings and the remaining question rather than repeating the full review.
- Run agents in parallel only for distinct, non-overlapping questions or deliverables. Overlapping independent reviews, including Oracle plus Reviewer on the same scope, require explicit user approval; explain the added token cost before asking. An explicit request for a council or multiple independent reviews counts as approval for that scope.
- Choose `worker` or `delegate` for an implementation task, not both. Split research between `scout` (local code), `librarian` (external repositories), and `researcher` (web sources) only when each has a distinct evidence gap to fill.
- Keep small tasks in the parent session. Stop delegating when the requested result is supported; additional agents need a concrete unanswered question.
