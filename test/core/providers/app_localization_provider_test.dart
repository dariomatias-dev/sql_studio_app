import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/providers/app_localization_provider.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;

  Future<void> initPrefs([Map<String, Object> values = const {}]) async {
    SharedPreferences.setMockInitialValues(values);
    await SharedPreferencesService.init();
  }

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  test('defaults to English when nothing is persisted', () async {
    await initPrefs();

    final locale = container.read(appLocalizationViewModelProvider);

    expect(locale, const Locale('en'));
  });

  test('reads the persisted locale code', () async {
    await initPrefs({SharedPreferencesKeys.localeKey: 'pt'});

    final locale = container.read(appLocalizationViewModelProvider);

    expect(locale, const Locale('pt'));
  });

  test('changeLocale updates the state and persists the choice', () async {
    await initPrefs();

    final viewModel = container.read(
      appLocalizationViewModelProvider.notifier,
    );

    await viewModel.changeLocale('es');

    expect(
      container.read(appLocalizationViewModelProvider),
      const Locale('es'),
    );
    expect(
      SharedPreferencesService.getString(SharedPreferencesKeys.localeKey),
      'es',
    );
  });
}
