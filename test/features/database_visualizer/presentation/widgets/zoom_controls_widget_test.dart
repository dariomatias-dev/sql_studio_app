import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/features/database_visualizer/presentation/widgets/zoom_controls_widget.dart';

void main() {
  late AppLocalizations en;

  setUpAll(() async {
    en = await AppLocalizations.delegate.load(const Locale('en'));
  });

  testWidgets('labels every zoom control for a screen reader', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          body: ZoomControlsWidget(
            transformationController: TransformationController(),
          ),
        ),
      ),
    );

    expect(find.bySemanticsLabel(en.zoomIn), findsOneWidget);
    expect(find.bySemanticsLabel(en.zoomOut), findsOneWidget);
    expect(find.bySemanticsLabel(en.resetZoom), findsOneWidget);

    handle.dispose();
  });
}
