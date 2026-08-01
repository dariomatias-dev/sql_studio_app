import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/dialogs/dialog_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: child),
  );

  group('DialogWidget', () {
    testWidgets('renders the content without a title when none is given', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(const DialogWidget(content: Text('Body'))),
      );

      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('renders the title when given', (tester) async {
      await tester.pumpWidget(
        wrap(
          const DialogWidget(title: 'Heads up', content: Text('Body')),
        ),
      );

      expect(find.text('Heads up'), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
    });

    testWidgets('renders the given actions', (tester) async {
      await tester.pumpWidget(
        wrap(
          DialogWidget(
            content: const Text('Body'),
            actions: <Widget>[
              ElevatedButton(onPressed: () {}, child: const Text('Cancel')),
              ElevatedButton(onPressed: () {}, child: const Text('Confirm')),
            ],
          ),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
    });

    testWidgets('show displays the dialog and returns its popped result', (
      tester,
    ) async {
      String? result;

      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await DialogWidget.show<String>(
                    context,
                    title: 'Confirm',
                    content: const Text('Proceed?'),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, 'yes'),
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm'), findsOneWidget);

      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      expect(result, 'yes');
    });

    testWidgets('barrierDismissible false prevents dismissing by tapping '
        'outside', (tester) async {
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => DialogWidget.show<void>(
                  context,
                  content: const Text('Body'),
                  barrierDismissible: false,
                ),
                child: const Text('Open'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tapAt(const Offset(5, 5));
      await tester.pumpAndSettle();

      expect(find.text('Body'), findsOneWidget);
    });
  });
}
