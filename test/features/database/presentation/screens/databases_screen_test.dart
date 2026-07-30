import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/features/database/presentation/screens/databases_screen.dart';

void main() {
  Widget wrap(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: child,
      ),
    );
  }

  testWidgets('renders every default database with no filter applied', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const DatabasesScreen()));

    expect(find.text('To-Do List'), findsOneWidget);
    expect(find.text('Contacts'), findsOneWidget);
  });

  testWidgets('filters the list as the search text changes', (tester) async {
    await tester.pumpWidget(wrap(const DatabasesScreen()));

    await tester.enterText(find.byType(TextField), 'to-do');
    await tester.pumpAndSettle();

    expect(find.text('To-Do List'), findsOneWidget);
    expect(find.text('Contacts'), findsNothing);
  });

  testWidgets('shows the empty state when nothing matches the search', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const DatabasesScreen()));

    await tester.enterText(find.byType(TextField), 'no-such-database');
    await tester.pumpAndSettle();

    expect(find.text('No databases found'), findsOneWidget);
  });

  testWidgets('the clear button resets the filter and restores the list', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const DatabasesScreen()));

    await tester.enterText(find.byType(TextField), 'to-do');
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();

    expect(find.text('To-Do List'), findsOneWidget);
    expect(find.text('Contacts'), findsOneWidget);
  });
}
