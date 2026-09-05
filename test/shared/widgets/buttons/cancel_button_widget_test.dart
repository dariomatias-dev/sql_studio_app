import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/buttons/cancel_button_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  );

  group('CancelButtonWidget', () {
    testWidgets('renders the localized cancel label', (tester) async {
      await tester.pumpWidget(wrap(const CancelButtonWidget()));

      final localizations = AppLocalizations.of(
        tester.element(find.byType(CancelButtonWidget)),
      );

      expect(find.text(localizations.cancel), findsOneWidget);
    });

    testWidgets('pops the current route when tapped', (tester) async {
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const Scaffold(
                        body: CancelButtonWidget(),
                      ),
                    ),
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

      final localizations = AppLocalizations.of(
        tester.element(find.byType(CancelButtonWidget)),
      );

      expect(find.text(localizations.cancel), findsOneWidget);

      await tester.tap(find.text(localizations.cancel));
      await tester.pumpAndSettle();

      expect(find.byType(CancelButtonWidget), findsNothing);
      expect(find.text('Open'), findsOneWidget);
    });
  });
}
