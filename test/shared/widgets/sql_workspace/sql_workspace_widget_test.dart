import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/console_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/divider_bar_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_editor_widget.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

void main() {
  Future<void> initPrefs([Map<String, Object> values = const {}]) async {
    SharedPreferences.setMockInitialValues(values);
    await SharedPreferencesService.init();
  }

  Future<void> pumpWorkspace(WidgetTester tester) {
    return tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const Scaffold(body: SqlWorkspaceWidget()),
        ),
      ),
    );
  }

  testWidgets('shows the editor and console stacked in a split view', (
    tester,
  ) async {
    await initPrefs();

    await pumpWorkspace(tester);

    expect(find.byType(SqlEditorWidget), findsOneWidget);
    expect(find.byType(ConsoleWidget), findsOneWidget);
    expect(find.byType(DividerBarWidget), findsOneWidget);
  });

  testWidgets('shows the editor and console as tabs when configured', (
    tester,
  ) async {
    await initPrefs({'workspace_layout': 'tabs'});

    await pumpWorkspace(tester);

    expect(find.text('Editor'), findsOneWidget);
    expect(find.text('Console'), findsOneWidget);
    expect(find.byType(DividerBarWidget), findsNothing);

    await tester.tap(find.text('Console'));
    await tester.pumpAndSettle();

    expect(find.text('Run a query to see the results here'), findsOneWidget);
  });

  testWidgets('dragging the divider changes the panels relative sizes', (
    tester,
  ) async {
    await initPrefs();

    await pumpWorkspace(tester);

    List<Flexible> flexibles() => tester
        .widgetList<Flexible>(find.byType(Flexible))
        .toList(growable: false);

    final before = flexibles();
    final editorFlexBefore = before.first.flex;

    await tester.drag(find.byType(DividerBarWidget), const Offset(0, -100));
    await tester.pumpAndSettle();

    final editorFlexAfter = flexibles().first.flex;

    expect(editorFlexAfter, isNot(editorFlexBefore));
  });

  testWidgets('maximizing the editor panel hides the console', (
    tester,
  ) async {
    await initPrefs();

    await pumpWorkspace(tester);

    await tester.tap(find.byTooltip('Enter Fullscreen').first);
    await tester.pumpAndSettle();

    expect(find.byType(SqlEditorWidget), findsOneWidget);
    expect(find.byType(ConsoleWidget), findsNothing);
    expect(find.byTooltip('Exit Fullscreen'), findsOneWidget);

    await tester.tap(find.byTooltip('Exit Fullscreen'));
    await tester.pumpAndSettle();

    expect(find.byType(ConsoleWidget), findsOneWidget);
  });
}
