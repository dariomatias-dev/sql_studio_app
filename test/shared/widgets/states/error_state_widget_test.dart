import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/shared/widgets/buttons/button_widget.dart';
import 'package:sql_studio/src/shared/widgets/states/error_state_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('ErrorStateWidget', () {
    testWidgets('renders the default icon and the message', (tester) async {
      await tester.pumpWidget(
        wrap(const ErrorStateWidget(message: 'Something went wrong')),
      );

      expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('renders a custom icon when provided', (tester) async {
      await tester.pumpWidget(
        wrap(
          const ErrorStateWidget(
            message: 'Offline',
            icon: Icons.wifi_off_rounded,
          ),
        ),
      );

      expect(find.byIcon(Icons.wifi_off_rounded), findsOneWidget);
      expect(find.byIcon(Icons.error_outline_rounded), findsNothing);
    });

    testWidgets('does not render a retry button by default', (tester) async {
      await tester.pumpWidget(
        wrap(const ErrorStateWidget(message: 'Something went wrong')),
      );

      expect(find.byType(ButtonWidget), findsNothing);
    });

    testWidgets('renders a retry button when onRetry is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          ErrorStateWidget(
            message: 'Something went wrong',
            onRetry: () {},
            retryText: 'Try again',
          ),
        ),
      );

      expect(find.byType(ButtonWidget), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
    });

    testWidgets('invokes onRetry when the retry button is tapped', (
      tester,
    ) async {
      var retried = false;

      await tester.pumpWidget(
        wrap(
          ErrorStateWidget(
            message: 'Something went wrong',
            onRetry: () => retried = true,
          ),
        ),
      );

      await tester.tap(find.byType(ButtonWidget));
      await tester.pumpAndSettle();

      expect(retried, isTrue);
    });
  });
}
