import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/shared/widgets/suggestions_settings_layout/suggestions_settings_layout_controller.dart';

void main() {
  SuggestionsSettingsLayoutController<String> buildController(
    List<String> initialItems,
  ) {
    final controller = SuggestionsSettingsLayoutController<String>(
      getContext: () => throw UnimplementedError(),
      onSave: (_) async => throw UnimplementedError(),
      initialItems: initialItems,
    );
    addTearDown(controller.dispose);

    return controller;
  }

  test('starts with the given initial items and no pending changes', () {
    final controller = buildController(['a', 'b', 'c']);

    expect(controller.items, ['a', 'b', 'c']);
    expect(controller.hasChangesNotifier.value, isFalse);
  });

  test('reorderItems moves an item forward', () {
    final controller = buildController(['a', 'b', 'c'])..reorderItems(0, 2);

    expect(controller.items, ['b', 'a', 'c']);
    expect(controller.hasChangesNotifier.value, isTrue);
  });

  test('reorderItems moves an item backward', () {
    final controller = buildController(['a', 'b', 'c'])..reorderItems(2, 0);

    expect(controller.items, ['c', 'a', 'b']);
  });

  test('hasChanges is false once the order matches the initial one again', () {
    final controller = buildController(['a', 'b'])
      ..reorderItems(1, 0)
      ..reorderItems(1, 0);

    expect(controller.items, ['a', 'b']);
    expect(controller.hasChangesNotifier.value, isFalse);
  });

  test('setInitialItems replaces the baseline and clears pending changes', () {
    final controller = buildController(['a', 'b'])..reorderItems(1, 0);

    expect(controller.hasChangesNotifier.value, isTrue);

    controller.setInitialItems(['x', 'y']);

    expect(controller.items, ['x', 'y']);
    expect(controller.hasChangesNotifier.value, isFalse);
  });

  test(
    'reorderItems after setInitialItems is compared against the new '
    'baseline',
    () {
      final controller = buildController(['a', 'b'])
        ..setInitialItems(['x', 'y'])
        ..reorderItems(1, 0);

      expect(controller.items, ['y', 'x']);
      expect(controller.hasChangesNotifier.value, isTrue);
    },
  );

  group('saveItems', () {
    const toastChannel = MethodChannel('PonnamKarthik/fluttertoast');

    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(toastChannel, (_) async => true);
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(toastChannel, null);
    });

    Widget wrap(Widget Function(BuildContext context) builder) {
      return MaterialApp(
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Builder(builder: builder),
      );
    }

    testWidgets('clears pending changes and rebases the baseline on '
        'success', (tester) async {
      late SuggestionsSettingsLayoutController<String> controller;

      await tester.pumpWidget(
        wrap((context) {
          controller = SuggestionsSettingsLayoutController<String>(
            getContext: () => context,
            onSave: (_) async => true,
            initialItems: ['a', 'b'],
          );
          addTearDown(controller.dispose);

          return const SizedBox();
        }),
      );

      controller.reorderItems(1, 0);
      expect(controller.hasChangesNotifier.value, isTrue);

      await controller.saveItems();

      expect(controller.hasChangesNotifier.value, isFalse);
      expect(controller.items, ['b', 'a']);

      controller.reorderItems(1, 0);
      expect(controller.hasChangesNotifier.value, isTrue);

      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('keeps pending changes true when saving fails', (
      tester,
    ) async {
      late SuggestionsSettingsLayoutController<String> controller;

      await tester.pumpWidget(
        wrap((context) {
          controller = SuggestionsSettingsLayoutController<String>(
            getContext: () => context,
            onSave: (_) async => false,
            initialItems: ['a', 'b'],
          );
          addTearDown(controller.dispose);

          return const SizedBox();
        }),
      );

      controller.reorderItems(1, 0);

      await controller.saveItems();

      expect(controller.hasChangesNotifier.value, isTrue);

      await tester.pump(const Duration(seconds: 2));
    });
  });
}
