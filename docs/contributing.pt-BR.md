# Contribuindo

<p align="center">
<a href="contributing.md">English</a> · <a href="contributing.es.md">Español</a> · <strong>Português (BR)</strong>
</p>

Obrigado por considerar contribuir. Este documento cobre a configuração, as convenções, e o que um pull request precisa antes de estar pronto para revisão. Para como o código está organizado, veja [`architecture.md`](architecture.pt-BR.md).

## Configuração

O projeto fixa a versão do SDK do Flutter via [FVM](https://fvm.app/), então todos os comandos abaixo usam `fvm flutter`/`fvm dart` em vez de uma instalação direta do `flutter`.

```sh
git clone https://github.com/dariomatias-dev/sql_studio_app.git
cd sql_studio_app
fvm install
fvm flutter pub get
git config core.hooksPath .githooks
```

Essa última linha aponta o git para [`.githooks/`](../.githooks), onde um hook `commit-msg` rejeita uma linha de assunto que não siga a convenção abaixo. O git não compartilha hooks entre clones, então é um comando por checkout.

As localizações não são versionadas pré-geradas a cada mudança. Regenere-as depois de atualizar ou editar qualquer arquivo em `lib/l10n/*.arb`:

```sh
fvm flutter gen-l10n
```

Rode o app em um dispositivo ou emulador conectado com `fvm flutter run`.

## Antes de abrir um pull request

- **Abra uma issue primeiro** para discutir a mudança, a menos que seja uma correção pequena e óbvia.
- **Siga a estrutura existente**: feature-first, camadas `domain`/`data`/`presentation`, Riverpod para estado, sem padrões novos sem discussão prévia. Veja [`architecture.md`](architecture.pt-BR.md).
- **Um caso de uso só se justifica quando compõe mais de uma chamada de repositório.** Caso contrário, chame o repositório diretamente do view model.
- **Respeite o design system**: sem cores, espaçamentos, raios, durações ou estilos de texto inline. Use os tokens em `lib/src/core/` (`AppColors`, `AppSpacing`, `AppRadii`, `AppShadows`, `AppDurations`).
- **Sem strings fixas voltadas ao usuário**: adicione a chave aos três arquivos ARB (`app_en.arb`, `app_es.arb`, `app_pt.arb`) com uma `description`, depois rode `gen-l10n`. [`scripts/check_l10n.sh`](../scripts/check_l10n.sh) garante a paridade de chaves entre eles, no `verify.sh` e no CI.
- **Adicione testes** para qualquer coisa com lógica: um método de repositório, um caso de uso, um view model, o comportamento de um widget. Uma correção de bug deve vir com um teste que falha sem a correção.
- **Rode a verificação completa localmente** antes de dar push:

  ```sh
  ./scripts/verify.sh
  ```

  Roda o mesmo que o CI: regenera as localizações e falha se isso mudou algo, `check_l10n.sh`, formatação, análise, testes, e o limiar de cobertura. Usa `fvm` quando configurado para o projeto, e as ferramentas soltas caso contrário. Adicione `--skip-tests` para uma passada parcial mais rápida enquanto você itera; nunca é o gate final, já que apaga o carimbo da última passada local em vez de escrevê-lo.

  Os mesmos checks manualmente:

  ```sh
  fvm flutter analyze
  fvm dart format --output=none --set-exit-if-changed lib/ test/
  fvm flutter test --coverage
  ./scripts/check_coverage.sh coverage/lcov.info 91
  ```

- **Mensagens de commit** seguem o [Conventional Commits](https://www.conventionalcommits.org/), reforçado pelo hook `commit-msg` habilitado na configuração:

  ```
  <type>(<scope opcional>): <subject>
  ```

  O tipo é um de `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style` ou `test`. O escopo, quando existe, é minúsculo e com hífen (`sql-editor`, não `sql_editor`):

  | | Escopos |
  | --- | --- |
  | features | `database`, `database-visualizer`, `sql-editor`, `sql-suggestions`, `workspace-layout`, `app-version` |
  | áreas do core | `core`, `navigation`, `routes`, `theme`, `l10n`, `sql-execution`, `default-database`, `shared-preferences` |
  | transversais | `shared`, `deps`, `ci`, `scripts`, `docs`, `release` |

  O subject é curto e imperativo, começa em minúscula, e não leva ponto final. Adicione `!` antes dos dois-pontos para uma mudança que quebra compatibilidade.

  O hook também mantém a mensagem no formato que as ferramentas do git esperam: a linha inteira do subject fica dentro de **72 caracteres**, onde `git log --oneline` e o GitHub truncam; um corpo é separado do subject por uma linha em branco, e suas linhas quebram em **100**. URLs e trailers como `Co-Authored-By:` são isentos, já que quebrá-los estragaria o que significam. Commits de merge e revert ficam intocados.

## O que o CI verifica

Todo push e pull request roda [`.github/workflows/ci.yaml`](../.github/workflows/ci.yaml), em quatro jobs:

| Job | O que faz |
| --- | --- |
| `quality` | Instala dependências, regenera as localizações, e então **falha se essa regeneração produziu um diff**, já que arquivos gerados precisam estar versionados e atualizados. Depois formatação, análise, testes, e o gate de cobertura, e sobe o relatório para o Codecov. |
| `build_apk` | Roda depois que `quality` passa e compila um APK de release — compilável sem um segredo de assinatura, já que `android/app/build.gradle.kts` recorre à keystore de debug quando `key.properties` está ausente — enviado como artefato do workflow, mantido por 14 dias. |
| `integration` | Roda depois que `quality` passa, inicia um emulador Android fixo (API 35) e roda cada suíte de `integration_test/` nele, forçando o encerramento do app entre suítes para que cada uma comece a frio. Essas precisam de um dispositivo real: exercitam o armazenamento real de SQLite e `SharedPreferences`, incluindo estado que sobrevive a um reinício simulado. O job habilita o KVM primeiro e compila um APK de debug antes de iniciar o emulador, já que uma build Android a frio sozinha pode estourar o limite de tempo por suíte. |
| `osv-scanner` | Escaneia o `pubspec.lock` contra a base OSV. Roda independente dos outros jobs: um aviso recém-publicado sem correção disponível ainda não é motivo para parar o relato dos testes. |

Releases são feitas pelo [release-please](https://github.com/googleapis/release-please). Ele lê os Conventional Commits chegados na `main` e mantém aberto um pull request com a próxima versão e a entrada do `CHANGELOG.md` derivada deles. Ao mesclar esse pull request, a versão é escrita em `pubspec.yaml`, o commit é marcado com tag, e a release do GitHub é publicada.

[`.github/workflows/release.yml`](../.github/workflows/release.yml) então roda o mesmo gate de qualidade e anexa o APK de release. Ele é chamado diretamente pelo [`release_please.yml`](../.github/workflows/release_please.yml), já que o GitHub não inicia um workflow a partir de uma tag empurrada com o token padrão, e também responde a uma tag `v*.*.*` empurrada manualmente, criando a release por conta própria nesse caso.

### Relatórios de cobertura

[`scripts/check_coverage.sh`](../scripts/check_coverage.sh) é o que faz uma build falhar, excluindo `lib/l10n/` antes de medir; o [Codecov](https://codecov.io/gh/dariomatias-dev/sql_studio_app) é o que deixa o número legível num pull request. Os envios se autenticam com um secret de repositório `CODECOV_TOKEN`; pull requests de forks não conseguem lê-lo, então o passo está deliberadamente configurado com `fail_ci_if_error: false` — um envio falho é um relatório faltando, nunca uma build falha.

Para o mesmo localmente, sem conta, renderize o arquivo `lcov` em HTML:

```sh
fvm flutter test --coverage
genhtml coverage/lcov.info -o coverage/html   # apt install lcov
xdg-open coverage/html/index.html
```

## Trabalhando com um agente de IA

O repositório carrega sua própria configuração de agente, então um assistente segue o mesmo processo que um colaborador humano em vez de improvisar um por prompt:

- [`CLAUDE.md`](../CLAUDE.md) é o acordo de trabalho: onde cada código entra, as convenções em vigor, o vocabulário de escopos acima, e a regra de um-passo-um-commit que o histórico deste projeto segue.
- [`.claude/settings.json`](../.claude/settings.json) conecta dois hooks: todo arquivo Dart escrito é formatado imediatamente, e um hook `Stop` se recusa a encerrar um turno enquanto as mudanças de código não passaram por `./scripts/verify.sh`.

Nada disso substitui o CI, que continua sendo a autoridade. Existe para que a passada local combine com o que o CI vai dizer. Mudar o acordo ou os hooks é uma mudança normal: atualize `CLAUDE.md` junto com ela.

## Código de Conduta

A participação neste projeto é regida pelo [Código de Conduta](code_of_conduct.pt-BR.md).
