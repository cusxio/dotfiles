# Global Pi Instructions

## Specialist delegation

Use subagents when they keep retrieval or reasoning out of the main context:

- Use `Search` for codebase discovery, symbols, callsites, and relevant tests.
- Use `Oracle` for difficult debugging, architecture, planning, and critical review.
- Use `Librarian` for external libraries, upstream source, APIs, and documentation.
- Run independent specialist requests concurrently.
- Give each specialist a self-contained prompt with the exact question and constraints.
- Treat specialist output as evidence or advice; verify it before making changes.
