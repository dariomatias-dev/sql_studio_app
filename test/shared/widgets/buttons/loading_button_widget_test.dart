import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/shared/widgets/buttons/loading_button_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('LoadingButtonWidget', () {
    testWidgets('renders the text and calls onPressed when tapped', (
      tester,
    ) async {
      var callCount = 0;

      await tester.pumpWidget(
        wrap(
          LoadingButtonWidget(
            text: 'Save',
            onPressed: () async {
              callCount++;
            },
          ),
        ),
      );

      expect(find.text('Save'), findsOneWidget);

      await tester.tap(find.byType(LoadingButtonWidget));
      await tester.pumpAndSettle();

      expect(callCount, 1);
    });

    testWidgets('shows a spinner while onPressed is pending and ignores '
        'further taps', (tester) async {
      final completer = Completer<void>();
      var callCount = 0;

      await tester.pumpWidget(
        wrap(
          LoadingButtonWidget(
            text: 'Save',
            onPressed: () {
              callCount++;
              return completer.future;
            },
          ),
        ),
      );

      await tester.tap(find.byType(LoadingButtonWidget));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Save'), findsNothing);

      await tester.tap(find.byType(LoadingButtonWidget));
      await tester.pump();

      expect(callCount, 1);

      completer.complete();
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        wrap(const LoadingButtonWidget(text: 'Save')),
      );

      final inkWell = tester.widget<InkWell>(find.byType(InkWell));

      expect(inkWell.onTap, isNull);
    });
  });
}
