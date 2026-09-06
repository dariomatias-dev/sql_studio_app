# Contribuir

<p align="center">
<a href="contributing.md">English</a> · <strong>Español</strong> · <a href="contributing.pt-BR.md">Português (BR)</a>
</p>

Gracias por considerar contribuir. Este documento cubre la configuración, las convenciones, y qué necesita un pull request antes de estar listo para revisión. Para cómo está organizado el código, ver [`architecture.md`](architecture.es.md).

## Configuración

El proyecto fija su versión del SDK de Flutter vía [FVM](https://fvm.app/), así que todos los comandos de abajo usan `fvm flutter`/`fvm dart` en vez de una instalación directa de `flutter`.

```sh
git clone https://github.com/dariomatias-dev/sql_studio_app.git
cd sql_studio_app
fvm install
fvm flutter pub get
git config core.hooksPath .githooks
```

Esa última línea apunta git hacia [`.githooks/`](../.githooks), donde un hook `commit-msg` rechaza una línea de asunto que no siga la convención de abajo. Git no comparte hooks a través de un clon, así que es un comando por checkout.

Las localizaciones no se versionan pregeneradas en cada cambio. Regenéralas después de actualizar o editar cualquier archivo bajo `lib/l10n/*.arb`:

```sh
fvm flutter gen-l10n
```

Ejecuta la app en un dispositivo o emulador conectado con `fvm flutter run`.

## Antes de abrir un pull request

- **Abre un issue primero** para discutir el cambio, a menos que sea una corrección pequeña y obvia.
- **Sigue la estructura existente**: feature-first, capas `domain`/`data`/`presentation`, Riverpod para el estado, sin patrones nuevos sin discutirlos antes. Ver [`architecture.md`](architecture.es.md).
- **Un caso de uso se justifica solo cuando compone más de una llamada a repositorio.** En cualquier otro caso, llama al repositorio directamente desde el view model.
- **Respeta el sistema de diseño**: sin colores, espaciados, radios, duraciones o estilos de texto en línea. Usa los tokens bajo `lib/src/core/` (`AppColors`, `AppSpacing`, `AppRadii`, `AppShadows`, `AppDurations`).
- **Sin cadenas de texto fijas para el usuario**: agrega la clave a los tres archivos ARB (`app_en.arb`, `app_es.arb`, `app_pt.arb`) con una `description`, y luego ejecuta `gen-l10n`. [`scripts/check_l10n.sh`](../scripts/check_l10n.sh) hace cumplir la paridad de claves entre ellos, en `verify.sh` y en CI.
- **Agrega tests** para cualquier cosa con lógica: un método de repositorio, un caso de uso, un view model, el comportamiento de un widget. Una corrección de bug debería llevar un test que falle sin la corrección.
- **Ejecuta la verificación completa localmente** antes de hacer push:

  ```sh
  ./scripts/verify.sh
  ```

  Corre lo mismo que CI: regenera las localizaciones y falla si eso cambió algo, `check_l10n.sh`, formato, análisis, tests, y el umbral de cobertura. Usa `fvm` cuando está configurado para el proyecto, y las herramientas sin `fvm` en caso contrario. Agrega `--skip-tests` para una pasada parcial más rápida mientras iteras; nunca es el gate final, ya que borra el sello de la última pasada local en vez de escribirlo.

  Los mismos chequeos a mano:

  ```sh
  fvm flutter analyze
  fvm dart format --output=none --set-exit-if-changed lib/ test/
  fvm flutter test --coverage
  ./scripts/check_coverage.sh coverage/lcov.info 91
  ```

- **Los mensajes de commit** siguen [Conventional Commits](https://www.conventionalcommits.org/), reforzado por el hook `commit-msg` habilitado durante la configuración:

  ```
  <type>(<scope opcional>): <subject>
  ```

  El tipo es uno de `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style` o `test`. El scope, cuando lo hay, va en minúsculas y con guiones (`sql-editor`, no `sql_editor`):

  | | Scopes |
  | --- | --- |
  | features | `database`, `database-visualizer`, `sql-editor`, `sql-suggestions`, `workspace-layout`, `app-version` |
  | áreas del core | `core`, `navigation`, `routes`, `theme`, `l10n`, `sql-execution`, `default-database`, `shared-preferences` |
  | transversales | `shared`, `deps`, `ci`, `scripts`, `docs`, `release` |

  El subject es corto e imperativo, empieza en minúscula, y no lleva punto final. Agrega `!` antes de los dos puntos para un cambio disruptivo.

  El hook también mantiene el mensaje en la forma que las herramientas de git esperan: toda la línea de asunto se mantiene dentro de **72 caracteres**, que es donde `git log --oneline` y GitHub truncan; un cuerpo se separa del asunto por una línea en blanco, y sus líneas se ajustan a **100**. Las URLs y trailers como `Co-Authored-By:` están exentos, ya que ajustarlos rompería su significado. Los commits de merge y revert se dejan sin tocar.

## Qué verifica CI

Cada push y pull request ejecuta [`.github/workflows/ci.yaml`](../.github/workflows/ci.yaml), en cuatro jobs:

| Job | Qué hace |
| --- | --- |
| `quality` | Instala dependencias, regenera las localizaciones, y luego **falla si esa regeneración produjo un diff**, ya que los archivos generados deben estar versionados y actualizados. Después formato, análisis, tests, y el gate de cobertura, y sube el reporte a Codecov. |
| `build_apk` | Corre después de que `quality` pase y compila un APK de release — compilable sin un secreto de firma, ya que `android/app/build.gradle.kts` recurre a la keystore de debug cuando falta `key.properties` — subido como artefacto del workflow, conservado 14 días. |
| `integration` | Corre después de que `quality` pase, inicia un emulador Android fijo (API 35) y ejecuta cada suite de `integration_test/` en él, forzando el cierre de la app entre suites para que cada una empiece en frío. Estas necesitan un dispositivo real: ejercitan el almacenamiento real de SQLite y `SharedPreferences`, incluyendo estado que sobrevive a un reinicio simulado. El job habilita KVM primero y compila un APK de debug antes de iniciar el emulador, ya que una compilación Android en frío por sí sola puede superar el límite de tiempo por suite. |
| `osv-scanner` | Escanea `pubspec.lock` contra la base de datos OSV. Corre de forma independiente a los otros jobs: un aviso recién publicado sin corrección disponible todavía no es motivo para detener el reporte de los tests. |

Los releases los genera [release-please](https://github.com/googleapis/release-please). Lee los Conventional Commits llegados a `main` y mantiene abierto un pull request con la siguiente versión y la entrada de `CHANGELOG.md` derivada de ellos. Al fusionar ese pull request se escribe la versión en `pubspec.yaml`, se etiqueta el commit, y se publica el release de GitHub.

[`.github/workflows/release.yml`](../.github/workflows/release.yml) luego ejecuta el mismo gate de calidad y adjunta el APK de release. Lo llama directamente [`release_please.yml`](../.github/workflows/release_please.yml), ya que GitHub no inicia un workflow desde un tag empujado con el token predeterminado, y también responde a un tag `v*.*.*` empujado a mano, creando el release por su cuenta en ese caso.

### Reportes de cobertura

[`scripts/check_coverage.sh`](../scripts/check_coverage.sh) es lo que hace fallar una build, excluyendo `lib/l10n/` antes de medir; [Codecov](https://codecov.io/gh/dariomatias-dev/sql_studio_app) es lo que hace el número legible en un pull request. Las subidas se autentican con un secreto de repositorio `CODECOV_TOKEN`; los pull requests de forks no pueden leerlo, así que el paso está deliberadamente configurado con `fail_ci_if_error: false` — una subida fallida es un reporte faltante, nunca una build fallida.

Para lo mismo localmente, sin cuenta, renderiza el archivo `lcov` a HTML:

```sh
fvm flutter test --coverage
genhtml coverage/lcov.info -o coverage/html   # apt install lcov
xdg-open coverage/html/index.html
```

## Trabajar con un agente de IA

El repositorio lleva su propia configuración de agente, así que un asistente sigue el mismo proceso que un colaborador humano en vez de improvisar uno por prompt:

- [`CLAUDE.md`](../CLAUDE.md) es el acuerdo de trabajo: dónde va cada código, las convenciones vigentes, el vocabulario de scopes de arriba, y la regla de un-paso-un-commit que sigue el historial de este proyecto.
- [`.claude/settings.json`](../.claude/settings.json) conecta dos hooks: cada archivo Dart escrito se formatea de inmediato, y un hook `Stop` se niega a terminar un turno mientras los cambios de código no hayan pasado `./scripts/verify.sh`.

Nada de esto reemplaza a CI, que sigue siendo la autoridad. Existe para que la pasada local coincida con lo que dirá CI. Cambiar el acuerdo o los hooks es un cambio normal: actualiza `CLAUDE.md` junto con él.

## Código de Conducta

La participación en este proyecto se rige por el [Código de Conducta](code_of_conduct.es.md).
