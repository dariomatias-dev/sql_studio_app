import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/services/shared_preferences_service.dart';
import 'package:sql_studio/src/sql_studio_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesService.init();

  runApp(const ProviderScope(child: SqlStudioApp()));
}
