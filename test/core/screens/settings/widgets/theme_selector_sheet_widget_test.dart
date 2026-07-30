import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/providers/app_theme_mode_provider.dart';
import 'package:sql_studio/src/core/screens/settings/widgets/theme_selector_sheet/theme_selector_sheet_widget.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const toastChannel = MethodChannel('PonnamKarthik/fluttertoast');

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesService.init();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(toastChannel, (_) async => true);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(toastChannel, null);
  });

  Future<ProviderContainer> pumpSheet(WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    builder: (_) => const ThemeSelectorSheetWidget(),
                  ),
                  child: const Text('open'),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    return container;
  }

  testWidgets('marks the currently active theme mode as selected', (
    tester,
  ) async {
    await pumpSheet(tester);

    expect(find.text('System'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
  });

  testWidgets('selecting a theme mode updates the state and closes the '
      'sheet', (tester) async {
    final container = await pumpSheet(tester);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(container.read(appThemeModeViewModelProvider), ThemeMode.dark);
    expect(find.byType(ThemeSelectorSheetWidget), findsNothing);

    await tester.pump(const Duration(seconds: 2));
  });
}
