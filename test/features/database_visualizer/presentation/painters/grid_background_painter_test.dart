import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/painters/grid_background_painter.dart';

void main() {
  group('GridBackgroundPainter.shouldRepaint', () {
    test('returns false when colors are unchanged', () {
      const painter = GridBackgroundPainter(colors: AppColors.light);
      const oldDelegate = GridBackgroundPainter(colors: AppColors.light);

      expect(painter.shouldRepaint(oldDelegate), isFalse);
    });

    test('returns true when colors changed', () {
      const painter = GridBackgroundPainter(colors: AppColors.dark);
      const oldDelegate = GridBackgroundPainter(colors: AppColors.light);

      expect(painter.shouldRepaint(oldDelegate), isTrue);
    });
  });
}
