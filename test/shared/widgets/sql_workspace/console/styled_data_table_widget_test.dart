import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/styled_data_table_widget.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
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
}
