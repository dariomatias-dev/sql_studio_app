import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_character_bar_widget.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );
  }

  testWidgets('renders every quick-insert character', (tester) async {
    await tester.pumpWidget(
      wrap(SqlCharacterBarWidget(onInsertCommand: (_, {selectText}) {})),
    );

    for (final char in characters) {
      expect(find.text(char), findsOneWidget);
    }
  });

  testWidgets('inserts the tapped character', (tester) async {
    final inserted = <String>[];

    await tester.pumpWidget(
      wrap(
        SqlCharacterBarWidget(
          onInsertCommand: (command, {selectText}) => inserted.add(command),
        ),
      ),
    );

    await tester.tap(find.text(';'));
    await tester.pump();

    expect(inserted, [';']);
  });
}
