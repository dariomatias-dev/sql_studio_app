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
scripts/check_coverage.sh coverage/lcov.info 86  # coverage floor, lib/l10n excluded
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

## Commit messages

Conventional Commits, enforced by `.githooks/commit-msg`
(`git config core.hooksPath .githooks` to enable it locally). Scope vocabulary:

- features: `database`, `database-visualizer`, `sql-editor`, `sql-suggestions`,
  `workspace-layout`, `app-version`
- core areas: `core`, `navigation`, `routes`, `theme`, `l10n`, `sql-execution`,
  `default-database`, `shared-preferences`
- cross-cutting: `shared`, `deps`, `ci`, `scripts`, `docs`, `release`

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
