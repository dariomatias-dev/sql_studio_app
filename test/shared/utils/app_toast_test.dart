import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/main.dart';
import 'package:sql_studio/src/core/constants/shared_preferences_keys.dart';
import 'package:sql_studio/src/core/providers/app_theme_mode_provider.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/shared/utils/app_toast.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('PonnamKarthik/fluttertoast');

  Future<Map<Object?, Object?>> captureCall(
    WidgetTester tester,
    Future<void> Function() run,
  ) async {
    Map<Object?, Object?>? args;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          args = call.arguments as Map<Object?, Object?>;
          return true;
        });
    addTearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    await run();
    await tester.pump(const Duration(seconds: 2));

    return args!;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKeys.themeModeKey: mode.name,
    });
    await SharedPreferencesService.init();
    appProviderContainer.invalidate(appThemeModeViewModelProvider);
  }

  group('AppToast.show', () {
    testWidgets('uses a white chip in dark mode', (tester) async {
      await setThemeMode(ThemeMode.dark);

      final args = await captureCall(tester, () => AppToast.show('Saved'));

      expect(args['msg'], 'Saved');
      expect(args['bgcolor'], Colors.white.toARGB32());
      expect(args['textcolor'], Colors.black.toARGB32());
    });

    testWidgets('uses a black chip in light mode', (tester) async {
      await setThemeMode(ThemeMode.light);

      final args = await captureCall(tester, () => AppToast.show('Saved'));

      expect(args['msg'], 'Saved');
      expect(args['bgcolor'], Colors.black.toARGB32());
      expect(args['textcolor'], Colors.white.toARGB32());
    });

    testWidgets('follows the platform brightness in system mode', (
      tester,
    ) async {
      await setThemeMode(ThemeMode.system);

      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

      final args = await captureCall(tester, () => AppToast.show('Saved'));

      expect(args['bgcolor'], Colors.white.toARGB32());
      expect(args['textcolor'], Colors.black.toARGB32());
    });
  });
}
