# Changelog

All notable changes to this project are documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

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
