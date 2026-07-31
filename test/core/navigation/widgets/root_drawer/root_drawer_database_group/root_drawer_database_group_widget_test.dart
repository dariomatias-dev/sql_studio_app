import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_card_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/root_drawer_database_group_widget.dart';
import 'package:sql_studio/src/features/database/data/models/database_model.dart';

void main() {
  Widget wrap(Widget child) {
    return ProviderScope(
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
      DatabaseModel(label: 'Todo List', name: 'todo_list'),
      DatabaseModel(label: 'Contacts', name: 'contacts'),
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
          databases: <DatabaseModel>[],
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
