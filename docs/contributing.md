# Contributing

<p align="center">
<strong>English</strong> · <a href="contributing.es.md">Español</a> · <a href="contributing.pt-BR.md">Português (BR)</a>
</p>

Thanks for considering a contribution. This document covers setup, conventions, and what a pull request needs before it's ready for review. For how the codebase is organized, see [`architecture.md`](architecture.md).

## Setup

The project pins its Flutter SDK version via [FVM](https://fvm.app/), so every command below uses `fvm flutter`/`fvm dart` rather than a bare install.

```sh
git clone https://github.com/dariomatias-dev/sql_studio_app.git
cd sql_studio_app
fvm install
fvm flutter pub get
git config core.hooksPath .githooks
```

That last line points git at [`.githooks/`](../.githooks), where a `commit-msg` hook rejects a subject line that doesn't follow the convention below. Git does not share hooks through a clone, so it is one command per checkout.

Localizations aren't committed pre-built for every change. Regenerate them after pulling or editing anything under `lib/l10n/*.arb`:

```sh
fvm flutter gen-l10n
```

Run the app on a connected device or emulator with `fvm flutter run`.

## Before opening a pull request

- **Open an issue first** to discuss the change, unless it's a small, obvious fix.
- **Follow the existing structure**: feature-first, `domain`/`data`/`presentation` layers, Riverpod for state, no new patterns introduced without discussion. See [`architecture.md`](architecture.md).
- **A use case earns its place only when it composes more than one repository call.** Otherwise call the repository directly from the view model.
- **Match the design system**: no inline colors, spacing, radii, durations, or text styles. Use the tokens under `lib/src/core/` (`AppColors`, `AppSpacing`, `AppRadii`, `AppShadows`, `AppDurations`).
- **No hardcoded user-facing strings**: add the key to all three ARB files (`app_en.arb`, `app_es.arb`, `app_pt.arb`) with a `description`, then run `gen-l10n`. [`scripts/check_l10n.sh`](../scripts/check_l10n.sh) enforces key parity across them, in `verify.sh` and in CI.
- **Add tests** for anything with logic: a repository method, a use case, a view model, a widget's behavior. A bug fix should carry a test that fails without the fix.
- **Run the full check locally** before pushing:

  ```sh
  ./scripts/verify.sh
  ```

  It runs what CI runs: regenerates localizations and fails if that changed anything, `check_l10n.sh`, formatting, analysis, tests, and the coverage threshold. Uses `fvm` when set up for the project, the bare `flutter`/`dart` otherwise. Add `--skip-tests` for a faster partial pass while iterating; it is never the final gate, since it clears the local pass stamp instead of writing it.

  The same checks by hand:

  ```sh
  fvm flutter analyze
  fvm dart format --output=none --set-exit-if-changed lib/ test/
  fvm flutter test --coverage
  ./scripts/check_coverage.sh coverage/lcov.info 91
  ```

- **Commit messages** follow [Conventional Commits](https://www.conventionalcommits.org/), enforced by the `commit-msg` hook enabled during setup:

  ```
  <type>(<optional scope>): <subject>
  ```

  The type is one of `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style` or `test`. The scope, when there is one, is lowercase and hyphenated (`sql-editor`, not `sql_editor`):

  | | Scopes |
  | --- | --- |
  | features | `database`, `database-visualizer`, `sql-editor`, `sql-suggestions`, `workspace-layout`, `app-version` |
  | core areas | `core`, `navigation`, `routes`, `theme`, `l10n`, `sql-execution`, `default-database`, `shared-preferences` |
  | cross-cutting | `shared`, `deps`, `ci`, `scripts`, `docs`, `release` |

  The subject is short and imperative, starts lowercase, and carries no trailing period. Append `!` before the colon for a breaking change.

  The hook also holds the message to the shape git tooling expects: the whole subject line stays within **72 characters**, which is where `git log --oneline` and GitHub truncate it; a body is separated from the subject by a blank line, and its lines wrap at **100**. URLs and trailers such as `Co-Authored-By:` are exempt, since wrapping those breaks what they mean. Merge and revert commits are left alone.

## What CI checks

Every push and pull request runs [`.github/workflows/ci.yaml`](../.github/workflows/ci.yaml), in four jobs:

| Job | What it does |
| --- | --- |
| `quality` | Installs dependencies, regenerates localizations, then **fails if that regeneration produced a diff**, since generated files must be committed and up to date. Then `check_l10n.sh`, formatting, analysis, tests, and the coverage gate, and uploads the report to Codecov. |
| `build_apk` | Runs after `quality` passes and builds a release APK — buildable without a signing secret, since `android/app/build.gradle.kts` falls back to the debug keystore when `key.properties` is absent — uploaded as a workflow artifact kept for 14 days. |
| `integration` | Runs after `quality` passes, boots a pinned Android emulator (API 35) and runs every `integration_test/` suite on it, force-stopping the app between suites so each starts cold. These need a real device: they exercise real SQLite and `SharedPreferences` storage, including state surviving a simulated restart. The job enables KVM first and builds a debug APK before booting the emulator, since a cold Android build on its own can outrun a per-suite timeout. |
| `osv-scanner` | Scans `pubspec.lock` against the OSV database. Runs independently of the other jobs: a newly disclosed advisory with no fix available yet is not a reason to stop the tests from reporting. |

Releases are cut by [release-please](https://github.com/googleapis/release-please). It reads the Conventional Commits landed on `main` and keeps a pull request open carrying the next version and the `CHANGELOG.md` entry it derived from them. Merging that pull request writes the version into `pubspec.yaml`, tags the commit, and publishes the GitHub release.

[`.github/workflows/release.yml`](../.github/workflows/release.yml) then runs the same quality gate and attaches the release APK. It is called directly by [`release_please.yml`](../.github/workflows/release_please.yml), since GitHub does not start a workflow from a tag pushed with the default token, and it still answers a `v*.*.*` tag pushed by hand, creating the release itself in that case.

### Coverage reports

[`scripts/check_coverage.sh`](../scripts/check_coverage.sh) is what fails a build, excluding `lib/l10n/` before measuring; [Codecov](https://codecov.io/gh/dariomatias-dev/sql_studio_app) is what makes the number readable on a pull request. Uploads authenticate with a `CODECOV_TOKEN` repository secret; pull requests from forks cannot read it, so the step is deliberately set to `fail_ci_if_error: false` — a failed upload is a missing report, never a failed build.

For the same thing locally, without an account, render the `lcov` file to HTML:

```sh
fvm flutter test --coverage
genhtml coverage/lcov.info -o coverage/html   # apt install lcov
xdg-open coverage/html/index.html
```

## Working with an AI agent

The repo carries its own agent configuration, so an assistant follows the same process a contributor does instead of improvising one per prompt:

- [`CLAUDE.md`](../CLAUDE.md) is the working agreement: where code belongs, the conventions in effect, the scope vocabulary above, and the one-step-one-commit rule this project's history follows.
- [`.claude/settings.json`](../.claude/settings.json) wires two hooks: every Dart file written is formatted immediately, and a `Stop` hook refuses to end a turn while code changes have not passed `./scripts/verify.sh`.

None of it replaces CI, which stays the authority. It exists so the local pass matches what CI will say. Changing the agreement or the hooks is a normal change: update `CLAUDE.md` along with it.

## Code of Conduct

Participation in this project is governed by the [Code of Conduct](code_of_conduct.md).
