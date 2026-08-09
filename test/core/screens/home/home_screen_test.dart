import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/screens/home/home_screen.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_workspace_widget.dart';

import '../../../test_helpers/shared_preferences_test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesService prefs;

  setUp(() async {
    prefs = await fakeSharedPreferencesService();
  });

  Widget wrap(Widget child) {
    return ProviderScope(
      overrides: [sharedPreferencesServiceProvider.overrideWithValue(prefs)],
      child: MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: child,
      ),
    );
  }

  testWidgets('builds and hosts the SQL workspace', (tester) async {
    await tester.pumpWidget(wrap(const HomeScreen()));

    expect(find.byType(SqlWorkspaceWidget), findsOneWidget);
  });

  testWidgets('pads the workspace by navBarInset', (tester) async {
    await tester.pumpWidget(wrap(const HomeScreen(navBarInset: 48)));

    final padding = tester.widget<Padding>(
      find.byWidgetPredicate(
        (widget) => widget is Padding && widget.child is SqlWorkspaceWidget,
      ),
    );

    expect(padding.padding, const EdgeInsets.only(bottom: 48));
  });

  testWidgets('defaults navBarInset to zero', (tester) async {
    await tester.pumpWidget(wrap(const HomeScreen()));

    final padding = tester.widget<Padding>(
      find.byWidgetPredicate(
        (widget) => widget is Padding && widget.child is SqlWorkspaceWidget,
      ),
    );

    expect(padding.padding, EdgeInsets.zero);
  });
}
