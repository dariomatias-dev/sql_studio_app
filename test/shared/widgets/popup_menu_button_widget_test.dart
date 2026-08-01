import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/popup_menu_button_widget.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.light,
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  );

  group('PopupMenuButtonWidget', () {
    testWidgets('opens the menu and shows its items when tapped', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          const PopupMenuButtonWidget(
            items: <PopupMenuEntry<void>>[
              PopupMenuItem<void>(child: Text('Edit')),
              PopupMenuItem<void>(child: Text('Delete')),
            ],
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('calls onOpened when the menu opens', (tester) async {
      var opened = false;

      await tester.pumpWidget(
        wrap(
          PopupMenuButtonWidget(
            onOpened: () => opened = true,
            items: const <PopupMenuEntry<void>>[
              PopupMenuItem<void>(child: Text('Edit')),
            ],
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.more_vert));
      await tester.pumpAndSettle();

      expect(opened, isTrue);
    });

    testWidgets('uses the given icon color', (tester) async {
      await tester.pumpWidget(
        wrap(
          const PopupMenuButtonWidget(
            iconColor: Colors.red,
            items: <PopupMenuEntry<void>>[
              PopupMenuItem<void>(child: Text('Edit')),
            ],
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.more_vert));

      expect(icon.color, Colors.red);
    });
  });
}
