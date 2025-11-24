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

  @override
  String get cancel => 'Cancelar';

  @override
  String get attention => 'Atenção';

  @override
  String get deleteDatabaseConfirmation => 'Tem certeza de que deseja excluir permanentemente este banco de dados? Esta ação não pode ser desfeita.';

  @override
  String get toDoListLabel => 'Lista de Tarefas';

  @override
  String get toDoListDescription => 'Banco de dados simples para gerenciamento de tarefas';

  @override
  String get contactsLabel => 'Contatos';

  @override
  String get contactsDescription => 'Banco de dados de contatos e grupos';

  @override
  String get libraryLabel => 'Biblioteca';

  @override
  String get libraryDescription => 'Biblioteca com livros, membros e empréstimos';

  @override
  String get fitnessClubLabel => 'Clube de Fitness';

  @override
  String get fitnessClubDescription => 'Banco de dados de membros da academia e assinaturas';

  @override
  String get carRentalLabel => 'Locadora de Carros';

  @override
  String get carRentalDescription => 'Banco de dados de gestão de aluguel de carros';

  @override
  String get restaurantLabel => 'Restaurante';

  @override
  String get restaurantDescription => 'Banco de dados de pedidos e itens do menu';

  @override
  String get hrPayrollLabel => 'Folha de Pagamento';

  @override
  String get hrPayrollDescription => 'Departamentos, cargos, funcionários e histórico salarial';

  @override
  String get logisticsLabel => 'Logística';

  @override
  String get logisticsDescription => 'Banco de dados de pacotes, motoristas, entregas e histórico de status';

  @override
  String get pharmacyLabel => 'Farmácia';

  @override
  String get pharmacyDescription => 'Estoque da farmácia, fornecedores, clientes e vendas';

  @override
  String get schoolLabel => 'Escola';

  @override
  String get schoolDescription => 'Gestão escolar com alunos, professores, turmas, matrículas e notas';

  @override
  String get socialNetworkLabel => 'Rede Social';

  @override
  String get socialNetworkDescription => 'Plataforma social com usuários, posts, likes, comentários e seguidores';

  @override
  String get hotelLabel => 'Hotel';

  @override
  String get hotelDescription => 'Banco de dados de reservas, quartos, pagamentos, funcionários e serviços';

  @override
  String get bankingLabel => 'Banco';

  @override
  String get bankingDescription => 'Sistema bancário com contas, transações, empréstimos e funcionários';

  @override
  String get eCommerceLabel => 'E-Commerce';

  @override
  String get eCommerceDescription => 'Loja online com produtos, pedidos, carrinhos e avaliações';

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
  String get basicSuggestionsDescription => 'Exibe exemplos SQL completos como \"SELECT * FROM\". Ideal para consultas rápidas.';

  @override
  String get advancedSuggestions => 'Sugestões Avançadas';

  @override
  String get advancedSuggestionsDescription => 'Mostra dicas curtas como \"ALL\" ou \"COUNT\" que se expandem para instruções SQL completas ao clicar.';

  @override
  String get otherSuggestions => 'Outras Sugestões';

  @override
  String get characterSuggestions => 'Sugestões de Caracteres';

  @override
  String get characterSuggestionsDescription => 'Adiciona botões rápidos para >, =, !, %, ; e mais.';

  @override
  String get saveSettings => 'Salvar Configurações';

  @override
  String get advancedSuggestionsInitialized => 'As sugestões avançadas foram inicializadas com sucesso.';

  @override
  String get advancedSuggestionsFailed => 'Falha ao inicializar as sugestões avançadas.';

  @override
  String get settingsSavedSuccessfully => 'Configurações salvas com sucesso!';

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
  String get removeSuggestionDescription => 'Tem certeza de que deseja remover esta sugestão?';

  @override
  String get remove => 'Remover';

  @override
  String get resetSuggestions => 'Redefinir Sugestões';

  @override
  String get resetSuggestionsDescription => 'Tem certeza de que deseja redefinir a lista de sugestões?';

  @override
  String get reset => 'Redefinir';

  @override
  String get advancedSuggestionAdded => 'Sugestão adicionada com sucesso.';

  @override
  String get advancedSuggestionFailed => 'Falha ao adicionar sugestão.';

  @override
  String deleteSuggestionConfirmation(Object label) {
    return 'Tem certeza de que deseja excluir a sugestão \"$label\"?';
  }

  @override
  String get suggestionDeleted => 'Sugestão excluída com sucesso.';

  @override
  String get suggestionDeleteFailed => 'Falha ao excluir sugestão.';

  @override
  String get resetSuggestionsConfirm => 'Tem certeza de que deseja redefinir as sugestões?';

  @override
  String get suggestionsResetSuccess => 'Todas as sugestões foram redefinidas com sucesso.';

  @override
  String get suggestionsResetFailed => 'Não foi possível redefinir as sugestões. Tente novamente.';

  @override
  String get label => 'Rótulo';

  @override
  String get sqlCode => 'Código SQL';

  @override
  String get selectableTextOptional => 'Texto selecionável (opcional)';

  @override
  String get selectableTextHint => 'Parte do SQL a ser selecionada automaticamente para substituição';

  @override
  String get fieldRequired => 'Este campo é obrigatório';

  @override
  String get updateSuggestion => 'Atualizar Sugestão';

  @override
  String get update => 'Atualizar';

  @override
  String get updateSuggestionSuccess => 'Sugestão atualizada com sucesso.';

  @override
  String get updateSuggestionFail => 'Falha ao atualizar sugestão.';

  @override
  String get deleteSuggestion => 'Deletar sugestão';

  @override
  String get save => 'Salvar';
}
