import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/features/database_visualizer/data/models/table_info_model.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/painters/table_relation_painter.dart';

void main() {
  final tables = [TableInfoModel(name: 'users', columns: [])];
  final tableRects = {'users': const Rect.fromLTWH(0, 0, 10, 10)};

  TableRelationPainter painter({
    List<TableInfoModel>? tables_,
    Map<String, Rect>? tableRects_,
    String? selectedTable,
    AppColors colors = AppColors.light,
  }) {
    return TableRelationPainter(
      tables: tables_ ?? tables,
      tableRects: tableRects_ ?? tableRects,
      tableHeaderHeight: 40,
      tableColumnRowHeight: 28,
      colors: colors,
      selectedTable: selectedTable,
    );
  }

  group('TableRelationPainter.shouldRepaint', () {
    test('returns false when nothing changed', () {
      expect(painter().shouldRepaint(painter()), isFalse);
    });

    test('returns true when tables identity changed', () {
      final other = [TableInfoModel(name: 'orders', columns: [])];

      expect(
        painter().shouldRepaint(painter(tables_: other)),
        isTrue,
      );
    });

    test('returns true when tableRects identity changed', () {
      final other = {'users': const Rect.fromLTWH(1, 1, 10, 10)};

      expect(
        painter().shouldRepaint(painter(tableRects_: other)),
        isTrue,
      );
    });

    test('returns true when selectedTable changed', () {
      expect(
        painter().shouldRepaint(painter(selectedTable: 'users')),
        isTrue,
      );
    });

    test('returns true when colors changed', () {
      expect(
        painter().shouldRepaint(painter(colors: AppColors.dark)),
        isTrue,
      );
    });
  });
}
