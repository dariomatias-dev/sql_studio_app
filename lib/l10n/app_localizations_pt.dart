// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get home => 'Início';

  @override
  String get databases => 'Bancos de Dados';

  @override
  String get settings => 'Configurações';

  @override
  String get general => 'Geral';

  @override
  String get language => 'Idioma';

  @override
  String get sqlSuggestions => 'Sugestões SQL';

  @override
  String get workspaceLayout => 'Layout de Trabalho';

  @override
  String get information => 'Informações';

  @override
  String get appVersion => 'Versão do App';

  @override
  String get officialWebsite => 'Site Oficial';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get errorOpeningUrl => 'Erro ao abrir URL';

  @override
  String errorOpeningUrlDescription(Object url) {
    return 'A URL $url não pôde ser aberta.';
  }
}
