import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_suggestions_bar_widget.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: child),
    );
  }

  testWidgets('renders one chip per item and reports the tapped index', (
    tester,
  ) async {
    final tapped = <int>[];
    final items = ['SELECT', 'FROM', 'WHERE'];

    await tester.pumpWidget(
      wrap(
        SqlSuggestionsBarBaseWidget(
          onTap: tapped.add,
          itemCount: items.length,
          itemBuilder: (index) => items[index],
        ),
      ),
    );

    expect(find.text('SELECT'), findsOneWidget);
    expect(find.text('FROM'), findsOneWidget);
    expect(find.text('WHERE'), findsOneWidget);

    await tester.tap(find.text('FROM'));
    await tester.pump();

    expect(tapped, [1]);
  });

  testWidgets('renders no chips when itemCount is zero', (tester) async {
    await tester.pumpWidget(
      wrap(
        SqlSuggestionsBarBaseWidget(
          onTap: (_) {},
          itemCount: 0,
          itemBuilder: (index) => 'unused',
        ),
      ),
    );

    expect(find.byType(InkWell), findsNothing);
  });
}
