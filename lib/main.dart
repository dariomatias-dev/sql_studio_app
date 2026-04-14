import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:sql_studio/src/sql_studio_app.dart';

import 'package:sql_studio/src/core/app_localization_notifier.dart';

import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_advanced_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifiers/sql_basic_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/app_version_notifier.dart';
import 'package:sql_studio/src/notifiers/database_notifier.dart';
import 'package:sql_studio/src/notifiers/navigation_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_commands_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_editor_notifier.dart';
import 'package:sql_studio/src/notifiers/sql_suggestions_notifier.dart';
import 'package:sql_studio/src/notifiers/workspace_layout_notifier.dart';

import 'package:sql_studio/src/services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesService.init();

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (_) => AppLocalizationNotifier()),
        ChangeNotifierProvider(create: (_) => SqlAdvancedSuggestionsNotifier()),
        ChangeNotifierProvider(create: (_) => SqlBasicSuggestionsNotifier()),
        ChangeNotifierProvider(create: (_) => AppVersionNotifier()),
        ChangeNotifierProvider(create: (_) => DatabaseNotifier()),
        ChangeNotifierProvider(create: (_) => NavigationNotifier()),
        ChangeNotifierProvider(create: (_) => SqlCommandsNotifier()),
        ChangeNotifierProvider(create: (_) => SqlEditorNotifier()),
        ChangeNotifierProvider(create: (_) => SqlSuggestionsNotifier()),
        ChangeNotifierProvider(create: (_) => WorkspaceLayoutNotifier()),
      ],
      child: const SqlStudioApp(),
    ),
  );
}
