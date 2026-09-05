import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_card_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_group_widget.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';

import '../../../../../test_helpers/shared_preferences_test_helper.dart';

void main() {
  late SharedPreferencesService prefs;

  setUp(() async {
    prefs = await fakeSharedPreferencesService();
  });

  Widget wrap(Widget child) {
    return ProviderScope(
      overrides: [sharedPreferencesServiceProvider.overrideWithValue(prefs)],
      child: MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(drawer: Drawer(child: child)),
      ),
    );
  }

  testWidgets('renders the title and a card per database', (tester) async {
    final databases = [
      DatabaseEntity(label: 'Todo List', name: 'todo_list'),
      DatabaseEntity(label: 'Contacts', name: 'contacts'),
    ];

    await tester.pumpWidget(
      wrap(
        RootDrawerDatabaseGroupWidget(title: 'Favorites', databases: databases),
      ),
    );

    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('FAVORITES'), findsOneWidget);
    expect(find.byType(RootDrawerDatabaseCardWidget), findsNWidgets(2));
    expect(find.text('Todo List'), findsOneWidget);
    expect(find.text('Contacts'), findsOneWidget);
  });

  testWidgets('renders nothing when the database list is empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const RootDrawerDatabaseGroupWidget(
          title: 'Favorites',
          databases: <DatabaseEntity>[],
        ),
      ),
    );

    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('FAVORITES'), findsNothing);
    expect(find.byType(RootDrawerDatabaseCardWidget), findsNothing);
    expect(find.byType(SizedBox), findsWidgets);
  });
}
