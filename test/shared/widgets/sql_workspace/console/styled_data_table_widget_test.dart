import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/styled_data_table_widget.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(body: SingleChildScrollView(child: child)),
    );
  }

  testWidgets('renders columns and row values', (tester) async {
    await tester.pumpWidget(
      wrap(
        const StyledDataTableWidget(
          columns: ['id', 'name'],
          rows: [
            {'id': 1, 'name': 'Alice'},
            {'id': 2, 'name': 'Bob'},
          ],
        ),
      ),
    );

    expect(find.text('id'), findsOneWidget);
    expect(find.text('name'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('Alice'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('Bob'), findsOneWidget);
  });

  testWidgets('renders only the header when there are no rows', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(const StyledDataTableWidget(columns: ['id', 'name'], rows: [])),
    );

    expect(find.text('id'), findsOneWidget);
    expect(find.text('name'), findsOneWidget);
    expect(find.byType(DataRow), findsNothing);
  });

  group('paging', () {
    List<Map<String, dynamic>> rows(int count) => <Map<String, dynamic>>[
      for (var i = 0; i < count; i++) {'id': i},
    ];

    testWidgets('builds at most one page of rows at a time', (tester) async {
      await tester.pumpWidget(
        wrap(
          StyledDataTableWidget(
            columns: const ['id'],
            rows: rows(StyledDataTableWidget.rowsPerPage * 2),
          ),
        ),
      );

      final table = tester.widget<DataTable>(find.byType(DataTable));

      expect(table.rows, hasLength(StyledDataTableWidget.rowsPerPage));
      expect(find.text('0'), findsOneWidget);
      expect(find.text('${StyledDataTableWidget.rowsPerPage}'), findsNothing);
    });

    testWidgets('moves to the next and previous page', (tester) async {
      await tester.pumpWidget(
        wrap(
          StyledDataTableWidget(
            columns: const ['id'],
            rows: rows(StyledDataTableWidget.rowsPerPage + 1),
          ),
        ),
      );

      expect(find.text('1-50 of 51'), findsOneWidget);

      await tester.ensureVisible(find.byIcon(Icons.chevron_right));
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      expect(find.text('51-51 of 51'), findsOneWidget);
      expect(find.text('${StyledDataTableWidget.rowsPerPage}'), findsOneWidget);

      await tester.ensureVisible(find.byIcon(Icons.chevron_left));
      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pumpAndSettle();

      expect(find.text('1-50 of 51'), findsOneWidget);
    });

    testWidgets('hides the pager when everything fits on one page', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          StyledDataTableWidget(
            columns: const ['id'],
            rows: rows(StyledDataTableWidget.rowsPerPage),
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_right), findsNothing);
    });

    testWidgets('returns to the first page when the rows change', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          StyledDataTableWidget(
            columns: const ['id'],
            rows: rows(StyledDataTableWidget.rowsPerPage + 1),
          ),
        ),
      );

      await tester.ensureVisible(find.byIcon(Icons.chevron_right));
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pumpAndSettle();

      expect(find.text('51-51 of 51'), findsOneWidget);

      await tester.pumpWidget(
        wrap(
          StyledDataTableWidget(
            columns: const ['id'],
            rows: rows(StyledDataTableWidget.rowsPerPage + 2),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1-50 of 52'), findsOneWidget);
    });
  });
}
