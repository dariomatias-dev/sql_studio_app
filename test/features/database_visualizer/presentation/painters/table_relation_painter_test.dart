import 'dart:ui' as ui;

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/database_visualizer/domain/entities/table_info_entity.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/painters/table_relation_painter.dart';

void main() {
  final tables = [TableInfoEntity(name: 'users', columns: [])];
  final tableRects = {'users': const Rect.fromLTWH(0, 0, 10, 10)};

  TableRelationPainter painter({
    List<TableInfoEntity>? tables_,
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
      final other = [TableInfoEntity(name: 'orders', columns: [])];

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

  group('TableRelationPainter.paint', () {
    Canvas recordingCanvas() => Canvas(ui.PictureRecorder());

    test('skips relations whose source or target rect is missing', () {
      final withRelation = [
        TableInfoEntity(
          name: 'orders',
          columns: [
            ColumnInfoEntity(
              name: 'user_id',
              type: 'INTEGER',
              foreignTable: 'users',
            ),
          ],
        ),
      ];

      expect(
        () => painter(tables_: withRelation, tableRects_: {}).paint(
          recordingCanvas(),
          const Size(200, 200),
        ),
        returnsNormally,
      );
    });

    test('draws a relation with no selection', () {
      final tables_ = [
        TableInfoEntity(
          name: 'orders',
          columns: [
            ColumnInfoEntity(
              name: 'user_id',
              type: 'INTEGER',
              foreignTable: 'users',
            ),
          ],
        ),
      ];
      final tableRects_ = {
        'orders': const Rect.fromLTWH(0, 0, 100, 100),
        'users': const Rect.fromLTWH(200, 0, 100, 100),
      };

      expect(
        () => painter(
          tables_: tables_,
          tableRects_: tableRects_,
        ).paint(recordingCanvas(), const Size(400, 200)),
        returnsNormally,
      );
    });

    test('highlights a relation touching the selected table', () {
      final tables_ = [
        TableInfoEntity(
          name: 'orders',
          columns: [
            ColumnInfoEntity(
              name: 'user_id',
              type: 'INTEGER',
              foreignTable: 'users',
            ),
          ],
        ),
      ];
      final tableRects_ = {
        'orders': const Rect.fromLTWH(200, 0, 100, 100),
        'users': const Rect.fromLTWH(0, 0, 100, 100),
      };

      expect(
        () => painter(
          tables_: tables_,
          tableRects_: tableRects_,
          selectedTable: 'users',
        ).paint(recordingCanvas(), const Size(400, 200)),
        returnsNormally,
      );
    });

    test('dims a relation that does not touch the selected table', () {
      final tables_ = [
        TableInfoEntity(
          name: 'orders',
          columns: [
            ColumnInfoEntity(
              name: 'user_id',
              type: 'INTEGER',
              foreignTable: 'users',
            ),
          ],
        ),
      ];
      final tableRects_ = {
        'orders': const Rect.fromLTWH(0, 0, 100, 100),
        'users': const Rect.fromLTWH(200, 0, 100, 100),
      };

      expect(
        () => painter(
          tables_: tables_,
          tableRects_: tableRects_,
          selectedTable: 'products',
        ).paint(recordingCanvas(), const Size(400, 200)),
        returnsNormally,
      );
    });
  });
}
