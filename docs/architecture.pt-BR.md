# Arquitetura

<p align="center">
<a href="architecture.md">English</a> · <a href="architecture.es.md">Español</a> · <strong>Português (BR)</strong>
</p>

Este documento vai um nível além da visão geral do README. É voltado a quem for mexer no código deste repositório: onde cada arquivo entra, por que cada camada existe e como as peças conversam entre si.

## Estrutura

```
lib/
  main.dart                 # raiz de composição: limite de erro, ProviderScope, fallback de inicialização
  src/
    core/                   # aspectos transversais, compartilhados por todas as features
      database/             # DatabaseManager (o arquivo SQLite próprio do app) + repositório CRUD genérico
      error/                 # Result/Failure, os handlers globais de erro
      logging/               # o contrato AppLogger e sua implementação
      navigation/             # barra de navegação, drawer, shell de abas
      providers/              # core_providers.dart: serviços lidos por mais de uma feature
      routes/                 # configuração do go_router, helpers de navegação tipados
      screens/                 # ajustes, sobre, splash, não encontrado, falha de inicialização
      services/                # SqlExecutionService, DefaultDatabaseService, SharedPreferencesService
      sql/                     # o divisor de instruções SQL compartilhado
      app_colors/app_spacing/app_radii/app_shadows/app_durations/app_theme.dart  # tokens de design
    features/
      <feature>/
        domain/
          entities/          # classes simples descrevendo os dados da feature
          repositories/       # contratos abstratos
          usecases/            # só onde a lógica real compõe mais de uma chamada de repositório
        data/
          mappers/            # fromMap/toMap entre uma entidade e seu mapa de persistência
          datasources/         # com o que uma implementação de repositório conversa
          repositories/        # a implementação do repositório
          providers/           # <feature>_data_providers.dart: DI de datasource/repositório
        presentation/
          view_models/         # um Notifier/AsyncNotifier mais seu estado imutável
          screens/, widgets/    # UI
          <feature>_providers.dart  # providers de view model, use cases locais à feature
    shared/                  # código compartilhado entre features: widgets, utilitários
```

Features: `database` (os bancos salvos pelo usuário), `database_visualizer` (o diagrama de esquema), `sql_editor` (o editor de código e o console), `sql_suggestions` (snippets básicos/avançados), `workspace_layout_settings`, `app_version`.

## Camadas (Clean Architecture + MVVM)

- **`domain`**: Dart puro. Entidades, contratos de repositório abstratos, e classes de caso de uso para o punhado de operações com lógica ramificada real (`DeleteDatabaseUseCase` fecha a conexão, apaga o arquivo e remove o registro; os casos de uso de reordenar/resetar/salvar-tudo das sugestões avançadas compõem mais de uma chamada de repositório). Todo o resto é um método de repositório que um view model chama diretamente: uma classe que só repassa uma chamada para um repositório não é um caso de uso.
- **`data`**: implementa os contratos de `domain` contra uma fonte de dados concreta (um `DatabaseRepository<T>` ligado a uma tabela, `SharedPreferencesService`, ou `SqlExecutionService`). Mappers convertem entre um mapa de persistência e uma entidade de domínio.
- **`presentation`**: telas e widgets, mais view models: classes `Notifier`/`AsyncNotifier` do Riverpod expostas por providers. Uma tela observa um provider; só lê um repositório diretamente para uma chamada pontual disparada por uma ação do usuário, nunca um caso de uso que não existe.

Uma feature nunca importa o `presentation/` de outra feature. O que mais de uma feature precisa compartilhar vai em `core/` (um serviço, um provider transversal) ou em `shared/` (um widget, um utilitário).

## Gerenciamento de estado

