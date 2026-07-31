import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/screens/about/about_screen.dart';
import 'package:sql_studio/src/core/screens/about/licenses_screen.dart';
import 'package:sql_studio/src/features/app_version/presentation/providers.dart';
import 'package:sql_studio/src/features/app_version/presentation/view_models/app_version_state.dart';
import 'package:sql_studio/src/features/app_version/presentation/view_models/app_version_view_model.dart';

class _FixedAppVersionViewModel extends AppVersionViewModel {
  @override
  AppVersionState build() =>
      const AppVersionState(formattedVersion: '1.2.3+45');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap(Widget child, {List<Override> overrides = const []}) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: child,
      ),
    );
  }

  testWidgets('shows the app name and placeholder version by default', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const AboutScreen()));

    expect(find.text('SQL Studio'), findsOneWidget);
    expect(find.text('Version -.-.-'), findsOneWidget);
  });

  testWidgets('shows the loaded app version', (tester) async {
    await tester.pumpWidget(
      wrap(
        const AboutScreen(),
        overrides: [
          appVersionViewModelProvider.overrideWith(
            _FixedAppVersionViewModel.new,
          ),
        ],
      ),
    );

    expect(find.text('Version 1.2.3+45'), findsOneWidget);
  });

  testWidgets('navigates to the licenses screen', (tester) async {
    await tester.pumpWidget(wrap(const AboutScreen()));

    await tester.tap(find.text('Licenses'));
    await tester.pumpAndSettle();

    expect(find.byType(LicensesScreen), findsOneWidget);
  });
}
