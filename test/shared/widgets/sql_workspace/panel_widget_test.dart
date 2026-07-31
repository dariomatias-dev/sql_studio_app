import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/panel_widget.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(body: child),
    );
  }

  testWidgets('shows the title, database name and child content', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const PanelWidget(
          title: 'Editor',
          databaseName: 'my_db',
          child: Text('body content'),
        ),
      ),
    );

    expect(find.text('Editor'), findsOneWidget);
    expect(find.text('my_db'), findsOneWidget);
    expect(find.text('body content'), findsOneWidget);
  });

  testWidgets('renders the extra action widgets', (tester) async {
    await tester.pumpWidget(
      wrap(
        const PanelWidget(
          actions: [Icon(Icons.star)],
          child: SizedBox.shrink(),
        ),
      ),
    );

    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets('hides the fullscreen toggle when onFullScreen is null', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const PanelWidget(child: SizedBox.shrink())));

    expect(find.byIcon(Icons.fullscreen), findsNothing);
    expect(find.byIcon(Icons.fullscreen_exit), findsNothing);
  });

  testWidgets('shows the enter-fullscreen icon and invokes the callback', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      wrap(
        PanelWidget(
          onFullScreen: () => tapped = true,
          child: const SizedBox.shrink(),
        ),
      ),
    );

    expect(find.byIcon(Icons.fullscreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.fullscreen));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('shows the exit-fullscreen icon when already full screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        PanelWidget(
          isFullScreen: true,
          onFullScreen: () {},
          child: const SizedBox.shrink(),
        ),
      ),
    );

    expect(find.byIcon(Icons.fullscreen_exit), findsOneWidget);
    expect(find.byIcon(Icons.fullscreen), findsNothing);
  });
}
