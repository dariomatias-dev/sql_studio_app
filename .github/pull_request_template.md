## What

<!-- What this change does, in a sentence or two. Link the issue it came from. -->

Closes #

## Why

<!-- The problem it solves. Skip only if the "What" already makes it obvious. -->

## Checklist

Tick what applies, delete what does not, and say why for anything left out.

**Code**

- [ ] Follows the existing structure: feature-first, `data`/`domain`/`presentation`, Riverpod for state (see `CLAUDE.md`)
- [ ] No inline colors, spacing, radii or text styles: everything comes from the shared design tokens
- [ ] No hardcoded user-facing text
- [ ] `Result<T>` matched with `when`/`switch`, never `is SuccessResult`/`is FailureResult`
- [ ] Logging goes through `AppLogger`; no SQL text, database names or other user data logged

**Tests**

- [ ] New logic has tests (repository, use case, view model, widget behaviour)
- [ ] A bug fix has a test that fails without the fix

**Generated and localized**

- [ ] `gen-l10n` re-run, output committed
- [ ] New strings added to all three ARB files (`en`, `es`, `pt`), each with a `description`

**Documentation**

- [ ] Docs in `docs/` updated in all three languages, if the change touched behaviour, structure or tooling
- [ ] README scripts table still accurate

**Gate**

- [ ] `./scripts/verify.sh` passes locally
- [ ] `act pull_request` run, if this touches `.github/workflows/`

## Notes for the reviewer

<!-- Anything deliberately left out, a trade-off taken, or a place worth a closer look. -->
