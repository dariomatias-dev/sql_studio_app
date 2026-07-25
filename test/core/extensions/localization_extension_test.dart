import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations_en.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/extensions/localization_extension.dart';

void main() {
  final l10n = AppLocalizationsEn();

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
