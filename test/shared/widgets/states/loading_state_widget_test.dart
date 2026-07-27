import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/states/loading_state_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: child),
  );

  group('LoadingStateWidget', () {
    testWidgets('renders a CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(wrap(const LoadingStateWidget()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('does not render a message by default', (tester) async {
      await tester.pumpWidget(wrap(const LoadingStateWidget()));

      expect(find.byType(Text), findsNothing);
    });

    testWidgets('renders the message when provided', (tester) async {
      await tester.pumpWidget(
        wrap(const LoadingStateWidget(message: 'Loading databases...')),
      );

      expect(find.text('Loading databases...'), findsOneWidget);
    });

    testWidgets('sizes the spinner according to size', (tester) async {
      await tester.pumpWidget(wrap(const LoadingStateWidget(size: 48)));

      final sizedBox = tester.widget<SizedBox>(
        find
            .ancestor(
              of: find.byType(CircularProgressIndicator),
              matching: find.byType(SizedBox),
            )
            .first,
      );

      expect(sizedBox.width, 48);
      expect(sizedBox.height, 48);
    });
  });
}
