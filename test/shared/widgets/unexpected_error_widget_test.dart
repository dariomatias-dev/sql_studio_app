import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/shared/widgets/unexpected_error_widget.dart';

void main() {
  testWidgets('shows the localized unexpected error message', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: UnexpectedErrorWidget(),
      ),
    );

    final l10n = AppLocalizations.of(
      tester.element(find.byType(UnexpectedErrorWidget)),
    );

    expect(find.text(l10n.unexpectedError), findsOneWidget);
  });
}
