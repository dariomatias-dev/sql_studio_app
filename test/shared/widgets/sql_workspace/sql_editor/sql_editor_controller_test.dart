import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_editor/domain/repositories/sql_commands_repository.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/get_table_columns_usecase.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/reset_default_database_usecase.dart';
import 'package:sql_studio/src/features/sql_editor/domain/usecases/run_sql_query_usecase.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/providers.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/sql_editor/sql_editor_controller.dart';

class _MockSqlCommandsRepository extends Mock
    implements SqlCommandsRepository {}

void main() {
  late _MockSqlCommandsRepository repository;
  late ProviderContainer container;
  final controller = SqlEditorController();

  late BuildContext capturedContext;
  late WidgetRef capturedRef;

  Future<void> pumpHarness(WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Consumer(
            builder: (context, ref, _) {
              capturedContext = context;
              capturedRef = ref;

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  const toastChannel = MethodChannel('PonnamKarthik/fluttertoast');
  String? clipboardText;

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(toastChannel, (_) async => true);

    clipboardText = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          switch (call.method) {
            case 'Clipboard.setData':
              clipboardText =
                  (call.arguments as Map<Object?, Object?>)['text'] as String?;
              return null;
            case 'Clipboard.getData':
              return <String, dynamic>{'text': clipboardText};
            default:
              return null;
          }
        });

    repository = _MockSqlCommandsRepository();
    container = ProviderContainer(
      overrides: [
        runSqlQueryUseCaseProvider.overrideWithValue(
          RunSqlQueryUseCase(repository),
        ),
        getTableColumnsUseCaseProvider.overrideWithValue(
          GetTableColumnsUseCase(repository),
        ),
        resetDefaultDatabaseUseCaseProvider.overrideWithValue(
          ResetDefaultDatabaseUseCase(repository),
        ),
      ],
    );
    addTearDown(container.dispose);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(toastChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  group('onRunQuery', () {
    testWidgets('does nothing when the editor is empty', (tester) async {
      await pumpHarness(tester);

      var callbackCalled = false;
      controller.onRunQuery(capturedContext, capturedRef, () {
        callbackCalled = true;
      });

      expect(callbackCalled, isFalse);
      verifyNever(
        () => repository.execute(
          sql: any(named: 'sql'),
          databaseName: any(named: 'databaseName'),
        ),
      );
    });

    testWidgets('runs the query and invokes the callback', (tester) async {
      await pumpHarness(tester);

      capturedRef.read(sqlCommandsViewModelProvider.notifier).activeDatabase =
          'my_db';
      capturedRef.read(sqlEditorViewModelProvider.notifier).controller.text =
          'SELECT 1';

      when(
        () => repository.execute(
          sql: any(named: 'sql'),
          databaseName: any(named: 'databaseName'),
        ),
      ).thenAnswer((_) async => const SuccessResult(null));

      var callbackCalled = false;
      controller.onRunQuery(capturedContext, capturedRef, () {
        callbackCalled = true;
      });

      expect(callbackCalled, isTrue);

      await tester.pump();

      verify(
        () => repository.execute(sql: 'SELECT 1', databaseName: 'my_db'),
      ).called(1);

      await tester.pump(const Duration(milliseconds: 600));
    });
  });

  group('onInsertCommand', () {
    testWidgets('inserts the command into the editor', (tester) async {
      await pumpHarness(tester);

      controller.onInsertCommand(capturedRef, 'SELECT * FROM table;');

      expect(
        capturedRef.read(sqlEditorViewModelProvider.notifier).controller.text,
        'SELECT * FROM table;',
      );

      await tester.pump(const Duration(milliseconds: 600));
    });
  });

  group('onLoadLastSql', () {
    testWidgets('does not touch the editor when there is no last query', (
      tester,
    ) async {
      await pumpHarness(tester);

      controller.onLoadLastSql(capturedContext, capturedRef);

      expect(
        capturedRef.read(sqlEditorViewModelProvider.notifier).controller.text,
        '',
      );

      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('restores the last executed query into the editor', (
      tester,
    ) async {
      await pumpHarness(tester);

      capturedRef.read(sqlCommandsViewModelProvider.notifier).activeDatabase =
          'my_db';

      when(
        () => repository.execute(
          sql: any(named: 'sql'),
          databaseName: any(named: 'databaseName'),
        ),
      ).thenAnswer((_) async => const SuccessResult(null));

      await capturedRef
          .read(sqlCommandsViewModelProvider.notifier)
          .runQuery('SELECT * FROM users');

      controller.onLoadLastSql(capturedContext, capturedRef);

      expect(
        capturedRef.read(sqlEditorViewModelProvider.notifier).controller.text,
        'SELECT * FROM users',
      );

      await tester.pump(const Duration(seconds: 2));
    });
  });

  group('onCopySql', () {
    testWidgets('does not touch the clipboard when the editor is empty', (
      tester,
    ) async {
      await pumpHarness(tester);

      clipboardText = 'untouched';

      await controller.onCopySql(capturedContext, capturedRef);

      expect(clipboardText, 'untouched');

      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('copies the editor content to the clipboard', (
      tester,
    ) async {
      await pumpHarness(tester);

      capturedRef.read(sqlEditorViewModelProvider.notifier).controller.text =
          'SELECT * FROM users';

      await controller.onCopySql(capturedContext, capturedRef);

      expect(clipboardText, 'SELECT * FROM users');

      await tester.pump(const Duration(seconds: 2));
    });
  });
}
