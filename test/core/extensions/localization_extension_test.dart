import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations_en.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/extensions/localization_extension.dart';

void main() {
  final l10n = AppLocalizationsEn();

  /// Stub arguments for the keys whose message interpolates one.
  /// Anything not listed here is resolved with no arguments.
  final stubArgs = <AppLocalizationsKey, Map<String, dynamic>>{
    AppLocalizationsKey.databaseCreationError: {'databaseName': 'x'},
    AppLocalizationsKey.deleteDatabaseError: {'databaseName': 'x'},
    AppLocalizationsKey.toggleDatabaseFavoriteError: {'databaseName': 'x'},
    AppLocalizationsKey.sqlExecutionError: {'error': 'x'},
    AppLocalizationsKey.failedToExecuteSql: {'dbName': 'x', 'error': 'x'},
    AppLocalizationsKey.failedToLoadSqlFiles: {'error': 'x'},
    AppLocalizationsKey.deleteSuccess: {'count': 1},
    AppLocalizationsKey.updateSuccess: {'count': 1},
    AppLocalizationsKey.insertSuccess: {'id': 1},
  };

  test('every AppLocalizationsKey resolves to a real message', () {
    for (final k in AppLocalizationsKey.values) {
      final message = l10n.key(k, stubArgs[k] ?? const {});

      expect(
        message,
        isNot(k.name),
        reason: '$k has no entry in LocalizationExtension._translations',
      );
    }
  });

  group('LocalizationExtension.key', () {
    test('resolves a key with no arguments', () {
      expect(
        l10n.key(AppLocalizationsKey.noDatabaseSelected),
        l10n.noDatabaseSelected,
      );
    });

    test('interpolates string arguments into the message', () {
      expect(
        l10n.key(AppLocalizationsKey.databaseCreationError, {
          'databaseName': 'contacts',
        }),
        l10n.databaseCreationError('contacts'),
      );
    });

    test(
      'recursively resolves an AppLocalizationsKey passed as an argument',
      () {
        final message = l10n.key(AppLocalizationsKey.sqlExecutionError, {
          'error': AppLocalizationsKey.noDatabaseSelected,
        });

        expect(message, l10n.sqlExecutionError(l10n.noDatabaseSelected));
      },
    );
  });
}
