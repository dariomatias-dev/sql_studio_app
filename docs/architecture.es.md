# Arquitectura

<p align="center">
<a href="architecture.md">English</a> · <strong>Español</strong> · <a href="architecture.pt-BR.md">Português (BR)</a>
</p>

Este documento profundiza un nivel más que la vista general del README. Está pensado para quien vaya a modificar código en este repositorio: dónde va cada archivo, por qué existe cada capa y cómo se comunican las piezas entre sí.

## Estructura

```
lib/
  main.dart                 # raíz de composición: límite de errores, ProviderScope, fallback de arranque
  src/
    core/                   # aspectos transversales, compartidos por todas las features
      database/             # DatabaseManager (el archivo SQLite propio de la app) + repositorio CRUD genérico
      error/                 # Result/Failure, los manejadores globales de errores
      logging/               # el contrato AppLogger y su implementación
      navigation/             # barra de navegación, drawer, shell de pestañas
      providers/              # core_providers.dart: servicios que leen más de una feature
      routes/                 # configuración de go_router, helpers de navegación tipados
      screens/                 # ajustes, acerca de, splash, no encontrado, fallo de arranque
      services/                # SqlExecutionService, DefaultDatabaseService, SharedPreferencesService
      sql/                     # el divisor de sentencias SQL compartido
      app_colors/app_spacing/app_radii/app_shadows/app_durations/app_theme.dart  # tokens de diseño
    features/
      <feature>/
        domain/
          entities/          # clases simples que describen los datos de la feature
          repositories/       # contratos abstractos
          usecases/            # solo donde la lógica real compone más de una llamada a repositorio
        data/
          mappers/            # fromMap/toMap entre una entidad y su mapa de persistencia
          datasources/         # con qué habla una implementación de repositorio
          repositories/        # la implementación del repositorio
          providers/           # <feature>_data_providers.dart: DI de datasource/repositorio
        presentation/
          view_models/         # un Notifier/AsyncNotifier más su estado inmutable
          screens/, widgets/    # UI
          <feature>_providers.dart  # providers de view model, use cases locales a la feature
    shared/                  # código compartido entre features: widgets, utilidades
```

Features: `database` (las bases de datos guardadas por el usuario), `database_visualizer` (el diagrama de esquema), `sql_editor` (el editor de código y la consola), `sql_suggestions` (snippets básicos/avanzados), `workspace_layout_settings`, `app_version`.

## Capas (Clean Architecture + MVVM)

- **`domain`**: Dart puro. Entidades, contratos de repositorio abstractos, y clases de caso de uso para el puñado de operaciones con lógica ramificada real (`DeleteDatabaseUseCase` cierra la conexión, elimina el archivo y borra el registro; los casos de uso de reordenar/reiniciar/guardar-todo de sugerencias avanzadas componen más de una llamada a repositorio). Todo lo demás es un método de repositorio que un view model llama directamente: una clase que solo reenvía una llamada a un repositorio no es un caso de uso.
- **`data`**: implementa los contratos de `domain` contra una fuente de datos concreta (un `DatabaseRepository<T>` ligado a una tabla, `SharedPreferencesService`, o `SqlExecutionService`). Los mappers convierten entre un mapa de persistencia y una entidad de dominio.
- **`presentation`**: pantallas y widgets, más view models: clases `Notifier`/`AsyncNotifier` de Riverpod expuestas a través de providers. Una pantalla observa un provider; solo lee un repositorio directamente para una llamada puntual disparada por una acción del usuario, nunca un caso de uso que no existe.

Una feature nunca importa el `presentation/` de otra feature. Lo que más de una feature necesita compartir va en `core/` (un servicio, un provider transversal) o en `shared/` (un widget, una utilidad).

## Gestión de estado

