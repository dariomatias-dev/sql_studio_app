import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/features/sql_suggestions/data/models/sql_advanced_suggestion_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_advanced_suggestions_state.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_advanced_suggestions_view_model.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_suggestions_bars/sql_advanced_suggestions_bar_widget.dart';

class _FakeSqlAdvancedSuggestionsViewModel
    extends SqlAdvancedSuggestionsViewModel {
  _FakeSqlAdvancedSuggestionsViewModel(this._initial);

  final SqlAdvancedSuggestionsState _initial;

  @override
  SqlAdvancedSuggestionsState build() => _initial;
}

void main() {
  Future<void> pumpBar(
    WidgetTester tester, {
    required List<SqlAdvancedSuggestionModel> suggestions,
    required void Function(String code, {String? selectText}) onInsert,
  }) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [
          sqlAdvancedSuggestionsViewModelProvider.overrideWith(
            () => _FakeSqlAdvancedSuggestionsViewModel(
              SqlAdvancedSuggestionsState(suggestions: suggestions),
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: SqlAdvancedSuggestionsBarWidget(onInsertCommand: onInsert),
          ),
        ),
      ),
    );
  }

  testWidgets('renders a chip for every saved suggestion', (tester) async {
    await pumpBar(
      tester,
      suggestions: [
        SqlAdvancedSuggestionModel(
          label: 'Users',
          code: 'SELECT * FROM users;',
          orderIndex: 0,
        ),
        SqlAdvancedSuggestionModel(
          label: 'Orders',
          code: 'SELECT * FROM orders;',
          orderIndex: 1,
        ),
      ],
      onInsert: (_, {selectText}) {},
    );

    expect(find.text('Users'), findsOneWidget);
    expect(find.text('Orders'), findsOneWidget);
  });

  testWidgets('inserts the suggestion code and its selectable text', (
    tester,
  ) async {
    String? insertedCode;
    String? insertedSelectText;

    await pumpBar(
      tester,
      suggestions: [
        SqlAdvancedSuggestionModel(
          label: 'Users',
          code: 'SELECT * FROM users WHERE id = ?;',
          selectText: '?',
          orderIndex: 0,
        ),
      ],
      onInsert: (code, {selectText}) {
        insertedCode = code;
        insertedSelectText = selectText;
      },
    );

    await tester.tap(find.text('Users'));
    await tester.pump();

    expect(insertedCode, 'SELECT * FROM users WHERE id = ?;');
    expect(insertedSelectText, '?');
  });

  testWidgets('renders no chips when there are no saved suggestions', (
    tester,
  ) async {
    await pumpBar(tester, suggestions: [], onInsert: (_, {selectText}) {});

    expect(find.byType(InkWell), findsNothing);
  });
}