[Riverpod](https://riverpod.dev/) de ponta a ponta, escrito à mão (sem geração de código): `Provider` para dependências sem estado, `NotifierProvider` para qualquer coisa com comportamento. Os providers são agrupados por papel, não um arquivo por provider: `<feature>_providers.dart` para view models, `data/providers/<feature>_data_providers.dart` para datasources e repositórios, `core/providers/core_providers.dart` para o que é lido por mais de uma feature (o logger, o `DatabaseManager` compartilhado, `SqlExecutionService`, `DefaultDatabaseService`).

## Navegação

[go_router](https://pub.dev/packages/go_router), com uma barra de navegação inferior para as três abas principais (Início, Bancos de dados, Ajustes) e rotas empilhadas para o resto (o visualizador de banco de dados, as subtelas de ajustes). `AppRoutes` (`lib/src/core/routes/`) embrulha cada chamada de navegação num método tipado em vez de uma string de rota solta.

## Persistência

Duas coisas independentes vivem em disco, ambas via [sqflite](https://pub.dev/packages/sqflite):

- **O banco de dados próprio do app** (`DatabaseManager`, `lib/src/core/database/`): um arquivo SQLite pequeno com as tabelas administrativas do app — a lista de bancos criados pelo usuário e as sugestões SQL avançadas. `DatabaseRepository<T>` é uma camada CRUD genérica ligada a um nome de tabela, compartilhada por toda feature que persiste aqui.
- **Os bancos de exemplo e os do usuário**: cada um é seu próprio arquivo SQLite, aberto sob demanda pelo `SqlExecutionService` (`lib/src/core/services/`), que mantém em cache uma conexão por banco aberto e fecha todas ao ser descartado. `DefaultDatabaseService` semeia os 14 bancos de exemplo empacotados a partir de `assets/sql/schemas/` e `assets/sql/seeds/`, versionados **por banco**, não globalmente: subir a versão de um exemplo re-semeia só aquele banco, deixando intactas as edições do usuário nos outros treze. Uma instalação atualizando da antiga chave de versão global única migra para as chaves por banco sem re-semear nada.

Preferências do usuário que não precisam de consulta (tema, idioma, disposição do workspace, ativação de sugestões) passam por `shared_preferences` atrás de `SharedPreferencesService`.

Tanto o carregador de assets de esquema/seed quanto o executor de instruções do console compartilham um único divisor de instruções SQL (`core/sql/sql_statement_splitter.dart`), então um ponto e vírgula dentro de um literal de texto, um comentário, ou o corpo `BEGIN...END` de um trigger é tratado uma vez só, não reimplementado a cada chamador.

## Tratamento de erros

`main.dart` instala `FlutterError.onError` e `PlatformDispatcher.onError` antes de qualquer outra coisa rodar, ambos roteando para `AppLogger`, e troca o `ErrorWidget.builder` por um neutro em builds de release. `startApp()` protege `SharedPreferencesService.create()` e o resto da inicialização: uma falha ali recorre ao `StartupFailureApp`, um app mínimo (sem container de providers, sem localizações além do necessário) que oferece tentar de novo e, para um estado que falha não importa quantas vezes seja tentado, uma limpeza confirmada dos dados locais via `LocalStateService`.

Dentro do app, `Result<T>` (`lib/src/core/error/result.dart`) é um tipo selado: um repositório ou serviço retorna `SuccessResult`/`FailureResult`, e quem chama compara com `when`/`switch`, nunca uma cadeia de `is`. Um `Failure` carrega uma chave de localização mais argumentos de interpolação; `LocalizationExtension.key()` resolve isso para uma mensagem real, e um teste garante que toda `AppLocalizationsKey` tenha uma entrada ali, então uma chave adicionada sem mensagem falha ruidosamente nos testes em vez de silenciosamente em produção. `handleError()` (`shared/utils/`) é o único lugar onde o resultado de uma tela vira um diálogo de erro.

O log passa por `AppLogger` (`core/logging/`), nunca um `Logger` construído diretamente. `SqlExecutionService` nunca registra o texto SQL executado nem o nome do banco contra o qual roda, só o tipo de instrução e a contagem de linhas, e anexa a exceção crua (que embute o SQL que falhou) somente em builds de debug.

## Testes

Testes unitários e de widget vivem em `test/`, espelhando a estrutura de `lib/`. `integration_test/` cobre fluxos de ponta a ponta contra o armazenamento real de SQLite e `SharedPreferences` no dispositivo: semeadura na primeira execução, criar um banco e consultá-lo, editar um banco padrão que sobrevive a um reinício simulado, um reset deliberado, apagar um banco, trocar de idioma, e ajustes (tema, disposição do workspace, favoritar um banco) que sobrevivem a um reinício. `test/core/providers/provider_graph_test.dart` monta o container de providers completo de produção e lê cada provider, pegando um erro de conexão que de outra forma só apareceria num dispositivo. Veja o README para as contagens de teste atuais e o limiar de cobertura.
