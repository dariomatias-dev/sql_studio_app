import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/entities/table_info_entity.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/widgets/database_visualizer_table_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  );

  TableInfoEntity table({List<ColumnInfoEntity>? columns}) {
    return TableInfoEntity(
      name: 'users',
      columns:
          columns ??
          [
            ColumnInfoEntity(name: 'id', type: 'INTEGER'),
            ColumnInfoEntity(
              name: 'group_id',
              type: 'INTEGER',
              foreignTable: 'groups',
              foreignColumn: 'id',
            ),
          ],
    );
  }

  testWidgets('renders the table name and its columns', (tester) async {
    await tester.pumpWidget(
      wrap(DatabaseVisualizerTableWidget(table: table())),
    );
    await tester.pumpAndSettle();

    expect(find.text('users'), findsOneWidget);
    expect(find.text('id'), findsOneWidget);
    expect(find.text('group_id'), findsOneWidget);
  });

  testWidgets('shows a link icon only for foreign key columns', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(DatabaseVisualizerTableWidget(table: table())),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.link_rounded), findsOneWidget);
  });

  testWidgets('calls onTap when the card is tapped', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      wrap(
        DatabaseVisualizerTableWidget(
          table: table(),
          onTap: () => tapped = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DatabaseVisualizerTableWidget));

    expect(tapped, isTrue);
  });

  testWidgets('does not render the open-table action when onOpen is null', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(DatabaseVisualizerTableWidget(table: table())),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.north_east_rounded), findsNothing);
  });

  testWidgets('calls onOpen when the open-table action is tapped', (
    tester,
  ) async {
    var opened = false;

    await tester.pumpWidget(
      wrap(
        DatabaseVisualizerTableWidget(
          table: table(),
          onOpen: () => opened = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.north_east_rounded));

    expect(opened, isTrue);
  });

  testWidgets('fades to partial opacity once visible when isDimmed', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(DatabaseVisualizerTableWidget(table: table(), isDimmed: true)),
    );
    await tester.pumpAndSettle();

    final opacity = tester.widget<AnimatedOpacity>(
      find.byType(AnimatedOpacity),
    );

    expect(opacity.opacity, 0.35);
  });

  testWidgets('is fully opaque once visible when not dimmed', (tester) async {
    await tester.pumpWidget(
      wrap(DatabaseVisualizerTableWidget(table: table())),
    );
    await tester.pumpAndSettle();

    final opacity = tester.widget<AnimatedOpacity>(
      find.byType(AnimatedOpacity),
    );

    expect(opacity.opacity, 1);
  });

  testWidgets('is invisible before its staggered entrance delay elapses', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        DatabaseVisualizerTableWidget(table: table(), entryIndex: 5),
      ),
    );

    final opacity = tester.widget<AnimatedOpacity>(
      find.byType(AnimatedOpacity),
    );

    expect(opacity.opacity, 0);

    await tester.pump(const Duration(milliseconds: 500));
  });
}
