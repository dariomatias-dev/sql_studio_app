import 'package:sql_studio/src/core/enums/app_localizations_key.dart';

class DefaultDatabaseModel {
  final String name;
  final AppLocalizationsKey labelKey;
  final AppLocalizationsKey descriptionKey;
  final List<String> tables;

  const DefaultDatabaseModel({
    required this.name,
    required this.labelKey,
    required this.descriptionKey,
    required this.tables,
  });
}