[Riverpod](https://riverpod.dev/) de punta a punta, escrito a mano (sin generación de código): `Provider` para dependencias sin estado, `NotifierProvider` para cualquier cosa con comportamiento. Los providers se agrupan por rol, no un archivo por provider: `<feature>_providers.dart` para view models, `data/providers/<feature>_data_providers.dart` para datasources y repositorios, `core/providers/core_providers.dart` para lo que lee más de una feature (el logger, el `DatabaseManager` compartido, `SqlExecutionService`, `DefaultDatabaseService`).

## Navegación

[go_router](https://pub.dev/packages/go_router), con una barra de navegación inferior para las tres pestañas principales (Inicio, Bases de datos, Ajustes) y rutas apiladas para todo lo demás (el visualizador de base de datos, las subpantallas de ajustes). `AppRoutes` (`lib/src/core/routes/`) envuelve cada llamada de navegación en un método tipado en vez de una ruta como cadena de texto suelta.

## Persistencia

Dos cosas independientes viven en el disco, ambas a través de [sqflite](https://pub.dev/packages/sqflite):

- **La base de datos propia de la app** (`DatabaseManager`, `lib/src/core/database/`): un archivo SQLite pequeño con las tablas administrativas de la app — la lista de bases de datos creadas por el usuario y las sugerencias SQL avanzadas. `DatabaseRepository<T>` es una capa CRUD genérica ligada a un nombre de tabla, compartida por cada feature que persiste aquí.
- **Las bases de datos de ejemplo y las del usuario**: cada una es su propio archivo SQLite, abierto bajo demanda por `SqlExecutionService` (`lib/src/core/services/`), que guarda en caché una conexión por cada base de datos abierta y las cierra todas al desecharse. `DefaultDatabaseService` siembra las 14 bases de datos de ejemplo incluidas desde `assets/sql/schemas/` y `assets/sql/seeds/`, versionadas **por base de datos**, no de forma global: subir la versión de un ejemplo vuelve a sembrar solo esa base de datos, dejando intactas las ediciones del usuario en las otras trece. Una instalación que actualiza desde la antigua clave de versión global única la migra a las claves por base de datos sin volver a sembrar nada.

Las preferencias del usuario que no necesitan consultarse (tema, idioma, disposición del espacio de trabajo, activadores de sugerencias) pasan por `shared_preferences` detrás de `SharedPreferencesService`.

Tanto el cargador de assets de esquema/semilla como el ejecutor de sentencias de la consola comparten un único divisor de sentencias SQL (`core/sql/sql_statement_splitter.dart`), así que un punto y coma dentro de un literal de texto, un comentario o el cuerpo `BEGIN...END` de un trigger se maneja una sola vez, no se reimplementa por cada quien lo llame.

## Manejo de errores

`main.dart` instala `FlutterError.onError` y `PlatformDispatcher.onError` antes de que corra cualquier otra cosa, ambos enrutando hacia `AppLogger`, y sustituye el `ErrorWidget.builder` por uno neutral en builds de release. `startApp()` protege `SharedPreferencesService.create()` y el resto del arranque: un fallo ahí recurre a `StartupFailureApp`, una app mínima (sin contenedor de providers, sin localizaciones más allá de las que necesita) que ofrece reintentar y, para un estado que falla sin importar cuántas veces se reintente, un borrado confirmado de los datos locales a través de `LocalStateService`.

Dentro de la app, `Result<T>` (`lib/src/core/error/result.dart`) es un tipo sellado: un repositorio o servicio devuelve `SuccessResult`/`FailureResult`, y quien lo llama lo compara con `when`/`switch`, nunca una cadena de `is`. Un `Failure` lleva una clave de localización más argumentos de interpolación; `LocalizationExtension.key()` la resuelve a un mensaje real, y un test verifica que cada `AppLocalizationsKey` tenga una entrada ahí, así que una clave añadida sin mensaje falla ruidosamente en los tests en vez de silenciosamente en producción. `handleError()` (`shared/utils/`) es el único lugar donde el resultado de una vista se convierte en un diálogo de error.

El registro de logs pasa por `AppLogger` (`core/logging/`), nunca un `Logger` construido directamente. `SqlExecutionService` nunca registra el texto SQL que ejecuta ni el nombre de la base de datos contra la que corre, solo el tipo de sentencia y el número de filas, y adjunta la excepción cruda (que incorpora el SQL que falló) solo en builds de debug.

## Tests

Los tests unitarios y de widgets viven bajo `test/`, siguiendo la misma estructura que `lib/`. `integration_test/` cubre flujos de punta a punta contra el almacenamiento real de SQLite y `SharedPreferences` en el dispositivo: sembrado en el primer arranque, crear una base de datos y consultarla, editar una base de datos de ejemplo que sobrevive a un reinicio simulado, un reinicio deliberado, borrar una base de datos, cambiar de idioma, y ajustes (tema, disposición del espacio de trabajo, marcar una base de datos como favorita) que sobreviven a un reinicio. `test/core/providers/provider_graph_test.dart` construye el contenedor de providers completo de producción y lee cada provider, detectando un error de cableado que de otro modo solo aparecería en un dispositivo. Consulta el README para los conteos de tests actuales y el umbral de cobertura.
