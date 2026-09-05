import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_suggestion_settings_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';

class _MockRepository extends Mock implements SqlSuggestionSettingsRepository {}

void main() {
  late _MockRepository repository;

  ProviderContainer buildContainer() {
    final container = ProviderContainer(
      overrides: [
        sqlSuggestionSettingsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    return container;
  }

  setUpAll(() {
    registerFallbackValue(const SqlSuggestionSettingsEntity());
  });

  setUp(() {
    repository = _MockRepository();
  });

  test('load replaces the state with the persisted settings', () async {
    when(() => repository.load()).thenAnswer(
      (_) async => const SuccessResult(
        SqlSuggestionSettingsEntity(
          useBasicSuggestions: false,
          useAdvancedSuggestions: true,
        ),
      ),
    );

    final container = buildContainer();
    final notifier = container.read(
      sqlSuggestionSettingsViewModelProvider.notifier,
    );

    await notifier.load();

    final state = container.read(sqlSuggestionSettingsViewModelProvider);
    expect(state.useBasicSuggestions, isFalse);
    expect(state.useAdvancedSuggestions, isTrue);
  });

  test('saveSettings persists the current state', () async {
    when(
      () => repository.save(any()),
    ).thenAnswer((_) async => const SuccessResult(null));

    final container = buildContainer();
    final notifier = container.read(
      sqlSuggestionSettingsViewModelProvider.notifier,
    );

    final result = await notifier.saveSettings();

    expect(result.isSuccess, isTrue);
    verify(() => repository.save(const SqlSuggestionSettingsEntity()));
  });

  test('enabling basic suggestions disables advanced suggestions', () {
    final container = buildContainer();
    container.read(
        sqlSuggestionSettingsViewModelProvider.notifier,
      )
      ..setAdvancedSuggestions(value: true)
      ..setBasicSuggestions(value: true);

    final state = container.read(sqlSuggestionSettingsViewModelProvider);
    expect(state.useBasicSuggestions, isTrue);
    expect(state.useAdvancedSuggestions, isFalse);
  });

  test('enabling advanced suggestions disables basic suggestions', () {
    final container = buildContainer();
    container
        .read(
          sqlSuggestionSettingsViewModelProvider.notifier,
        )
        .setAdvancedSuggestions(value: true);

    final state = container.read(sqlSuggestionSettingsViewModelProvider);
    expect(state.useBasicSuggestions, isFalse);
    expect(state.useAdvancedSuggestions, isTrue);
  });

  test('disabling basic suggestions does not enable advanced ones', () {
    final container = buildContainer();
    container
        .read(
          sqlSuggestionSettingsViewModelProvider.notifier,
        )
        .setBasicSuggestions(value: false);

    final state = container.read(sqlSuggestionSettingsViewModelProvider);
    expect(state.useBasicSuggestions, isFalse);
    expect(state.useAdvancedSuggestions, isFalse);
  });

  test('setCharacterSuggestions toggles independently', () {
    final container = buildContainer();
    container
        .read(
          sqlSuggestionSettingsViewModelProvider.notifier,
        )
        .setCharacterSuggestions(value: false);

    final state = container.read(sqlSuggestionSettingsViewModelProvider);
    expect(state.useCharacterSuggestions, isFalse);
    expect(state.useBasicSuggestions, isTrue);
  });
}
