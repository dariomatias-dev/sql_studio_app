import 'package:sql_studio/src/core/enums/app_localizations_key.dart';

/// Describes a bundled default (sample) database available to seed.
class DefaultDatabaseModel {
  /// Creates a default database description.
  const DefaultDatabaseModel({
    required this.name,
    required this.labelKey,
    required this.descriptionKey,
    required this.tables,
  });

  /// Underlying database file name, used to locate schema/seed assets.
  final String name;

  /// Localization key for the display label.
  final AppLocalizationsKey labelKey;

  /// Localization key for the description text.
  final AppLocalizationsKey descriptionKey;

  /// Names of the tables created by this database's schema.
  final List<String> tables;
}
