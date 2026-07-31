import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/screens/splash/splash_screen.dart';
import 'package:sql_studio/src/core/services/default_database_service.dart';
import 'package:sql_studio/src/core/services/shared_preferences_service.dart';
import 'package:sql_studio/src/core/services/sql_execution_service.dart';
import 'package:sql_studio/src/features/app_version/presentation/providers.dart';
import 'package:sql_studio/src/features/app_version/presentation/view_models/app_version_state.dart';
import 'package:sql_studio/src/features/app_version/presentation/view_models/app_version_view_model.dart';
import 'package:sql_studio/src/features/database/presentation/providers.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/database_list_state.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/database_list_view_model.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/domain/entities/sql_suggestion_settings_entity.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/providers.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_advanced_suggestions_state.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_advanced_suggestions_view_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_basic_suggestions_state.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_basic_suggestions_view_model.dart';
import 'package:sql_studio/src/features/sql_suggestions/presentation/view_models/sql_suggestion_settings_view_model.dart';

/// These fakes let the splash screen's real loading sequence run to
/// completion without touching platform channels, sqflite, or the
/// filesystem — every dependency it drives during `_loadResources`
/// resolves instantly.
class _FakeAppVersionViewModel extends AppVersionViewModel {
  @override
  AppVersionState build() => const AppVersionState();

  @override
  Future<Result<void>> load() async {
    state = state.copyWith(formattedVersion: '1.0.0+1');

    return const SuccessResult(null);
  }
}

class _FakeSqlSuggestionSettingsViewModel
    extends SqlSuggestionSettingsViewModel {
  @override
  SqlSuggestionSettingsEntity build() => const SqlSuggestionSettingsEntity();

  @override
  Future<Result<void>> load() async => const SuccessResult(null);
}

class _FakeDatabaseListViewModel extends DatabaseListViewModel {
  @override
  DatabaseListState build() => const DatabaseListState();

  @override
  Future<Result<void>> loadDatabases() async => const SuccessResult(null);
}

class _FakeSqlAdvancedSuggestionsViewModel
    extends SqlAdvancedSuggestionsViewModel {
  @override
  SqlAdvancedSuggestionsState build() => const SqlAdvancedSuggestionsState();

  @override
  Future<Result<void>> load() async => const SuccessResult(null);
}

class _FakeSqlBasicSuggestionsViewModel extends SqlBasicSuggestionsViewModel {
  @override
  SqlBasicSuggestionsState build() => const SqlBasicSuggestionsState();

  @override
  Future<Result<void>> load() async => const SuccessResult(null);
}

class _FakeDefaultDatabaseService extends DefaultDatabaseService {
  _FakeDefaultDatabaseService() : super(SqlExecutionService());

  @override
  Future<Result<void>> init() async => const SuccessResult(null);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesService.init();
  });

  ProviderContainer buildContainer() {
    return ProviderContainer(
      overrides: [
        appVersionViewModelProvider.overrideWith(_FakeAppVersionViewModel.new),
        sqlSuggestionSettingsViewModelProvider.overrideWith(
          _FakeSqlSuggestionSettingsViewModel.new,
        ),
        databaseListViewModelProvider.overrideWith(
          _FakeDatabaseListViewModel.new,
        ),
        sqlAdvancedSuggestionsViewModelProvider.overrideWith(
          _FakeSqlAdvancedSuggestionsViewModel.new,
        ),
        sqlBasicSuggestionsViewModelProvider.overrideWith(
          _FakeSqlBasicSuggestionsViewModel.new,
        ),
        defaultDatabaseServiceProvider.overrideWith(
          (ref) => _FakeDefaultDatabaseService(),
        ),
      ],
    );
  }

  GoRouter buildRouter() {
    return GoRouter(
      initialLocation: '/splash',
      routes: <GoRoute>[
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) =>
              const Scaffold(body: Text('Main Screen')),
        ),
      ],
    );
  }

  Widget wrap(ProviderContainer container, GoRouter router) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        routerConfig: router,
      ),
    );
  }

  testWidgets('shows the branding while loading', (tester) async {
    final container = buildContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(wrap(container, buildRouter()));

    expect(find.text('SQL Studio'), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);
  });

  testWidgets(
    'loads app resources and navigates to the main route without throwing',
    (tester) async {
      final container = buildContainer();
      addTearDown(container.dispose);

      await tester.pumpWidget(wrap(container, buildRouter()));

      // Runs the entry animation to completion, which kicks off the
      // (unawaited) `_loadResources` chain.
      await tester.pumpAndSettle();

      // Flushes the resulting chain of futures, all of which resolve
      // immediately against the fakes above.
      for (
        var i = 0;
        i < 10 && find.text('Main Screen').evaluate().isEmpty;
        i++
      ) {
        await tester.pump();
      }

      expect(tester.takeException(), isNull);
      expect(find.text('Main Screen'), findsOneWidget);
      expect(
        container.read(sqlCommandsViewModelProvider).activeDatabase,
        isNull,
      );
    },
  );
}
