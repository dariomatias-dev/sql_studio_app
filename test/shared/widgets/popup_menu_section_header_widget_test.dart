import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_section_header_widget.dart';

void main() {
  Widget wrap(WidgetBuilder builder) => MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: Builder(builder: builder)),
  );

  group('PopupMenuSectionHeaderWidget', () {
    testWidgets('renders the label in uppercase and is disabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          (context) => PopupMenuButton<void>(
            itemBuilder: (context) => <PopupMenuEntry<void>>[
              PopupMenuSectionHeaderWidget(context: context, label: 'actions'),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<void>));
      await tester.pumpAndSettle();

      expect(find.text('ACTIONS'), findsOneWidget);

      final item = tester.widget<PopupMenuItem<void>>(
        find.byType(PopupMenuSectionHeaderWidget),
      );

      expect(item.enabled, isFalse);
    });
  });
}
