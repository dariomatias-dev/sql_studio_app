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

  @override
  String get enterFullscreen => 'Entrar em Tela Cheia';

  @override
  String get exitFullscreen => 'Sair da Tela Cheia';

  @override
  String get editor => 'Editor';

  @override
  String get viewVisualScheme => 'Ver Esquema Visual';

  @override
  String get resetDatabase => 'Resetar Banco de Dados';

  @override
  String get runQuery => 'Executar Consulta';

  @override
  String get clearEditor => 'Limpar Editor';

  @override
  String get console => 'Console';

  @override
  String get clearConsole => 'Limpar Console';

  @override
  String get schemaCopied => 'Schema copiado!';

  @override
  String get seedCopied => 'Seed copiada!';

  @override
  String get schemaAndSeedCopied => 'Schema e Seed copiados!';

  @override
  String get viewStructure => 'Ver Estrutura';

  @override
  String get copySchema => 'Copiar Schema';

  @override
  String get copySeed => 'Copiar Seed';

  @override
  String get copyAll => 'Copiar Tudo';

  @override
  String get searchDatabases => 'Pesquisar bancos de dados';

  @override
  String get newDatabase => 'Novo Banco de Dados';

  @override
  String get favorites => 'Favoritos';

  @override
  String get allDatabases => 'Todos os Bancos de Dados';

  @override
  String get favorite => 'Favorito';

  @override
  String get unfavorite => 'Remover dos favoritos';

  @override
  String get delete => 'Excluir';
}
