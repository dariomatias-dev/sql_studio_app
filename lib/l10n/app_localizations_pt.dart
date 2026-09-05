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
  String get navHome => 'Início';

  @override
  String get navDatabases => 'Bancos';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get general => 'Geral';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String themeUpdated(Object theme) {
    return 'Tema atualizado para $theme';
  }

  @override
  String get sqlSuggestions => 'Sugestões SQL';

  @override
  String get workspaceLayout => 'Layout de Trabalho';

  @override
  String get information => 'Informações';

  @override
  String get appVersion => 'Versão do App';

  @override
  String get about => 'Sobre';

  @override
  String get appDescription =>
      'Pratique SQL no seu celular com bancos de dados SQLite locais, editáveis e totalmente offline.';

  @override
  String versionLabel(Object version) {
    return 'Versão $version';
  }

  @override
  String get licenses => 'Licenças';

  @override
  String developedBy(Object name) {
    return 'Desenvolvido por $name';
  }

  @override
  String packagesCount(Object count) {
    return '$count pacotes de código aberto';
  }

  @override
  String get officialWebsite => 'Site Oficial';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get contact => 'Contato';

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
  String get noQueryRunYet => 'Rode uma query para ver o resultado aqui';

  @override
  String get queryExecutedNoResult => 'Query executada, sem dados para exibir';

  @override
  String get schemaCopied => 'Schema copiado';

  @override
  String get seedCopied => 'Seed copiada';

  @override
  String get schemaAndSeedCopied => 'Schema e Seed copiados';

  @override
  String get viewStructure => 'Ver Estrutura';

  @override
  String get viewTableData => 'Ver dados da tabela';

  @override
  String get copySchema => 'Copiar Schema';

  @override
  String get copySeed => 'Copiar Seed';

  @override
  String get copyAll => 'Copiar Tudo';

  @override
  String get structureSection => 'Estrutura';

  @override
  String get sqlFilesSection => 'Arquivos SQL';

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

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'OK';

  @override
  String get attention => 'Atenção';

  @override
  String get deleteDatabaseConfirmation =>
      'Tem certeza de que deseja excluir permanentemente este banco de dados? Esta ação não pode ser desfeita.';

  @override
  String get toDoListLabel => 'Lista de Tarefas';

  @override
  String get toDoListDescription =>
      'Banco de dados simples para gerenciamento de tarefas';

  @override
  String get contactsLabel => 'Contatos';

  @override
  String get contactsDescription => 'Banco de dados de contatos e grupos';

  @override
  String get libraryLabel => 'Biblioteca';

  @override
  String get libraryDescription =>
      'Biblioteca com livros, membros e empréstimos';

  @override
  String get fitnessClubLabel => 'Clube de Fitness';

  @override
  String get fitnessClubDescription =>
      'Banco de dados de membros da academia e assinaturas';

  @override
  String get carRentalLabel => 'Locadora de Carros';

  @override
  String get carRentalDescription =>
      'Banco de dados de gestão de aluguel de carros';

  @override
  String get restaurantLabel => 'Restaurante';

  @override
  String get restaurantDescription =>
      'Banco de dados de pedidos e itens do menu';

  @override
  String get hrPayrollLabel => 'Folha de Pagamento';

  @override
  String get hrPayrollDescription =>
      'Departamentos, cargos, funcionários e histórico salarial';

  @override
  String get logisticsLabel => 'Logística';

  @override
  String get logisticsDescription =>
      'Banco de dados de pacotes, motoristas, entregas e histórico de status';

  @override
  String get pharmacyLabel => 'Farmácia';

  @override
  String get pharmacyDescription =>
      'Estoque da farmácia, fornecedores, clientes e vendas';

  @override
  String get schoolLabel => 'Escola';

  @override
  String get schoolDescription =>
      'Gestão escolar com alunos, professores, turmas, matrículas e notas';

  @override
  String get socialNetworkLabel => 'Rede Social';

  @override
  String get socialNetworkDescription =>
      'Plataforma social com usuários, posts, likes, comentários e seguidores';

  @override
  String get hotelLabel => 'Hotel';

  @override
  String get hotelDescription =>
      'Banco de dados de reservas, quartos, pagamentos, funcionários e serviços';

  @override
  String get bankingLabel => 'Banco';

  @override
  String get bankingDescription =>
      'Sistema bancário com contas, transações, empréstimos e funcionários';

  @override
  String get eCommerceLabel => 'E-Commerce';

  @override
  String get eCommerceDescription =>
      'Loja online com produtos, pedidos, carrinhos e avaliações';

  @override
  String get openFullscreen => 'Abrir em tela cheia';

  @override
  String get options => 'Opções';

  @override
  String get table => 'Tabela';

  @override
  String get tables => 'Tabelas';

  @override
  String get splitLayout => 'Layout Dividido';

  @override
  String get splitLayoutSubtitle => 'Editor acima e console abaixo.';

  @override
  String get tabsLayout => 'Layout em Abas';

  @override
  String get tabsLayoutSubtitle => 'Editor e console em abas.';

  @override
  String get preview => 'Pré-visualização:';

  @override
  String get layoutSaved => 'Layout salvo';

  @override
  String get suggestionSettings => 'Configurações de Sugestões';

  @override
  String get suggestionModes => 'Modos de Sugestão';

  @override
  String get basicSuggestions => 'Sugestões Básicas';

  @override
  String get basicSuggestionsDescription =>
      'Exibe exemplos SQL completos como \"SELECT * FROM\". Ideal para consultas rápidas.';

  @override
  String get advancedSuggestions => 'Sugestões Avançadas';

  @override
  String get advancedSuggestionsDescription =>
      'Mostra dicas curtas como \"ALL\" ou \"COUNT\" que se expandem para instruções SQL completas ao clicar.';

  @override
  String get otherSuggestions => 'Atalhos do Editor';

  @override
  String get characterSuggestions => 'Símbolos Rápidos';

  @override
  String get characterSuggestionsDescription =>
      'Adiciona botões rápidos para >, =, !, %, ; e mais.';

  @override
  String get saveSettings => 'Salvar Configurações';

  @override
  String get advancedSuggestionsInitialized =>
      'As sugestões avançadas foram inicializadas com sucesso';

  @override
  String get advancedSuggestionsFailed =>
      'Falha ao inicializar as sugestões avançadas';

  @override
  String get settingsSavedSuccessfully => 'Configurações salvas com sucesso';

  @override
  String get configure => 'Configurar';

  @override
  String get createSuggestion => 'Criar Sugestão';

  @override
  String get suggestionName => 'Nome da sugestão';

  @override
  String get create => 'Criar';

  @override
  String get enterSuggestionName => 'Digite um nome para a sugestão.';

  @override
  String get invalidCharacters => 'Caracteres inválidos';

  @override
  String get removeSuggestion => 'Remover Sugestão';

  @override
  String get removeSuggestionDescription =>
      'Tem certeza de que deseja remover esta sugestão?';

  @override
  String get remove => 'Remover';

  @override
  String get resetSuggestions => 'Redefinir Sugestões';

  @override
  String get resetSuggestionsDescription =>
      'Tem certeza de que deseja redefinir a lista de sugestões?';

  @override
  String get reset => 'Redefinir';

  @override
  String get advancedSuggestionAdded => 'Sugestão adicionada com sucesso';

  @override
  String get advancedSuggestionFailed => 'Falha ao adicionar sugestão';

  @override
  String deleteSuggestionConfirmation(Object label) {
    return 'Tem certeza de que deseja excluir a sugestão \"$label\"?';
  }

  @override
  String get suggestionDeleted => 'Sugestão excluída com sucesso';

  @override
  String get suggestionDeleteFailed => 'Falha ao excluir sugestão';

  @override
  String get resetSuggestionsConfirm =>
      'Tem certeza de que deseja redefinir as sugestões?';

  @override
  String get suggestionsResetSuccess =>
      'Todas as sugestões foram redefinidas com sucesso';

  @override
  String get suggestionsResetFailed =>
      'Não foi possível redefinir as sugestões. Tente novamente';

  @override
  String get label => 'Rótulo';

  @override
  String get sqlCode => 'Código SQL';

  @override
  String get selectableTextOptional => 'Texto selecionável (opcional)';

  @override
  String get selectableTextHint =>
      'Parte do SQL a ser selecionada automaticamente para substituição';

  @override
  String get fieldRequired => 'Este campo é obrigatório';

  @override
  String get updateSuggestion => 'Atualizar Sugestão';

  @override
  String get update => 'Atualizar';

  @override
  String get updateSuggestionSuccess => 'Sugestão atualizada com sucesso';

  @override
  String get updateSuggestionFail => 'Falha ao atualizar sugestão';

  @override
  String get editSuggestion => 'Editar sugestão';

  @override
  String get deleteSuggestion => 'Deletar sugestão';

  @override
  String get save => 'Salvar';

  @override
  String get exitScreen => 'Sair da tela';

  @override
  String get startupFailedTitle => 'Não foi possível iniciar o SQL Studio';

  @override
  String get startupFailedMessage =>
      'Algo deu errado ao carregar seus dados. Tente novamente ou limpe os dados do aplicativo se o problema continuar.';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get clearAppData => 'Limpar dados do aplicativo';

  @override
  String get clearAppDataConfirmation =>
      'Isso exclui permanentemente todos os bancos de dados e configurações salvos neste dispositivo. Esta ação não pode ser desfeita.';

  @override
  String get unexpectedError => 'Algo deu errado.';

  @override
  String tableRowsRange(int start, int end, int total) {
    return '$start-$end de $total';
  }

  @override
  String get error => 'Erro';

  @override
  String get failedToSaveWorkspaceLayout =>
      'Falha ao salvar o layout do espaço de trabalho. Por favor, tente novamente.';

  @override
  String databaseCreationError(Object databaseName) {
    return 'Não foi possível criar o banco de dados \"$databaseName\".';
  }

  @override
  String get fetchDatabasesError =>
      'Não foi possível obter os bancos de dados criados.';

  @override
  String get checkDatabaseExistsError =>
      'Não foi possível checar se o banco de dados já existe.';

  @override
  String deleteDatabaseError(Object databaseName) {
    return 'Não foi possível excluir o banco de dados \"$databaseName\".';
  }

  @override
  String get noRecordDeleted => 'Nenhum registro foi excluído';

  @override
  String toggleDatabaseFavoriteError(Object databaseName) {
    return 'Não foi possível mudar o status de favorito do banco de dados \"$databaseName\".';
  }

  @override
  String get unableToClear => 'Não foi possível limpar os bancos de dados';

  @override
  String get failedToGetAppVersion => 'Falha ao obter a versão do app';

  @override
  String sqlExecutionError(Object error) {
    return 'Erro na execução do SQL: $error';
  }

  @override
  String get noDatabaseSelected => 'Nenhum banco de dados selecionado';

  @override
  String get failedToLoadSqlSuggestions => 'Falha ao carregar sugestões SQL';

  @override
  String get failedToSaveSqlSuggestionsSettings =>
      'Falha ao salvar configurações de sugestões SQL';

  @override
  String get failedToLoadAdvancedSuggestions =>
      'Falha ao carregar sugestões avançadas';

  @override
  String get failedToAddAdvancedSuggestion =>
      'Falha ao adicionar sugestão avançada';

  @override
  String get failedToUpdateAdvancedSuggestion =>
      'Falha ao atualizar sugestão avançada';

  @override
  String get failedToRemoveAdvancedSuggestion =>
      'Falha ao remover sugestão avançada';

  @override
  String get failedToSaveAllAdvancedSuggestions =>
      'Falha ao salvar todas as sugestões avançadas';

  @override
  String get failedToReorderAdvancedSuggestions =>
      'Falha ao reordenar sugestões avançadas';

  @override
  String get failedToResetAdvancedSuggestions =>
      'Falha ao resetar sugestões avançadas';

  @override
  String get failedToLoadBasicSuggestions =>
      'Falha ao carregar sugestões básicas';

  @override
  String get failedToAddBasicSuggestion => 'Falha ao adicionar sugestão básica';

  @override
  String get failedToUpdateBasicSuggestions =>
      'Falha ao atualizar sugestões básicas';

  @override
  String get failedToRemoveBasicSuggestion =>
      'Falha ao remover sugestão básica';

  @override
  String get failedToResetBasicSuggestions =>
      'Falha ao resetar sugestões básicas';

  @override
  String failedToLoadSqlFiles(Object error) {
    return 'Falha ao carregar os arquivos SQL: $error';
  }

  @override
  String failedToExecuteSql(Object dbName, Object error) {
    return 'Falha ao executar SQL para \"$dbName\": $error';
  }

  @override
  String get databaseResetSuccessfully =>
      'Banco de dados reiniciado com sucesso';

  @override
  String get failedToLoadDatabaseStructure =>
      'Não foi possível carregar a estrutura do banco de dados.';

  @override
  String get databaseCreatedSuccessfully => 'Banco de dados criado com sucesso';

  @override
  String get databaseDeletedSuccessfully =>
      'Banco de dados excluído com sucesso';

  @override
  String get unknownError => 'Erro desconhecido';

  @override
  String get createDatabase => 'Criar Banco de Dados';

  @override
  String get name => 'Nome';

  @override
  String get pleaseEnterLabel => 'Por favor, insira um rótulo';

  @override
  String get pleaseEnterName => 'Por favor, insira um nome';

  @override
  String get invalidCharactersDetected => 'Caracteres inválidos detectados';

  @override
  String databaseAlreadyExists(Object name) {
    return 'O banco de dados \"$name\" já existe';
  }

  @override
  String languageUpdated(Object lang) {
    return 'Idioma atualizado para $lang';
  }

  @override
  String get loading => 'Carregando...';

  @override
  String get theDatabaseIsEmpty => 'O banco de dados está vazio';

  @override
  String get noDatabasesYet => 'Nenhum banco de dados ainda';

  @override
  String get noDatabasesFound => 'Nenhum banco de dados encontrado';

  @override
  String get noSuggestionsYet => 'Nenhuma sugestão ainda';

  @override
  String get toggleTheme => 'Alternar tema';

  @override
  String get screenNotFound => 'Tela não encontrada';

  @override
  String get screenNotFoundDescription =>
      'A tela que você procura não existe ou foi movida.';

  @override
  String get goHome => 'Ir para o início';

  @override
  String get submit => 'Enviar';

  @override
  String get thisFieldIsRequired => 'Este campo é obrigatório';

  @override
  String get sortOrderSavedSuccessfully => 'Ordenação salva com sucesso';

  @override
  String get failedToSaveSortOrder => 'Falha ao salvar a ordenação';

  @override
  String deleteSuccess(Object count) {
    return 'Exclusão executada com sucesso. $count linha(s) afetada(s).';
  }

  @override
  String updateSuccess(Object count) {
    return 'Atualização executada com sucesso. $count linha(s) afetada(s).';
  }

  @override
  String insertSuccess(Object count) {
    return 'Inserção executada com sucesso. $count linha(s) afetada(s).';
  }

  @override
  String get statementSuccess => 'Instrução executada com sucesso.';

  @override
  String get loadLastSql => 'Carregar último SQL';

  @override
  String get shareSql => 'Compartilhar consulta';

  @override
  String get downloadSql => 'Baixar consulta';

  @override
  String get nothingToShare => 'Não há nada para compartilhar';

  @override
  String get sqlSharedSuccess => 'SQL compartilhado com sucesso';

  @override
  String get copySql => 'Copiar consulta';

  @override
  String get nothingToCopy => 'Não há nada para copiar';

  @override
  String get sqlCopied => 'SQL copiado para a área de transferência';

  @override
  String get currentQuerySection => 'Consulta atual';

  @override
  String get databaseSection => 'Banco de dados';

  @override
  String get nothingToDownload => 'Não há nada para baixar';

  @override
  String get sqlDownloaded => 'Consulta salva como arquivo .sql';

  @override
  String get nothingToLoad => 'Não há consulta anterior para carregar';

  @override
  String get lastSqlLoaded => 'Última consulta carregada';
}
