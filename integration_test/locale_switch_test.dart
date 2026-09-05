import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/providers/app_localization_provider.dart';
import 'package:sql_studio/src/shared/widgets/states/empty_state_widget.dart';

import 'test_helpers/app_harness.dart';

/// Covers switching the app locale and confirming the console's own
/// messages follow it, not just static screen labels.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('the console message follows a locale switch', (tester) async {
    final container = await pumpApp(tester);

    final en = await AppLocalizations.delegate.load(const Locale('en'));
    final pt = await AppLocalizations.delegate.load(const Locale('pt'));

    expect(find.text(en.noQueryRunYet), findsOneWidget);

    await container
        .read(appLocalizationViewModelProvider.notifier)
        .changeLocale('pt');
    await tester.pumpAndSettle();

    expect(find.text(en.noQueryRunYet), findsNothing);
    expect(find.text(pt.noQueryRunYet), findsOneWidget);
    expect(find.byType(EmptyStateWidget), findsOneWidget);
  });
}
