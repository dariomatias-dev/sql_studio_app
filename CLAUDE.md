# CLAUDE.md

Working agreement for agents contributing to SQL Studio.

## Commands

```
fvm flutter pub get              # resolve dependencies
fvm dart format lib/ test/       # format
fvm flutter analyze              # static analysis
fvm flutter test                 # unit and widget tests
fvm flutter test --coverage      # tests with coverage/lcov.info
fvm flutter gen-l10n             # regenerate lib/l10n/app_localizations*.dart

scripts/check_l10n.sh                          # ARB key parity across locales
scripts/check_coverage.sh coverage/lcov.info 91  # coverage floor, lib/l10n excluded
scripts/verify.sh                              # the full local gate, mirrors CI
scripts/verify.sh --skip-tests                 # fast pass; never the final gate
```

Use `fvm` for every Flutter/Dart command. Falls back to the bare `flutter`/`dart`
only inside `scripts/verify.sh`, for contributors without FVM.

## Where code goes

Feature-first, MVVM over a simplified Clean Architecture. Under
`lib/src/features/<feature>/`:

- `domain/entities/` — plain classes describing the feature's data. No
  persistence concerns.
- `domain/repositories/` — abstract contracts the presentation layer depends on.
- `domain/usecases/` — only when real logic composes more than one repository
  call (`DeleteDatabaseUseCase`, the advanced-suggestion reorder/reset/save-all).
  A class that forwards one call to one repository is not a use case; call the
  repository directly from the view model instead.
- `data/mappers/` — `fromMap`/`toMap` between an entity and its persistence map.
- `data/datasources/`, `data/repositories/` — the repository implementation and
  what it talks to.
- `data/providers/<feature>_data_providers.dart` — datasource and repository DI.
- `presentation/view_models/` — a `Notifier`/`AsyncNotifier` plus its immutable
  state. Derived state (filtering, splitting a list) lives on the state object
  as a getter, not as a mutable field on the notifier.
- `presentation/<feature>_providers.dart` — view model providers and any
  feature-local use case providers.
- `presentation/screens/`, `presentation/widgets/` — UI.

Code shared across features lives in `lib/src/shared/`. App-wide services,
routing, theming and cross-feature providers live in `lib/src/core/`
(`core/providers/core_providers.dart` for anything more than one feature reads).

Design tokens and presentation-agnostic widgets (buttons, cards, dialogs,
states) live in `packages/app_ui`, a local package imported as
`package:app_ui/app_ui.dart`. A widget belongs there only if it has no
dependency on `AppLocalizations`, a Riverpod provider, routing, or any other
app-specific type; one that needs an app default takes it as a parameter
(`ErrorDialogWidget.dismissLabel`) instead of reading it internally. Anything
with that coupling — `CancelButtonWidget`, for one — stays in
`lib/src/shared/` even if it looks generic.

A feature never imports another feature's `presentation/`. If two features need
the same view model or service, it belongs in `core/` or `shared/`.

## Conventions

- Format with `fvm dart format` after every edit; never hand-format.
- Minimal comments: explain why, not what. No em dashes in comments or commit
  messages.
- Prefer a small number of direct calls over introducing a wrapper method for a
  one-line body.
- `Result<T>` (`lib/src/core/error/result.dart`) is sealed: match it with `when`
  or a `switch`, never `is SuccessResult`/`is FailureResult` chains.
- Every user-facing string goes through `AppLocalizations`; add the key to all
  three ARB files (`en`, `es`, `pt`) with a `description`, then run `gen-l10n`.
- Log through `AppLogger` (`core/logging/`), never construct a `Logger`
  directly. Never log SQL text, database names or other user data.

## Tests

Anything with logic gets a test, in the mirrored path under `test/`.

| What | Test |
| --- | --- |
| Repository, mapper, use case, service | Unit test against a fake or an in-memory implementation. |
| View model | Unit test driving the notifier through its states, with provider overrides. |
| Screen or widget | Widget test, using the fixtures in `test/test_helpers/`. |
| End-to-end flow across features | `integration_test/`, using the harness in `integration_test/test_helpers/app_harness.dart`. Runs on a real Android device or the CI emulator; assert on rendered content, never on a toast or on `go_router`'s navigation state. |

Coverage is enforced, not advisory: 91% minimum, checked by `scripts/check_coverage.sh` (`lib/l10n/` excluded).

## Ripple effects

Ask these on every change, and act on the ones that apply:

- **A user-visible capability changed?** Update `README.md`, `README.es.md` and
  `README.pt-BR.md`.
- **The structure, a layer boundary or a convention changed?** Update
  `docs/architecture.md`, in all three languages.
- **The workflow, the checks or the tooling changed?** Update
  `docs/contributing.md`, in all three languages.
- **The test count or the coverage floor changed?** The README's Testing
  section quotes both.
- **A script gained, lost or changed behavior?** The README's Scripts table.
- **A dependency was added or removed?** `pubspec.yaml`.
- **A CI job changed?** `docs/contributing.md` documents the jobs; `act
  pull_request` (pinned by `.actrc`) runs them locally first.

Documentation ships in English, Spanish and Portuguese (BR). A doc change in
one language and not the other two is a broken change.

## Commit messages

Conventional Commits, enforced by `.githooks/commit-msg`
(`git config core.hooksPath .githooks` to enable it locally). Scope vocabulary:

- features: `database`, `database-visualizer`, `sql-editor`, `sql-suggestions`,
  `workspace-layout`, `app-version`
- core areas: `core`, `navigation`, `routes`, `theme`, `l10n`, `sql-execution`,
  `default-database`, `shared-preferences`
- cross-cutting: `shared`, `app-ui`, `deps`, `ci`, `scripts`, `docs`, `release`

Scope is optional; prefer the narrowest one that fits. Lowercase and hyphenated,
never underscored (`sql-editor`, not `sql_editor`).

## Working a plan

When working from a numbered plan: one step is one commit. At the end of a step,
run `scripts/verify.sh`, state what changed and what was verified, propose the
commit message, and stop for review. Do not start the next step in the same
turn.

## Hooks

`.claude/settings.json` wires two local hooks:

- `PostToolUse` runs `scripts/format_edited_file.sh` after every `Edit`/`Write`,
  formatting the touched file if it's Dart.
- `Stop` runs `scripts/verify_stop_gate.sh`, which blocks ending a turn unless
  `scripts/verify.sh` has passed against the current `lib/`, `test/` and config
  state. It compares `scripts/workspace_hash.sh` against the stamp `verify.sh`
  writes to `.claude/verify-stamp` (gitignored) on a full pass; `--skip-tests`
  clears the stamp instead of writing it, since it is not the final gate.
