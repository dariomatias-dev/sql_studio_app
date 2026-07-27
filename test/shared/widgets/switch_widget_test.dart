import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/switch_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: child),
  );

  group('SwitchWidget', () {
    testWidgets('calls onChanged with true when tapped while off', (
      tester,
    ) async {
      bool? newValue;

      await tester.pumpWidget(
        wrap(
          SwitchWidget(
            value: false,
            onChanged: (value) => newValue = value,
          ),
        ),
      );

      await tester.tap(find.byType(SwitchWidget));

      expect(newValue, isTrue);
    });

    testWidgets('calls onChanged with false when tapped while on', (
      tester,
    ) async {
      bool? newValue;

      await tester.pumpWidget(
        wrap(
          SwitchWidget(
            value: true,
            onChanged: (value) => newValue = value,
          ),
        ),
      );

      await tester.tap(find.byType(SwitchWidget));

      expect(newValue, isFalse);
    });
  });
}
