// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get databases => 'Databases';

  @override
  String get settings => 'Settings';

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

  @override
  String get enterFullscreen => 'Enter Fullscreen';

  @override
  String get exitFullscreen => 'Exit Fullscreen';

  @override
  String get editor => 'Editor';

  @override
  String get viewVisualScheme => 'View Visual Scheme';

  @override
  String get resetDatabase => 'Reset Database';

  @override
  String get runQuery => 'Run Query';

  @override
  String get clearEditor => 'Clear Editor';

  @override
  String get console => 'Console';

  @override
  String get clearConsole => 'Clear Console';

  @override
  String get schemaCopied => 'Schema copied!';

  @override
  String get seedCopied => 'Seed copied!';

  @override
  String get schemaAndSeedCopied => 'Schema and Seed copied!';

  @override
  String get viewStructure => 'View Structure';

  @override
  String get copySchema => 'Copy Schema';

  @override
  String get copySeed => 'Copy Seed';

  @override
  String get copyAll => 'Copy All';
}
