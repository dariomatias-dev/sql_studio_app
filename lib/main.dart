import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/sql_studio_app.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/database_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SqlSuggestionsNotifier()),
        ChangeNotifierProvider(create: (_) => DatabaseNotifier()),
      ],
      child: const SqlStudioApp(),
    ),
  );
}
