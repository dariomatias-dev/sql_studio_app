import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/screens/about/license_detail_screen.dart';
import 'package:sql_studio/src/core/screens/about/licenses_screen.dart';

Stream<LicenseEntry> _license(String package, String text) async* {
  yield LicenseEntryWithLineBreaks([package], text);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(LicenseRegistry.reset);
  tearDown(LicenseRegistry.reset);

  Widget wrap(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: child,
      ),
    );
  }

  testWidgets('lists every registered package, sorted by name', (
    tester,
  ) async {
    LicenseRegistry.addLicense(() => _license('zebra_package', 'MIT'));
    LicenseRegistry.addLicense(() => _license('anchor_package', 'MIT'));

    await tester.pumpWidget(wrap(const LicensesScreen()));
    await tester.pumpAndSettle();

    expect(find.text('2 open-source packages'), findsOneWidget);

    final anchorY = tester.getTopLeft(find.text('anchor_package')).dy;
    final zebraY = tester.getTopLeft(find.text('zebra_package')).dy;

    expect(anchorY, lessThan(zebraY));
  });

  testWidgets('shows an empty count when no licenses are registered', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const LicensesScreen()));
    await tester.pumpAndSettle();

    expect(find.text('0 open-source packages'), findsOneWidget);
  });

  testWidgets('tapping a package navigates to its license detail', (
    tester,
  ) async {
    LicenseRegistry.addLicense(() => _license('some_package', 'MIT license'));

    await tester.pumpWidget(wrap(const LicensesScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('some_package'));
    await tester.pumpAndSettle();

    expect(find.byType(LicenseDetailScreen), findsOneWidget);
    expect(find.text('some_package'), findsOneWidget);
  });
}
