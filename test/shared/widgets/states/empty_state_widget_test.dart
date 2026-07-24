import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/shared/widgets/states/empty_state_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('EmptyStateWidget', () {
    testWidgets('renders the default icon and the message', (tester) async {
      await tester.pumpWidget(
        wrap(const EmptyStateWidget(message: 'No databases yet')),
      );

      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
      expect(find.text('No databases yet'), findsOneWidget);
    });

    testWidgets('renders a custom icon when provided', (tester) async {
      await tester.pumpWidget(
        wrap(
          const EmptyStateWidget(
            message: 'No tables',
            icon: Icons.table_chart_outlined,
          ),
        ),
      );

      expect(find.byIcon(Icons.table_chart_outlined), findsOneWidget);
      expect(find.byIcon(Icons.inbox_outlined), findsNothing);
    });

    testWidgets('does not render an action by default', (tester) async {
      await tester.pumpWidget(
        wrap(const EmptyStateWidget(message: 'No databases yet')),
      );

      expect(find.byType(ElevatedButton), findsNothing);
      expect(find.byKey(const Key('emptyStateAction')), findsNothing);
    });

    testWidgets('renders the provided action widget', (tester) async {
      await tester.pumpWidget(
        wrap(
          EmptyStateWidget(
            message: 'No databases yet',
            action: ElevatedButton(
              key: const Key('emptyStateAction'),
              onPressed: () {},
              child: const Text('Create database'),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('emptyStateAction')), findsOneWidget);
      expect(find.text('Create database'), findsOneWidget);
    });
  });
}
