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
  String get errorOpeningUrl => 'Error al abrir URL';

  @override
  String errorOpeningUrlDescription(Object url) {
    return 'La URL $url no se pudo abrir.';
  }
}
