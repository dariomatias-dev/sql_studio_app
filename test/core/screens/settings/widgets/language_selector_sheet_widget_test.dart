import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/providers/app_localization_provider.dart';
import 'package:sql_studio/src/core/screens/settings/widgets/language_selector_sheet/language_selector_sheet_widget.dart';
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
                    builder: (_) => const LanguageSelectorSheetWidget(),
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

  testWidgets('marks the currently active language as selected', (
    tester,
  ) async {
    await pumpSheet(tester);

    expect(find.text('English'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
  });

  testWidgets('selecting a language updates the locale and closes the '
      'sheet', (tester) async {
    final container = await pumpSheet(tester);

    await tester.tap(find.text('Português'));
    await tester.pumpAndSettle();

    expect(
      container.read(appLocalizationViewModelProvider),
      const Locale('pt'),
    );
    expect(find.byType(LanguageSelectorSheetWidget), findsNothing);

    await tester.pump(const Duration(seconds: 2));
  });
}
