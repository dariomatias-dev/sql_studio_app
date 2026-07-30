import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/utils/table_layout_calculator.dart';

void main() {
  TableInfoModel table(String name, int columnCount) {
    return TableInfoModel(
      name: name,
      columns: List.generate(
        columnCount,
        (i) => ColumnInfoModel(name: 'col$i', type: 'TEXT'),
      ),
    );
  }

  group('TableLayoutCalculator.layout', () {
    test('positions a single table at the top-left padding offset', () {
      final result = TableLayoutCalculator.layout([
        table('users', 2),
      ], Size.zero);

      final rect = result.tableRects['users']!;

      expect(rect.left, 100);
      expect(rect.top, 100);
      expect(rect.width, 260);
      // header + footer (12) + 2 columns
      expect(
        rect.height,
        TableLayoutCalculator.headerHeight +
            12 +
            2 * TableLayoutCalculator.columnRowHeight,
      );
    });

    test('lays out up to 3 tables in a row before wrapping', () {
      final result = TableLayoutCalculator.layout([
        table('a', 1),
        table('b', 1),
        table('c', 1),
      ], Size.zero);

      expect(result.tableRects['a']!.top, 100);
      expect(result.tableRects['b']!.top, 100);
      expect(result.tableRects['c']!.top, 100);

      expect(result.tableRects['a']!.left, 100);
      expect(result.tableRects['b']!.left, 100 + 260 + 100);
      expect(result.tableRects['c']!.left, 100 + 2 * (260 + 100));
    });

    test('wraps to a new row after every 3 tables', () {
      final result = TableLayoutCalculator.layout([
        table('a', 1),
        table('b', 1),
        table('c', 1),
        table('d', 3),
      ], Size.zero);

      // a, b, and c (1 column each) are the first row; d starts the second.
      final rowHeight =
          TableLayoutCalculator.headerHeight +
          12 +
          TableLayoutCalculator.columnRowHeight;

      expect(result.tableRects['d']!.left, 100);
      expect(result.tableRects['d']!.top, 100 + rowHeight + 100);
    });

    test('canvas size grows to fit content beyond the minimum size', () {
      final result = TableLayoutCalculator.layout([
        table('users', 1),
      ], Size.zero);

      final rect = result.tableRects['users']!;

      expect(result.canvasSize.width, rect.right + 100);
      expect(result.canvasSize.height, rect.bottom + 100);
    });

    test('canvas size never shrinks below the given minimum size', () {
      final result = TableLayoutCalculator.layout([
        table('users', 1),
      ], const Size(2000, 1500));

      expect(result.canvasSize.width, 2000);
      expect(result.canvasSize.height, 1500);
    });

    test('returns an empty layout for no tables', () {
      final result = TableLayoutCalculator.layout(
        const [],
        const Size(400, 300),
      );

      expect(result.tableRects, isEmpty);
      expect(result.canvasSize, const Size(400, 300));
    });
  });
}
