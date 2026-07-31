import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/constants/default_sql_suggestions/default_sql_basic_suggestions.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_basic_suggestions_state.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_basic_suggestions_view_model.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_basic_suggestions_bar_widget.dart';

class _FakeSqlBasicSuggestionsViewModel extends SqlBasicSuggestionsViewModel {
  _FakeSqlBasicSuggestionsViewModel(this._initial);

  final SqlBasicSuggestionsState _initial;

  @override
  SqlBasicSuggestionsState build() => _initial;
}

void main() {
  Future<void> pumpBar(
    WidgetTester tester, {
    required SqlBasicSuggestionsState state,
    required String filterText,
    required void Function(String value, {String? selectText}) onInsert,
  }) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [
          sqlBasicSuggestionsViewModelProvider.overrideWith(
            () => _FakeSqlBasicSuggestionsViewModel(state),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: SqlBasicSuggestionsBarWidget(
              onInsertCommand: onInsert,
              filterText: filterText,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('falls back to the default suggestions when none are stored', (
    tester,
  ) async {
    await pumpBar(
      tester,
      state: const SqlBasicSuggestionsState(),
      filterText: '',
      onInsert: (_, {selectText}) {},
    );

    expect(find.text(defaultSqlBasicSuggestions.first), findsOneWidget);
  });

  testWidgets('filters suggestions by the current word being typed', (
    tester,
  ) async {
    await pumpBar(
      tester,
      state: const SqlBasicSuggestionsState(
        suggestions: ['SELECT * FROM ', 'DELETE FROM ', 'WHERE '],
      ),
      filterText: 'del',
      onInsert: (_, {selectText}) {},
    );

    expect(find.text('DELETE FROM '), findsOneWidget);
    expect(find.text('SELECT * FROM '), findsNothing);
    expect(find.text('WHERE '), findsNothing);
  });

  testWidgets('inserts the tapped suggestion', (tester) async {
    final inserted = <String>[];

    await pumpBar(
      tester,
      state: const SqlBasicSuggestionsState(suggestions: ['WHERE ']),
      filterText: '',
      onInsert: (value, {selectText}) => inserted.add(value),
    );

    await tester.tap(find.text('WHERE '));
    await tester.pump();

    expect(inserted, ['WHERE ']);
  });
}
