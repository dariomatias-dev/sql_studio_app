import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/shared/utils/handle_error.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  );

  group('handleError', () {
    testWidgets('invokes onSuccess with the unwrapped value on success', (
      tester,
    ) async {
      int? received;

      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => handleError<int>(
                  context,
                  const SuccessResult<int>(42),
                  onSuccess: (value) async {
                    received = value;
                  },
                ),
                child: const Text('Run'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Run'));
      await tester.pumpAndSettle();

      expect(received, 42);
      expect(find.byType(Dialog), findsNothing);
    });

    testWidgets('shows an error dialog with the localized message on '
        'failure', (tester) async {
      await tester.pumpWidget(
        wrap(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => handleError<int>(
                  context,
                  const FailureResult<int>(
                    AppFailure(AppLocalizationsKey.unknownError),
                  ),
                ),
                child: const Text('Run'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Run'));
      await tester.pumpAndSettle();

      final localizations = AppLocalizations.of(
        tester.element(find.byType(Dialog)),
      )!;

      expect(find.text(localizations.error), findsOneWidget);
      expect(find.text(localizations.unknownError), findsOneWidget);

      await tester.tap(find.text('Ok'));
      await tester.pumpAndSettle();

      expect(find.byType(Dialog), findsNothing);
    });
  });
}
