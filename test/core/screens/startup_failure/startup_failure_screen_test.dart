import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/screens/startup_failure/startup_failure_app.dart';

Future<void> _pumpApp(
  WidgetTester tester, {
  required Future<void> Function() onRetry,
  required Future<void> Function() onClearAppData,
}) async {
  await tester.pumpWidget(
    StartupFailureApp(onRetry: onRetry, onClearAppData: onClearAppData),
  );
  await tester.pumpAndSettle();
}

void main() {
  late AppLocalizations en;

  setUpAll(() async {
    en = await AppLocalizations.delegate.load(const Locale('en'));
  });

  testWidgets('shows the failure title and both actions', (tester) async {
    await _pumpApp(tester, onRetry: () async {}, onClearAppData: () async {});

    expect(find.text(en.startupFailedTitle), findsOneWidget);
    expect(find.text(en.retry), findsOneWidget);
    expect(find.text(en.clearAppData), findsOneWidget);
  });

  testWidgets('tapping retry runs the retry action', (tester) async {
    var retries = 0;

    await _pumpApp(
      tester,
      onRetry: () async => retries++,
      onClearAppData: () async {},
    );

    await tester.tap(find.text(en.retry));
    await tester.pumpAndSettle();

    expect(retries, 1);
  });

  testWidgets('clearing app data asks for confirmation first', (tester) async {
    var cleared = 0;

    await _pumpApp(
      tester,
      onRetry: () async {},
      onClearAppData: () async => cleared++,
    );

    await tester.tap(find.text(en.clearAppData));
    await tester.pumpAndSettle();

    expect(find.text(en.clearAppDataConfirmation), findsOneWidget);
    expect(cleared, 0);

    await tester.tap(find.text(en.cancel));
    await tester.pumpAndSettle();

    expect(cleared, 0);
  });

  testWidgets('confirming runs the clear action', (tester) async {
    var cleared = 0;

    await _pumpApp(
      tester,
      onRetry: () async {},
      onClearAppData: () async => cleared++,
    );

    await tester.tap(find.text(en.clearAppData));
    await tester.pumpAndSettle();

    await tester.tap(find.text(en.clearAppData).last);
    await tester.pumpAndSettle();

    expect(cleared, 1);
  });
}
