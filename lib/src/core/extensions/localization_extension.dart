import 'package:sql_studio/l10n/app_localizations.dart';

import 'package:sql_studio/src/core/enums/app_localizations_key.dart';

/// Resolves an [AppLocalizationsKey] to its localized message.
extension LocalizationExtension on AppLocalizations {
  static final Map<
    AppLocalizationsKey,
    String Function(AppLocalizations, Map<String, dynamic>)
  >
  _translations = {
    AppLocalizationsKey.toDoListLabel: (l, args) => l.toDoListLabel,
    AppLocalizationsKey.toDoListDescription: (l, args) => l.toDoListDescription,
    AppLocalizationsKey.contactsLabel: (l, args) => l.contactsLabel,
    AppLocalizationsKey.contactsDescription: (l, args) => l.contactsDescription,
    AppLocalizationsKey.libraryLabel: (l, args) => l.libraryLabel,
    AppLocalizationsKey.libraryDescription: (l, args) => l.libraryDescription,
    AppLocalizationsKey.fitnessClubLabel: (l, args) => l.fitnessClubLabel,
    AppLocalizationsKey.fitnessClubDescription: (l, args) =>
        l.fitnessClubDescription,
    AppLocalizationsKey.carRentalLabel: (l, args) => l.carRentalLabel,
    AppLocalizationsKey.carRentalDescription: (l, args) =>
        l.carRentalDescription,
    AppLocalizationsKey.restaurantLabel: (l, args) => l.restaurantLabel,
    AppLocalizationsKey.restaurantDescription: (l, args) =>
        l.restaurantDescription,
    AppLocalizationsKey.hrPayrollLabel: (l, args) => l.hrPayrollLabel,
    AppLocalizationsKey.hrPayrollDescription: (l, args) =>
        l.hrPayrollDescription,
    AppLocalizationsKey.logisticsLabel: (l, args) => l.logisticsLabel,
    AppLocalizationsKey.logisticsDescription: (l, args) =>
        l.logisticsDescription,
    AppLocalizationsKey.pharmacyLabel: (l, args) => l.pharmacyLabel,
    AppLocalizationsKey.pharmacyDescription: (l, args) => l.pharmacyDescription,
    AppLocalizationsKey.schoolLabel: (l, args) => l.schoolLabel,
    AppLocalizationsKey.schoolDescription: (l, args) => l.schoolDescription,
    AppLocalizationsKey.socialNetworkLabel: (l, args) => l.socialNetworkLabel,
    AppLocalizationsKey.socialNetworkDescription: (l, args) =>
        l.socialNetworkDescription,
    AppLocalizationsKey.hotelLabel: (l, args) => l.hotelLabel,
    AppLocalizationsKey.hotelDescription: (l, args) => l.hotelDescription,
    AppLocalizationsKey.bankingLabel: (l, args) => l.bankingLabel,
    AppLocalizationsKey.bankingDescription: (l, args) => l.bankingDescription,
    AppLocalizationsKey.eCommerceLabel: (l, args) => l.eCommerceLabel,
    AppLocalizationsKey.eCommerceDescription: (l, args) =>
        l.eCommerceDescription,
    AppLocalizationsKey.failedToSaveWorkspaceLayout: (l, args) =>
        l.failedToSaveWorkspaceLayout,
    AppLocalizationsKey.databaseCreationError: (l, args) =>
        l.databaseCreationError(args['databaseName'] as Object),
    AppLocalizationsKey.fetchDatabasesError: (l, args) => l.fetchDatabasesError,
    AppLocalizationsKey.checkDatabaseExistsError: (l, args) =>
        l.checkDatabaseExistsError,
    AppLocalizationsKey.deleteDatabaseError: (l, args) =>
        l.deleteDatabaseError(args['databaseName'] as Object),
    AppLocalizationsKey.noRecordDeleted: (l, args) => l.noRecordDeleted,
    AppLocalizationsKey.toggleDatabaseFavoriteError: (l, args) =>
        l.toggleDatabaseFavoriteError(args['databaseName'] as Object),
    AppLocalizationsKey.unableToClear: (l, args) => l.unableToClear,
    AppLocalizationsKey.failedToGetAppVersion: (l, args) =>
        l.failedToGetAppVersion,
    AppLocalizationsKey.sqlExecutionError: (l, args) =>
        l.sqlExecutionError(args['error'] as Object),
    AppLocalizationsKey.noDatabaseSelected: (l, args) => l.noDatabaseSelected,
    AppLocalizationsKey.failedToLoadSqlSuggestions: (l, args) =>
        l.failedToLoadSqlSuggestions,
    AppLocalizationsKey.failedToSaveSqlSuggestionsSettings: (l, args) =>
        l.failedToSaveSqlSuggestionsSettings,
    AppLocalizationsKey.failedToLoadAdvancedSuggestions: (l, args) =>
        l.failedToLoadAdvancedSuggestions,
    AppLocalizationsKey.failedToAddAdvancedSuggestion: (l, args) =>
        l.failedToAddAdvancedSuggestion,
    AppLocalizationsKey.failedToUpdateAdvancedSuggestion: (l, args) =>
        l.failedToUpdateAdvancedSuggestion,
    AppLocalizationsKey.failedToRemoveAdvancedSuggestion: (l, args) =>
        l.failedToRemoveAdvancedSuggestion,
    AppLocalizationsKey.failedToSaveAllAdvancedSuggestions: (l, args) =>
        l.failedToSaveAllAdvancedSuggestions,
    AppLocalizationsKey.failedToReorderAdvancedSuggestions: (l, args) =>
        l.failedToReorderAdvancedSuggestions,
    AppLocalizationsKey.failedToResetAdvancedSuggestions: (l, args) =>
        l.failedToResetAdvancedSuggestions,
    AppLocalizationsKey.failedToLoadBasicSuggestions: (l, args) =>
        l.failedToLoadBasicSuggestions,
    AppLocalizationsKey.failedToAddBasicSuggestion: (l, args) =>
        l.failedToAddBasicSuggestion,
    AppLocalizationsKey.failedToUpdateBasicSuggestions: (l, args) =>
        l.failedToUpdateBasicSuggestions,
    AppLocalizationsKey.failedToRemoveBasicSuggestion: (l, args) =>
        l.failedToRemoveBasicSuggestion,
    AppLocalizationsKey.failedToResetBasicSuggestions: (l, args) =>
        l.failedToResetBasicSuggestions,
    AppLocalizationsKey.failedToExecuteSql: (l, args) => l.failedToExecuteSql(
      args['dbName'] as Object,
      args['error'] as Object,
    ),
    AppLocalizationsKey.failedToLoadSqlFiles: (l, args) =>
        l.failedToLoadSqlFiles(args['error'] as Object),
    AppLocalizationsKey.databaseResetSuccessfully: (l, args) =>
        l.databaseResetSuccessfully,
    AppLocalizationsKey.failedToLoadDatabaseStructure: (l, args) =>
        l.failedToLoadDatabaseStructure,
    AppLocalizationsKey.unknownError: (l, args) => l.unknownError,
    AppLocalizationsKey.deleteSuccess: (l, args) =>
        l.deleteSuccess(args['count'] as Object),
    AppLocalizationsKey.updateSuccess: (l, args) =>
        l.updateSuccess(args['count'] as Object),
    AppLocalizationsKey.insertSuccess: (l, args) =>
        l.insertSuccess(args['id'] as Object),
    AppLocalizationsKey.statementSuccess: (l, args) => l.statementSuccess,
  };

  /// Returns the localized message for [k], interpolating [args] into it.
  ///
  /// Falls back to the key's enum name when no translation is registered.
  String key(AppLocalizationsKey k, [Map<String, dynamic> args = const {}]) {
    final value = _translations[k];
    if (value == null) return k.name;

    final resolvedArgs = args.map((key, val) {
      if (val is AppLocalizationsKey) {
        return MapEntry(key, this.key(val));
      }

      return MapEntry(key, val);
    });

    return value(this, resolvedArgs);
  }
}
