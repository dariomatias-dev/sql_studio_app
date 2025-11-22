// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get general => 'General';

  @override
  String get language => 'Language';

  @override
  String get sqlSuggestions => 'SQL Suggestions';

  @override
  String get workspaceLayout => 'Workspace Layout';

  @override
  String get information => 'Information';

  @override
  String get appVersion => 'App Version';

  @override
  String get officialWebsite => 'Official Website';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get errorOpeningUrl => 'Error opening URL';

  @override
  String errorOpeningUrlDescription(Object url) {
    return 'The URL $url could not be opened.';
  }
}
