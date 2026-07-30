import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/providers/app_theme_mode_provider.dart';
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

  test('defaults to system when nothing is persisted', () async {
    await initPrefs();

    final mode = container.read(appThemeModeViewModelProvider);

    expect(mode, ThemeMode.system);
  });

  test('reads the persisted theme mode', () async {
    await initPrefs({SharedPreferencesKeys.themeModeKey: 'dark'});

    final mode = container.read(appThemeModeViewModelProvider);

    expect(mode, ThemeMode.dark);
  });

  test('falls back to system for an unrecognized persisted value', () async {
    await initPrefs({SharedPreferencesKeys.themeModeKey: 'garbage'});

    final mode = container.read(appThemeModeViewModelProvider);

    expect(mode, ThemeMode.system);
  });

  test('changeThemeMode updates the state and persists the choice', () async {
    await initPrefs();

    final viewModel = container.read(
      appThemeModeViewModelProvider.notifier,
    );

    await viewModel.changeThemeMode(ThemeMode.light);

    expect(container.read(appThemeModeViewModelProvider), ThemeMode.light);
    expect(
      SharedPreferencesService.getString(SharedPreferencesKeys.themeModeKey),
      'light',
    );
  });
}
