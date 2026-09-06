# Architecture

<p align="center">
<strong>English</strong> · <a href="architecture.es.md">Español</a> · <a href="architecture.pt-BR.md">Português (BR)</a>
</p>

This document goes one level deeper than the README's overview. It's aimed at anyone changing code in this repo: where a file belongs, why a layer exists, and how the pieces talk to each other.

## Layout

```
lib/
  main.dart                 # composition root: error boundary, ProviderScope, startup fallback
  src/
    core/                   # cross-cutting concerns, shared by every feature
      database/             # DatabaseManager (the app's own SQLite file) + generic CRUD repository
      error/                 # Result/Failure, the global error handlers
      logging/               # AppLogger contract and its implementation
      navigation/             # nav bar, drawer, tab shell
      providers/              # core_providers.dart: services more than one feature reads
      routes/                 # go_router config, typed navigation helpers
      screens/                 # settings, about, splash, not-found, startup failure
      services/                # SqlExecutionService, DefaultDatabaseService, SharedPreferencesService
      sql/                     # the shared SQL statement splitter
      app_colors/app_spacing/app_radii/app_shadows/app_durations/app_theme.dart  # design tokens
    features/
      <feature>/
        domain/
          entities/          # plain classes describing the feature's data
          repositories/       # abstract contracts
          usecases/            # only where real logic composes more than one repository call
        data/
          mappers/            # fromMap/toMap between an entity and its persistence map
          datasources/         # what a repository implementation talks to
          repositories/        # the repository implementation
          providers/           # <feature>_data_providers.dart: datasource/repository DI
        presentation/
          view_models/         # a Notifier/AsyncNotifier plus its immutable state
          screens/, widgets/    # UI
          <feature>_providers.dart  # view model providers, feature-local use case providers
    shared/                  # code shared across features: widgets, utils
```

Features: `database` (the user's saved databases), `database_visualizer` (the schema diagram), `sql_editor` (the code editor and console), `sql_suggestions` (basic/advanced snippets), `workspace_layout_settings`, `app_version`.

## Layering (Clean Architecture + MVVM)

- **`domain`**: plain Dart. Entities, abstract repository interfaces, and use-case classes for the handful of operations with real branching logic (`DeleteDatabaseUseCase` closes the connection, drops the file, and removes the record; the advanced-suggestion reorder/reset/save-all use cases compose more than one repository call). Everything else is a repository method a view model calls directly: a class that only forwards one call to one repository is not a use case.
- **`data`**: implements the `domain` repository interfaces against a concrete data source (a `DatabaseRepository<T>` bound to a table, `SharedPreferencesService`, or `SqlExecutionService`). Mappers convert between a persistence map and a domain entity.
- **`presentation`**: screens and widgets, plus view models: Riverpod `Notifier`/`AsyncNotifier` classes exposed through providers. A screen watches a provider; it reads a repository directly only for a one-off call triggered by a user action, never a use case that doesn't exist.

A feature never imports another feature's `presentation/`. Something more than one feature needs to share belongs in `core/` (a service, a cross-feature provider) or `shared/` (a widget, a util).

## State management

[Riverpod](https://riverpod.dev/) end to end, written by hand (no code generation): `Provider` for stateless dependencies, `NotifierProvider` for anything with behavior. Providers are grouped by role, not one file per provider: `<feature>_providers.dart` for view models, `data/providers/<feature>_data_providers.dart` for datasources and repositories, `core/providers/core_providers.dart` for anything more than one feature reads (the logger, the shared `DatabaseManager`, `SqlExecutionService`, `DefaultDatabaseService`).

## Navigation

[go_router](https://pub.dev/packages/go_router), with a bottom nav bar for the three main tabs (Home, Databases, Settings) and pushed routes for everything else (the database visualizer, the settings sub-screens). `AppRoutes` (`lib/src/core/routes/`) wraps every navigation call in a typed method instead of a raw path string.

## Persistence

Two independent things live on disk, both through [sqflite](https://pub.dev/packages/sqflite):

- **The app's own database** (`DatabaseManager`, `lib/src/core/database/`): one small SQLite file holding the app's own bookkeeping tables — the list of user-created databases and the advanced SQL suggestions. `DatabaseRepository<T>` is a generic CRUD layer bound to a table name, shared by every feature that persists here.
- **The sample and user databases themselves**: each is its own SQLite file, opened on demand by `SqlExecutionService` (`lib/src/core/services/`), which caches one connection per open database and closes them all on dispose. `DefaultDatabaseService` seeds the 14 bundled sample databases from `assets/sql/schemas/` and `assets/sql/seeds/`, versioned **per database**, not globally: bumping one sample's version re-seeds only that database, leaving the user's edits to the other thirteen untouched. An install upgrading from the old single global version key migrates it into the per-database keys without re-seeding anything.

User preferences that don't need querying (theme, locale, workspace layout, suggestion toggles) go through `shared_preferences` behind `SharedPreferencesService`.

Both the schema/seed asset loader and the console's own statement runner share one SQL statement splitter (`core/sql/sql_statement_splitter.dart`), so a semicolon inside a string literal, a comment, or a trigger's `BEGIN...END` body is handled once, not reimplemented per caller.

## Error handling

`main.dart` installs `FlutterError.onError` and `PlatformDispatcher.onError` before anything else runs, both routing into `AppLogger`, and swaps in a neutral `ErrorWidget.builder` for release builds. `startApp()` guards `SharedPreferencesService.create()` and the rest of startup: a failure there falls back to `StartupFailureApp`, a minimal app (no provider container, no localizations beyond what it needs) offering a retry and, for state that fails no matter how many times it's retried, a confirmed wipe of local data through `LocalStateService`.

Within the app, `Result<T>` (`lib/src/core/error/result.dart`) is a sealed type: a repository or service returns `SuccessResult`/`FailureResult`, and a caller matches it with `when`/`switch`, never an `is` chain. A `Failure` carries a localization key plus interpolation args; `LocalizationExtension.key()` resolves it to a real message, and a test asserts every `AppLocalizationsKey` has an entry there, so a key added without a message falls back loudly in tests instead of silently in production. `handleError()` (`shared/utils/`) is the one place a view result becomes an error dialog.

Logging goes through `AppLogger` (`core/logging/`), never a constructed `Logger` directly. `SqlExecutionService` never logs the SQL text it runs or the database name it runs against, only the statement kind and the row count, and attaches the raw exception (which embeds the failing SQL) only in debug builds.

## Testing

Unit and widget tests live under `test/`, mirroring `lib/`'s structure. `integration_test/` covers end-to-end flows against real on-device SQLite and `SharedPreferences` storage: first-run seeding, creating a database and querying it, editing a default database surviving a simulated restart, a deliberate reset, deleting a database, switching locale, and settings (theme, workspace layout, favoriting a database) surviving a restart. `test/core/providers/provider_graph_test.dart` builds the full production provider container and reads every provider, catching a wiring mistake that would otherwise only surface on a device. See the README for current test counts and the coverage threshold.
