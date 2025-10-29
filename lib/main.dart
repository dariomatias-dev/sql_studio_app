import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/sql_studio_app.dart';

import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/database_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SqlCommandsNotifier()),
        ChangeNotifierProvider(create: (context) => DatabaseNotifier()),
      ],
      child: const SqlStudioApp(),
    ),
  );
}
