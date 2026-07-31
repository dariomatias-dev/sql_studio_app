# Changelog

All notable changes to this project are documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [0.3.0] - 2026-07-31

### Added
- Light, dark, and system theme support.
- Search filter on the databases list.
- Empty states for query execution in the console.
- Navigate-to-table action from the database visualizer's schema diagram.
- Toast confirmation for database actions.
- Localized screenshots generated for each README.

### Changed
- Migrated `AppColors` to a `ThemeExtension`.
- `DatabaseManager` injected through Riverpod dependency injection.
- Per-table `PRAGMA` queries now run concurrently.
- Upgraded `flutter_riverpod` to v3, `go_router`, `package_info_plus`, and `share_plus`.
- Expanded test coverage across database, screens, navigation, and SQL workspace.

### Fixed
- Complete repaint checks and SQL type detection after comments.
- Reuse shared database connections for seed and reset instead of opening new ones.
- Closed stale database handles and improved SQL statement-splitting safety.
- Adopted the `Result`/`Failure` repository contract in SQL suggestions and the database visualizer.
- Removed duplicate favorite toggle logic, SQL execution service provider, and dead code.
- Auto-dispose the database visualizer view model provider and recover from load errors.
- Prevented stuck loading state and undisposed controllers in shared widgets.
- Reset the suggestions-settings change baseline after updates.
- Improved root drawer state handling and dialog behavior.

## [0.2.0] - 2026-07-26

### Added
- About screen with an app info card and a custom third-party licenses viewer.
- SQL editor download/export and load-last-query actions, plus copy schema/seed to clipboard.
- Database visualizer relation tracing and automatic diagram fit-to-viewport on load.
- Transitions and micro-animations across screens and components.
- English, Portuguese (Brazil), and Spanish README, CONTRIBUTING.md, and a GitHub Actions CI workflow.
- Automated screenshot capture script for the README, Play Store listing, and official website.
- Widget and unit test coverage across repositories, view models, use cases, and shared components.

### Changed
- Migrated app state management from Provider to Riverpod.
- Restructured the codebase into a feature-first architecture with core/features/shared layers.
- Redesigned the app UI with a centralized black-and-white minimal visual identity: unified colors, shadows, radii, and screen backgrounds.
- Redesigned the splash screen, switch component, popup menu headers, and suggestion FAB/button.
- Standardized toast notifications and loading/error/empty state widgets across the app.
- Simplified dialog presentation and separated query/database actions in the SQL editor.
- Adopted `very_good_analysis` lint rules.

### Fixed
- Adaptive app icon rendering.
- Editor losing focus incorrectly after overlays close.
- Bottom navigation label and padding issues.
- Floating navigation bar and workspace clipping behavior.
- Default color palette leaking through instead of the app theme.
- Database visualizer caching and table name casing/preview issues.
- External vs. internal link handling in Settings.
- SQL suggestion labels and default advanced suggestion seeding.

## [0.1.1] - 2025-12-03

### Added
- Advanced SQL suggestions (management screen and add/remove/reset dialogs).
- Full internationalization (English, Spanish, Portuguese) across screens, dialogs, and notifiers.
- Language switching support and a language selector.
- Contact option and a global URLs class in Settings.
- `DatabaseSuccess` result type and result handling in `SqlExecutionService`.
- Versioned schema/seed execution in `DefaultDatabaseInitializer`.
- Option to view database structure from the database card.

### Changed
- Refactored SQL execution result handling in the console widget.
- Repositioned `SharedPreferencesService` loading and app language initialization.
- Renamed and repositioned `TableInfo`/`ColumnInfo` models.

### Fixed
- Various translation issues across the app.

## [0.1.0] - 2025-10-26

### Added
- Initial application structure: navigation, drawer, and routing.
- Database creation, listing, favoriting, and deletion.
- SQL editor and console workspace.
- Basic SQL suggestions.
- Settings screen and reusable dialog/button components.
