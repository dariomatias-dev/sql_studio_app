import 'package:sql_studio/src/core/enums/app_localizations_key.dart';

/// Describes a bundled default (sample) database available to seed.
class DefaultDatabaseModel {
  /// Creates a default database description.
  const DefaultDatabaseModel({
    required this.name,
    required this.labelKey,
    required this.descriptionKey,
    required this.tables,
    this.version = 1,
  });

  /// Underlying database file name, used to locate schema/seed assets.
  final String name;

  /// Localization key for the display label.
  final AppLocalizationsKey labelKey;

  /// Localization key for the description text.
  final AppLocalizationsKey descriptionKey;

  /// Names of the tables created by this database's schema.
  final List<String> tables;

  /// Seed version of this database. Bump it to re-seed this database
  /// alone on the next launch, discarding the user's edits to it.
  final int version;
}
