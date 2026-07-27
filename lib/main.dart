import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/sql_studio_app.dart';

/// Global container so utilities outside the widget tree (e.g. AppToast)
/// can read providers without threading a [WidgetRef] through every call.
final appProviderContainer = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesService.init();

  runApp(
    UncontrolledProviderScope(
      container: appProviderContainer,
      child: const SqlStudioApp(),
    ),
  );
}
