import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/divider_bar_widget.dart';

void main() {
  Future<void> pumpDivider(
    WidgetTester tester,
    GestureDragUpdateCallback onDragUpdate,
  ) {
    return tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(body: DividerBarWidget(onDragUpdate: onDragUpdate)),
      ),
    );
  }

  testWidgets('renders without throwing', (tester) async {
    await pumpDivider(tester, (_) {});

    expect(find.byType(DividerBarWidget), findsOneWidget);
  });

  testWidgets('reports the vertical drag delta while dragging', (
    tester,
  ) async {
    final deltas = <double>[];

    await pumpDivider(tester, (details) => deltas.add(details.delta.dy));

    await tester.drag(find.byType(DividerBarWidget), const Offset(0, 30));

    expect(deltas, isNotEmpty);
    expect(deltas.reduce((a, b) => a + b), closeTo(30, 0.01));
  });
}
