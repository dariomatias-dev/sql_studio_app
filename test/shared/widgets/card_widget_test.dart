import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/card_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: child),
  );

  group('CardWidget', () {
    testWidgets('renders the child', (tester) async {
      await tester.pumpWidget(
        wrap(const CardWidget(child: Text('Content'))),
      );

      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        wrap(
          CardWidget(
            onTap: () => tapped = true,
            child: const Text('Content'),
          ),
        ),
      );

      await tester.tap(find.byType(CardWidget));

      expect(tapped, isTrue);
    });

    testWidgets('is inert when onTap is null', (tester) async {
      await tester.pumpWidget(
        wrap(const CardWidget(child: Text('Content'))),
      );

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));

      expect(inkWell.onTap, isNull);
    });
  });
}
