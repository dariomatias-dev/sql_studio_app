import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';
import 'package:sql_studio/src/features/database/presentation/widgets/database_card_widget.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';

import '../../../../test_helpers/shared_preferences_test_helper.dart';

class _MockSqlCommandsRepository extends Mock
    implements SqlCommandsRepository {}

void main() {
  late ProviderContainer container;

  Widget wrap(Widget child) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(body: child),
      ),
    );
  }

  setUp(() async {
    final prefs = await fakeSharedPreferencesService();
    final repository = _MockSqlCommandsRepository();

    container = ProviderContainer(
      overrides: [
        sharedPreferencesServiceProvider.overrideWithValue(prefs),
        sqlCommandsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
  });

  testWidgets('renders the database label, name and table count', (
    tester,
  ) async {
    final db = defaultDatabases.first;

    await tester.pumpWidget(wrap(DatabaseCardWidget(db: db)));

    expect(find.text('root/${db.name.toLowerCase()}'), findsOneWidget);
    expect(find.text('${db.tables.length}'), findsOneWidget);
    expect(find.text(db.tables.join(', ')), findsOneWidget);
  });

  testWidgets(
    'tapping the card selects it as the active database and switches '
    'to the SQL editor tab',
    (tester) async {
      final db = defaultDatabases.first;

      await tester.pumpWidget(wrap(DatabaseCardWidget(db: db)));

      container.read(navigationViewModelProvider.notifier).index = 3;

      await tester.tap(find.byType(DatabaseCardWidget));

      final sqlCommands = container.read(sqlCommandsViewModelProvider);
      final navigationIndex = container.read(navigationViewModelProvider);

      expect(sqlCommands.activeDatabase, db.name);
      expect(navigationIndex, 0);
    },
  );
}
