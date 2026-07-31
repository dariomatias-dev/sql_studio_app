import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/screens/about/license_detail_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: child,
    );
  }

  testWidgets('shows the package name and every paragraph', (tester) async {
    await tester.pumpWidget(
      wrap(
        const LicenseDetailScreen(
          packageName: 'some_package',
          paragraphs: [
            LicenseParagraph('First paragraph.', 0),
            LicenseParagraph('Second, indented paragraph.', 2),
          ],
        ),
      ),
    );

    expect(find.text('some_package'), findsOneWidget);
    expect(find.text('First paragraph.'), findsOneWidget);
    expect(find.text('Second, indented paragraph.'), findsOneWidget);
  });

  testWidgets('centers paragraphs marked with centeredIndent', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const LicenseDetailScreen(
          packageName: 'some_package',
          paragraphs: [
            LicenseParagraph(
              'Centered title',
              LicenseParagraph.centeredIndent,
            ),
          ],
        ),
      ),
    );

    final text = tester.widget<Text>(find.text('Centered title'));
    expect(text.textAlign, TextAlign.center);
  });
}
