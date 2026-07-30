import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/screens/settings/settings_screen.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  Future<void> initPrefs([Map<String, Object> values = const {}]) async {
    SharedPreferences.setMockInitialValues(values);
    await SharedPreferencesService.init();
  }

  testWidgets('shows English and System by default', (tester) async {
    await initPrefs();

    await tester.pumpWidget(wrap(const SettingsScreen()));

    expect(find.text('English'), findsOneWidget);
    expect(find.text('System'), findsOneWidget);
  });

  testWidgets('shows the persisted language name', (tester) async {
    await initPrefs({SharedPreferencesKeys.localeKey: 'pt'});

    await tester.pumpWidget(wrap(const SettingsScreen()));

    expect(find.text('Português'), findsOneWidget);
  });

  testWidgets('shows the persisted theme mode name', (tester) async {
    await initPrefs({SharedPreferencesKeys.themeModeKey: 'dark'});

    await tester.pumpWidget(wrap(const SettingsScreen()));

    expect(find.text('Dark'), findsOneWidget);
  });

  testWidgets('shows no language value for an unsupported locale code', (
    tester,
  ) async {
    await initPrefs({SharedPreferencesKeys.localeKey: 'xx'});

    await tester.pumpWidget(wrap(const SettingsScreen()));

    expect(find.text('English'), findsNothing);
    expect(find.text('Español'), findsNothing);
    expect(find.text('Português'), findsNothing);
  });
}
