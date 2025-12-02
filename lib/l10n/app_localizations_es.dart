// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get home => 'Inicio';

  @override
  String get databases => 'Bases de Datos';

  @override
  String get settings => 'Configuración';

  @override
  String get general => 'General';

  @override
  String get language => 'Idioma';

  @override
  String get sqlSuggestions => 'Sugerencias SQL';

  @override
  String get workspaceLayout => 'Diseño del área de trabajo';

  @override
  String get information => 'Información';

  @override
  String get appVersion => 'Versión de la App';

  @override
  String get officialWebsite => 'Sitio oficial';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get contact => 'Contacto';

  @override
  String get errorOpeningUrl => 'Error al abrir URL';

  @override
  String errorOpeningUrlDescription(Object url) {
    return 'La URL $url no se pudo abrir.';
  }

  @override
  String get enterFullscreen => 'Entrar en Pantalla Completa';

  @override
  String get exitFullscreen => 'Salir de Pantalla Completa';

  @override
  String get editor => 'Editor';

  @override
  String get viewVisualScheme => 'Ver Esquema Visual';

  @override
  String get resetDatabase => 'Restablecer Base de Datos';

  @override
  String get runQuery => 'Ejecutar Consulta';

  @override
  String get clearEditor => 'Limpiar Editor';

  @override
  String get console => 'Consola';

  @override
  String get clearConsole => 'Limpiar Consola';

  @override
  String get schemaCopied => 'Esquema copiado!';

  @override
  String get seedCopied => 'Seed copiada!';

  @override
  String get schemaAndSeedCopied => 'Esquema y Seed copiados!';

  @override
  String get viewStructure => 'Ver Estructura';

  @override
  String get copySchema => 'Copiar Esquema';

  @override
  String get copySeed => 'Copiar Seed';

  @override
  String get copyAll => 'Copiar Todos';

  @override
  String get searchDatabases => 'Buscar bases de datos';

  @override
  String get newDatabase => 'Nueva Base de Datos';

  @override
  String get favorites => 'Favoritos';

  @override
  String get allDatabases => 'Todas las Bases de Datos';

  @override
  String get favorite => 'Favorito';

  @override
  String get unfavorite => 'No favorito';

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get attention => 'Atención';

  @override
  String get deleteDatabaseConfirmation => '¿Está seguro de que desea eliminar permanentemente esta base de datos? Esta acción no se puede deshacer.';

  @override
  String get toDoListLabel => 'Lista de Tareas';

  @override
  String get toDoListDescription => 'Base de datos simple de gestión de tareas';

  @override
  String get contactsLabel => 'Contactos';

  @override
  String get contactsDescription => 'Base de datos de contactos y grupos';

  @override
  String get libraryLabel => 'Biblioteca';

  @override
  String get libraryDescription => 'Biblioteca con libros, miembros y préstamos';

  @override
  String get fitnessClubLabel => 'Club de Fitness';

  @override
  String get fitnessClubDescription => 'Base de datos de miembros del gimnasio y suscripciones';

  @override
  String get carRentalLabel => 'Alquiler de Autos';

  @override
  String get carRentalDescription => 'Base de datos de gestión de alquiler de autos';

  @override
  String get restaurantLabel => 'Restaurante';

  @override
  String get restaurantDescription => 'Base de datos de pedidos y elementos del menú del restaurante';

  @override
  String get hrPayrollLabel => 'Nómina de RR. HH.';

  @override
  String get hrPayrollDescription => 'Departamentos, puestos de trabajo, empleados e historial salarial';

  @override
  String get logisticsLabel => 'Logística';

  @override
  String get logisticsDescription => 'Base de datos de paquetes, conductores, entregas e historial de estado';

  @override
  String get pharmacyLabel => 'Farmacia';

  @override
  String get pharmacyDescription => 'Inventario de farmacia, proveedores, clientes y ventas';

  @override
  String get schoolLabel => 'Escuela';

  @override
  String get schoolDescription => 'Gestión escolar con estudiantes, profesores, clases, matrículas y calificaciones';

  @override
  String get socialNetworkLabel => 'Red Social';

  @override
  String get socialNetworkDescription => 'Red social con usuarios, publicaciones, comentarios, me gusta y seguidores';

  @override
  String get hotelLabel => 'Hotel';

  @override
  String get hotelDescription => 'Base de datos de reservas, habitaciones, pagos, empleados y servicios';

  @override
  String get bankingLabel => 'Banca';

  @override
  String get bankingDescription => 'Sistema bancario con cuentas, transacciones, préstamos y empleados';

  @override
  String get eCommerceLabel => 'Comercio Electrónico';

  @override
  String get eCommerceDescription => 'Tienda en línea con productos, pedidos, carritos y reseñas';

  @override
  String get openFullscreen => 'Abrir pantalla completa';

  @override
  String get options => 'Opciones';

  @override
  String get table => 'Tabla';

  @override
  String get tables => 'Tablas';

  @override
  String get splitLayout => 'Diseño Dividido';

  @override
  String get splitLayoutSubtitle => 'Editor arriba y consola abajo.';

  @override
  String get tabsLayout => 'Diseño por Pestañas';

  @override
  String get tabsLayoutSubtitle => 'Editor y consola en pestañas.';

  @override
  String get preview => 'Vista previa:';

  @override
  String get layoutSaved => 'Diseño guardado';

  @override
  String get suggestionSettings => 'Configuración de Sugerencias';

  @override
  String get suggestionModes => 'Modos de Sugerencia';

  @override
  String get basicSuggestions => 'Sugerencias Básicas';

  @override
  String get basicSuggestionsDescription => 'Muestra ejemplos SQL completos como \"SELECT * FROM\". Ideal para consultas rápidas.';

  @override
  String get advancedSuggestions => 'Sugerencias Avanzadas';

  @override
  String get advancedSuggestionsDescription => 'Muestra pistas cortas como \"ALL\" o \"COUNT\" que se expanden en sentencias SQL completas al hacer clic.';

  @override
  String get otherSuggestions => 'Otras Sugerencias';

  @override
  String get characterSuggestions => 'Sugerencias de Caracteres';

  @override
  String get characterSuggestionsDescription => 'Agrega botones rápidos para >, =, !, %, ; y más.';

  @override
  String get saveSettings => 'Guardar Configuración';

  @override
  String get advancedSuggestionsInitialized => 'Las sugerencias avanzadas se han inicializado correctamente.';

  @override
  String get advancedSuggestionsFailed => 'Error al inicializar las sugerencias avanzadas.';

  @override
  String get settingsSavedSuccessfully => '¡Configuración guardada con éxito!';

  @override
  String get configure => 'Configurar';

  @override
  String get createSuggestion => 'Crear Sugerencia';

  @override
  String get suggestionName => 'Nombre de la sugerencia';

  @override
  String get create => 'Crear';

  @override
  String get enterSuggestionName => 'Ingrese un nombre para la sugerencia.';

  @override
  String get invalidCharacters => 'Caracteres inválidos';

  @override
  String get removeSuggestion => 'Eliminar Sugerencia';

  @override
  String get removeSuggestionDescription => '¿Estás seguro de que deseas eliminar esta sugerencia?';

  @override
  String get remove => 'Eliminar';

  @override
  String get resetSuggestions => 'Restablecer Sugerencias';

  @override
  String get resetSuggestionsDescription => '¿Estás seguro de que deseas restablecer la lista de sugerencias?';

  @override
  String get reset => 'Restablecer';

  @override
  String get advancedSuggestionAdded => 'Sugerencia agregada con éxito.';

  @override
  String get advancedSuggestionFailed => 'Error al agregar la sugerencia.';

  @override
  String deleteSuggestionConfirmation(Object label) {
    return '¿Está seguro de que desea eliminar la sugerencia \"$label\"?';
  }

  @override
  String get suggestionDeleted => 'Sugerencia eliminada con éxito.';

  @override
  String get suggestionDeleteFailed => 'Error al eliminar la sugerencia.';

  @override
  String get resetSuggestionsConfirm => '¿Estás seguro de que deseas restablecer las sugerencias?';

  @override
  String get suggestionsResetSuccess => 'Todas las sugerencias se han restablecido con éxito.';

  @override
  String get suggestionsResetFailed => 'No se pudieron restablecer las sugerencias. Inténtalo de nuevo.';

  @override
  String get label => 'Etiqueta';

  @override
  String get sqlCode => 'Código SQL';

  @override
  String get selectableTextOptional => 'Texto seleccionable (opcional)';

  @override
  String get selectableTextHint => 'Parte del SQL que será seleccionada automáticamente para reemplazo';

  @override
  String get fieldRequired => 'Este campo es obligatorio';

  @override
  String get updateSuggestion => 'Actualizar Sugerencia';

  @override
  String get update => 'Actualizar';

  @override
  String get updateSuggestionSuccess => 'Sugerencia actualizada con éxito.';

  @override
  String get updateSuggestionFail => 'No se pudo actualizar la sugerencia.';

  @override
  String get editSuggestion => 'Editar sugerencia';

  @override
  String get deleteSuggestion => 'Eliminar sugerencia';

  @override
  String get save => 'Guardar';

  @override
  String get exitScreen => 'Salir de la pantalla';

  @override
  String get error => 'Error';

  @override
  String get failedToSaveWorkspaceLayout => 'No se pudo guardar el diseño del espacio de trabajo. Por favor, inténtalo de nuevo.';

  @override
  String databaseCreationError(Object databaseName) {
    return 'No se pudo crear la base de datos \"$databaseName\".';
  }

  @override
  String get fetchDatabasesError => 'No se pudo obtener las bases de datos creadas.';

  @override
  String get checkDatabaseExistsError => 'No se pudo comprobar si la base de datos ya existe.';

  @override
  String deleteDatabaseError(Object databaseName) {
    return 'No se pudo eliminar la base de datos \"$databaseName\".';
  }

  @override
  String get noRecordDeleted => 'Ningún registro fue eliminado';

  @override
  String toggleDatabaseFavoriteError(Object databaseName) {
    return 'No se pudo cambiar el estado de favorito de la base de datos \"$databaseName\".';
  }

  @override
  String get unableToClear => 'No se pueden borrar las bases de datos';

  @override
  String get failedToGetAppVersion => 'No se pudo obtener la versión de la aplicación';

  @override
  String sqlExecutionError(Object error) {
    return 'SQL execution error: $error';
  }

  @override
  String get noDatabaseSelected => 'Ninguna base de datos seleccionada';

  @override
  String get failedToLoadSqlSuggestions => 'No se pudieron cargar las sugerencias SQL';

  @override
  String get failedToSaveSqlSuggestionsSettings => 'No se pudieron guardar las configuraciones de sugerencias SQL';

  @override
  String get failedToLoadAdvancedSuggestions => 'No se pudieron cargar las sugerencias avanzadas';

  @override
  String get failedToAddAdvancedSuggestion => 'No se pudo agregar la sugerencia avanzada';

  @override
  String get failedToUpdateAdvancedSuggestion => 'No se pudo actualizar la sugerencia avanzada';

  @override
  String get failedToRemoveAdvancedSuggestion => 'No se pudo eliminar la sugerencia avanzada';

  @override
  String get failedToSaveAllAdvancedSuggestions => 'No se pudieron guardar todas las sugerencias avanzadas';

  @override
  String get failedToReorderAdvancedSuggestions => 'No se pudieron reordenar las sugerencias avanzadas';

  @override
  String get failedToResetAdvancedSuggestions => 'No se pudieron restablecer las sugerencias avanzadas';

  @override
  String get failedToLoadBasicSuggestions => 'No se pudieron cargar las sugerencias básicas';

  @override
  String get failedToAddBasicSuggestion => 'No se pudo agregar la sugerencia básica';

  @override
  String get failedToUpdateBasicSuggestions => 'No se pudieron actualizar las sugerencias básicas';

  @override
  String get failedToRemoveBasicSuggestion => 'No se pudo eliminar la sugerencia básica';

  @override
  String get failedToResetBasicSuggestions => 'No se pudieron restablecer las sugerencias básicas';

  @override
  String failedToLoadSqlFiles(Object error) {
    return 'Error al cargar los archivos SQL: $error';
  }

  @override
  String failedToExecuteSql(Object dbName, Object error) {
    return 'Error al ejecutar SQL para \"$dbName\": $error';
  }

  @override
  String get databaseResetSuccessfully => 'Base de datos restablecida correctamente';

  @override
  String get unknownError => 'Error desconocido';

  @override
  String get createDatabase => 'Crear Base de Datos';

  @override
  String get name => 'Nombre';

  @override
  String get pleaseEnterLabel => 'Por favor, ingrese una etiqueta';

  @override
  String get pleaseEnterName => 'Por favor, ingrese un nombre';

  @override
  String get invalidCharactersDetected => 'Se detectaron caracteres no válidos';

  @override
  String databaseAlreadyExists(Object name) {
    return 'La base de datos \"$name\" ya existe';
  }

  @override
  String languageUpdated(Object lang) {
    return 'Idioma actualizado a $lang.';
  }

  @override
  String get loading => 'Cargando...';

  @override
  String get theDatabaseIsEmpty => 'La base de datos está vacía';

  @override
  String get toggleTheme => 'Cambiar tema';

  @override
  String get screenNotFound => 'Pantalla no encontrada';

  @override
  String get screenNotFoundDescription => 'La pantalla que buscas no existe o ha sido movida.';

  @override
  String get goHome => 'Ir al inicio';
}
