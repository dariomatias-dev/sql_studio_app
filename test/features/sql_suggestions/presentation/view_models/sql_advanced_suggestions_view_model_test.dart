import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/repositories/sql_advanced_suggestions_repository.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/add_sql_advanced_suggestion_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/load_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/remove_sql_advanced_suggestion_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reorder_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/reset_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/save_all_sql_advanced_suggestions_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/usecases/update_sql_advanced_suggestion_usecase.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';

class _MockRepository extends Mock
    implements SqlAdvancedSuggestionsRepository {}

class _MockLogger extends Mock implements Logger {}

void main() {
  late _MockRepository repository;

  SqlAdvancedSuggestionModel suggestion(String label, {String? id}) {
    return SqlAdvancedSuggestionModel(
      id: id,
      label: label,
      code: 'SELECT 1',
      orderIndex: 0,
    );
  }

  ProviderContainer buildContainer() {
    final container = ProviderContainer(
      overrides: [
        loggerProvider.overrideWithValue(_MockLogger()),
        loadSqlAdvancedSuggestionsUseCaseProvider.overrideWithValue(
          LoadSqlAdvancedSuggestionsUseCase(repository),
        ),
        addSqlAdvancedSuggestionUseCaseProvider.overrideWithValue(
          AddSqlAdvancedSuggestionUseCase(repository),
        ),
        updateSqlAdvancedSuggestionUseCaseProvider.overrideWithValue(
          UpdateSqlAdvancedSuggestionUseCase(repository),
        ),
        removeSqlAdvancedSuggestionUseCaseProvider.overrideWithValue(
          RemoveSqlAdvancedSuggestionUseCase(repository),
        ),
        saveAllSqlAdvancedSuggestionsUseCaseProvider.overrideWithValue(
          SaveAllSqlAdvancedSuggestionsUseCase(repository),
        ),
        reorderSqlAdvancedSuggestionsUseCaseProvider.overrideWithValue(
          ReorderSqlAdvancedSuggestionsUseCase(repository),
        ),
        resetSqlAdvancedSuggestionsUseCaseProvider.overrideWithValue(
          ResetSqlAdvancedSuggestionsUseCase(repository),
        ),
      ],
    );
    addTearDown(container.dispose);

    return container;
  }

  setUpAll(() {
    registerFallbackValue(suggestion('fallback'));
    registerFallbackValue(<SqlAdvancedSuggestionModel>[]);
  });

  setUp(() {
    repository = _MockRepository();
  });

  test('load populates the state with the loaded suggestions', () async {
    when(
      () => repository.getAll(),
    ).thenAnswer((_) async => [suggestion('A')]);

    final container = buildContainer();
    final notifier = container.read(
      sqlAdvancedSuggestionsViewModelProvider.notifier,
    );

    final result = await notifier.load();

    expect(result.isSuccess, isTrue);
    final state = container.read(sqlAdvancedSuggestionsViewModelProvider);
    expect(state.suggestions.single.label, 'A');
    expect(state.isLoading, isFalse);
  });

  test('load returns a failure and clears the loading flag on error', () async {
    when(() => repository.getAll()).thenThrow(Exception('boom'));

    final container = buildContainer();
    final notifier = container.read(
      sqlAdvancedSuggestionsViewModelProvider.notifier,
    );

    final result = await notifier.load();

    expect(result.isFailure, isTrue);
    expect(
      container.read(sqlAdvancedSuggestionsViewModelProvider).isLoading,
      isFalse,
    );
  });

  test('addSuggestion appends the new suggestion on success', () async {
    when(() => repository.create(any())).thenAnswer((_) async {});

    final container = buildContainer();
    final notifier = container.read(
      sqlAdvancedSuggestionsViewModelProvider.notifier,
    );

    final result = await notifier.addSuggestion(suggestion('A'));

    expect(result.isSuccess, isTrue);
    expect(
      container.read(sqlAdvancedSuggestionsViewModelProvider).suggestions,
      hasLength(1),
    );
  });

  test('addSuggestion leaves the list untouched on failure', () async {
    when(() => repository.create(any())).thenThrow(Exception('boom'));

    final container = buildContainer();
    final notifier = container.read(
      sqlAdvancedSuggestionsViewModelProvider.notifier,
    );

    final result = await notifier.addSuggestion(suggestion('A'));

    expect(result.isFailure, isTrue);
    expect(
      container.read(sqlAdvancedSuggestionsViewModelProvider).suggestions,
      isEmpty,
    );
  });

  test('updateSuggestion replaces the matching suggestion in place', () async {
    when(() => repository.create(any())).thenAnswer((_) async {});
    when(() => repository.update(any())).thenAnswer((_) async {});

    final container = buildContainer();
    final notifier = container.read(
      sqlAdvancedSuggestionsViewModelProvider.notifier,
    );
    final original = suggestion('A');
    await notifier.addSuggestion(original);

    final updated = original.copyWith(label: 'A2');
    await notifier.updateSuggestion(updated);

    expect(
      container
          .read(sqlAdvancedSuggestionsViewModelProvider)
          .suggestions
          .single
          .label,
      'A2',
    );
  });

  test('removeSuggestion drops the matching id from the list', () async {
    when(() => repository.create(any())).thenAnswer((_) async {});
    when(() => repository.delete(any())).thenAnswer((_) async {});

    final container = buildContainer();
    final notifier = container.read(
      sqlAdvancedSuggestionsViewModelProvider.notifier,
    );
    final added = suggestion('A');
    await notifier.addSuggestion(added);

    final result = await notifier.removeSuggestion(added.id);

    expect(result.isSuccess, isTrue);
    expect(
      container.read(sqlAdvancedSuggestionsViewModelProvider).suggestions,
      isEmpty,
    );
  });

  test('saveAllSuggestions replaces the whole list on success', () async {
    when(() => repository.clear()).thenAnswer((_) async {});
    when(() => repository.addAll(any())).thenAnswer((_) async {});

    final container = buildContainer();
    final notifier = container.read(
      sqlAdvancedSuggestionsViewModelProvider.notifier,
    );

    final newList = [suggestion('A'), suggestion('B')];
    final result = await notifier.saveAllSuggestions(newList);

    expect(result.isSuccess, isTrue);
    expect(
      container.read(sqlAdvancedSuggestionsViewModelProvider).suggestions,
      newList,
    );
  });

  test(
    'reorderSuggestions stores the reordered list from the use case',
    () async {
      when(() => repository.update(any())).thenAnswer((_) async {});

      final container = buildContainer();
      final notifier = container.read(
        sqlAdvancedSuggestionsViewModelProvider.notifier,
      );

      final result = await notifier.reorderSuggestions([
        suggestion('A'),
        suggestion('B'),
      ]);

      expect(result.isSuccess, isTrue);
      expect(
        container.read(sqlAdvancedSuggestionsViewModelProvider).suggestions,
        hasLength(2),
      );
    },
  );

  test(
    'resetSuggestions replaces the list with the restored defaults',
    () async {
      when(() => repository.clear()).thenAnswer((_) async {});
      when(() => repository.addAll(any())).thenAnswer((_) async {});

      final container = buildContainer();
      final notifier = container.read(
        sqlAdvancedSuggestionsViewModelProvider.notifier,
      );

      final result = await notifier.resetSuggestions();

      expect(result.isSuccess, isTrue);
      expect(
        container.read(sqlAdvancedSuggestionsViewModelProvider).suggestions,
        isNotEmpty,
      );
    },
  );
}
