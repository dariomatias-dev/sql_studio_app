import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
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

  /// Builds the app under [themeMode] and returns the toast resolved from
  /// a context below the [MaterialApp], as call sites resolve it.
  Future<AppToast> resolveToast(
    WidgetTester tester,
    ThemeMode themeMode,
  ) async {
    late AppToast toast;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeMode,
        home: Builder(
          builder: (context) {
            toast = AppToast.of(context);

            return const SizedBox.shrink();
          },
        ),
      ),
    );

    return toast;
  }

  group('AppToast.show', () {
    testWidgets('uses a white chip in dark mode', (tester) async {
      final toast = await resolveToast(tester, ThemeMode.dark);

      final args = await captureCall(tester, () => toast.show('Saved'));

      expect(args['msg'], 'Saved');
      expect(args['bgcolor'], Colors.white.toARGB32());
      expect(args['textcolor'], Colors.black.toARGB32());
    });

    testWidgets('uses a black chip in light mode', (tester) async {
      final toast = await resolveToast(tester, ThemeMode.light);

      final args = await captureCall(tester, () => toast.show('Saved'));

      expect(args['msg'], 'Saved');
      expect(args['bgcolor'], Colors.black.toARGB32());
      expect(args['textcolor'], Colors.white.toARGB32());
    });

    testWidgets('follows the platform brightness in system mode', (
      tester,
    ) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

      final toast = await resolveToast(tester, ThemeMode.system);

      final args = await captureCall(tester, () => toast.show('Saved'));

      expect(args['bgcolor'], Colors.white.toARGB32());
      expect(args['textcolor'], Colors.black.toARGB32());
    });
  });
}
