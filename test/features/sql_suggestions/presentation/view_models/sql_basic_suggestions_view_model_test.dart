import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/providers/sql_suggestions_data_providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_basic_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/sql_suggestions_providers.dart';

class _MockRepository extends Mock implements SqlBasicSuggestionsRepository {}

void main() {
  late _MockRepository repository;

  ProviderContainer buildContainer() {
    final container = ProviderContainer(
      overrides: [
        sqlBasicSuggestionsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    return container;
  }

  setUpAll(() {
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    repository = _MockRepository();
  });

  test('load stores the returned suggestions on success', () async {
    when(
      () => repository.load(),
    ).thenAnswer((_) async => const SuccessResult(['SELECT', 'FROM']));

    final container = buildContainer();
    final notifier = container.read(
      sqlBasicSuggestionsViewModelProvider.notifier,
    );

    final result = await notifier.load();

    expect(result.isSuccess, isTrue);
    expect(
      container.read(sqlBasicSuggestionsViewModelProvider).suggestions,
      ['SELECT', 'FROM'],
    );
  });

  test('add does nothing when the suggestion already exists', () async {
    when(
      () => repository.load(),
    ).thenAnswer((_) async => const SuccessResult(['SELECT']));

    final container = buildContainer();
    final notifier = container.read(
      sqlBasicSuggestionsViewModelProvider.notifier,
    );
    await notifier.load();

    final result = await notifier.add('SELECT');

    expect(result.isSuccess, isTrue);
    verifyNever(() => repository.save(any()));
  });

  test('add persists and appends a new suggestion', () async {
    when(
      () => repository.load(),
    ).thenAnswer((_) async => const SuccessResult(['SELECT']));
    when(
      () => repository.save(any()),
    ).thenAnswer((_) async => const SuccessResult(null));

    final container = buildContainer();
    final notifier = container.read(
      sqlBasicSuggestionsViewModelProvider.notifier,
    );
    await notifier.load();

    await notifier.add('FROM');

    expect(
      container.read(sqlBasicSuggestionsViewModelProvider).suggestions,
      ['SELECT', 'FROM'],
    );
    verify(() => repository.save(['SELECT', 'FROM'])).called(1);
  });

  test('add leaves the list unchanged when saving fails', () async {
    when(
      () => repository.load(),
    ).thenAnswer((_) async => const SuccessResult(['SELECT']));
    when(() => repository.save(any())).thenAnswer(
      (_) async => const FailureResult(
        AppFailure(AppLocalizationsKey.failedToAddBasicSuggestion),
      ),
    );

    final container = buildContainer();
    final notifier = container.read(
      sqlBasicSuggestionsViewModelProvider.notifier,
    );
    await notifier.load();

    final result = await notifier.add('FROM');

    expect(result.isFailure, isTrue);
    expect(
      container.read(sqlBasicSuggestionsViewModelProvider).suggestions,
      ['SELECT'],
    );
  });

  test('remove drops the suggestion from the list on success', () async {
    when(() => repository.load()).thenAnswer(
      (_) async => const SuccessResult(['SELECT', 'FROM']),
    );
    when(
      () => repository.save(any()),
    ).thenAnswer((_) async => const SuccessResult(null));

    final container = buildContainer();
    final notifier = container.read(
      sqlBasicSuggestionsViewModelProvider.notifier,
    );
    await notifier.load();

    await notifier.remove('SELECT');

    expect(
      container.read(sqlBasicSuggestionsViewModelProvider).suggestions,
      ['FROM'],
    );
  });

  test('resetSuggestions persists the bundled defaults', () async {
    when(
      () => repository.load(),
    ).thenAnswer((_) async => const SuccessResult(['CUSTOM']));
    when(
      () => repository.save(any()),
    ).thenAnswer((_) async => const SuccessResult(null));

    final container = buildContainer();
    final notifier = container.read(
      sqlBasicSuggestionsViewModelProvider.notifier,
    );
    await notifier.load();

    await notifier.resetSuggestions();

    expect(
      container.read(sqlBasicSuggestionsViewModelProvider).suggestions,
      defaultSqlBasicSuggestions,
    );
  });
}
