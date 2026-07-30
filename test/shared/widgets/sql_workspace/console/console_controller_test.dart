import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/sql_editor/presentation/view_models/sql_commands_state.dart';
import 'package:sql_studio/src/shared/widgets/sql_workspace/console/console_controller.dart';

void main() {
  final controller = ConsoleController();

  test('extracts the table name from a simple SELECT with no rows', () {
    const state = SqlCommandsState(
      lastQuery: 'SELECT * FROM users',
      result: SuccessResult(DatabaseSuccess(result: [])),
    );

    expect(controller.extractTableName(state), 'users');
  });

  test('is case-insensitive when matching the FROM clause', () {
    const state = SqlCommandsState(
      lastQuery: 'select * from Contacts',
      result: SuccessResult(DatabaseSuccess(result: [])),
    );

    expect(controller.extractTableName(state), 'Contacts');
  });

  test('returns an empty string when the empty SELECT has no query text', () {
    const state = SqlCommandsState(
      result: SuccessResult(DatabaseSuccess(result: [])),
    );

    expect(controller.extractTableName(state), '');
  });

  test('returns an empty string when the SELECT returned rows', () {
    const state = SqlCommandsState(
      lastQuery: 'SELECT * FROM users',
      result: SuccessResult(
        DatabaseSuccess(
          result: [
            {'id': 1},
          ],
        ),
      ),
    );

    expect(controller.extractTableName(state), '');
  });

  test('returns an empty string when the result is not a DatabaseSuccess', () {
    const state = SqlCommandsState(
      lastQuery: 'SELECT * FROM users',
      result: SuccessResult<Object?>(null),
    );

    expect(controller.extractTableName(state), '');
  });

  test('returns an empty string when the last command failed', () {
    const state = SqlCommandsState(
      lastQuery: 'SELECT * FROM users',
      result: FailureResult(
        DatabaseFailure(AppLocalizationsKey.sqlExecutionError),
      ),
    );

    expect(controller.extractTableName(state), '');
  });

  test('returns an empty string when there is no result at all', () {
    expect(
      controller.extractTableName(const SqlCommandsState()),
      '',
    );
  });
}
