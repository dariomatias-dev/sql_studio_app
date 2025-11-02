import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/sql_studio_app.dart';

import 'package:sql_studio/src/notifiers/app_version_notifier.dart';
import 'package:sql_studio/src/notifiers/database_notifier.dart';
import 'package:sql_studio/src/notifiers/main_screen_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppVersionNotifier()),
        ChangeNotifierProvider(create: (_) => DatabaseNotifier()),
        ChangeNotifierProvider(create: (_) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (_) => SqlCommandsNotifier()),
        ChangeNotifierProvider(create: (_) => SqlSuggestionsNotifier()),
      ],
      child: const SqlStudioApp(),
    ),
  );
}
