/// Identifies a localized message resolvable via the app's localization
/// extension.
enum AppLocalizationsKey {
  /// Label for the "to-do list" default database.
  toDoListLabel,

  /// Description for the "to-do list" default database.
  toDoListDescription,

  /// Label for the "contacts" default database.
  contactsLabel,

  /// Description for the "contacts" default database.
  contactsDescription,

  /// Label for the "library" default database.
  libraryLabel,

  /// Description for the "library" default database.
  libraryDescription,

  /// Label for the "fitness club" default database.
  fitnessClubLabel,

  /// Description for the "fitness club" default database.
  fitnessClubDescription,

  /// Label for the "car rental" default database.
  carRentalLabel,

  /// Description for the "car rental" default database.
  carRentalDescription,

  /// Label for the "restaurant" default database.
  restaurantLabel,

  /// Description for the "restaurant" default database.
  restaurantDescription,

  /// Label for the "HR payroll" default database.
  hrPayrollLabel,

  /// Description for the "HR payroll" default database.
  hrPayrollDescription,

  /// Label for the "logistics" default database.
  logisticsLabel,

  /// Description for the "logistics" default database.
  logisticsDescription,

  /// Label for the "pharmacy" default database.
  pharmacyLabel,

  /// Description for the "pharmacy" default database.
  pharmacyDescription,

  /// Label for the "school" default database.
  schoolLabel,

  /// Description for the "school" default database.
  schoolDescription,

  /// Label for the "social network" default database.
  socialNetworkLabel,

  /// Description for the "social network" default database.
  socialNetworkDescription,

  /// Label for the "hotel" default database.
  hotelLabel,

  /// Description for the "hotel" default database.
  hotelDescription,

  /// Label for the "banking" default database.
  bankingLabel,

  /// Description for the "banking" default database.
  bankingDescription,

  /// Label for the "e-commerce" default database.
  eCommerceLabel,

  /// Description for the "e-commerce" default database.
  eCommerceDescription,

  /// Message shown after a successful delete statement.
  deleteSuccess,

  /// Message shown after a successful update statement.
  updateSuccess,

  /// Message shown after a successful insert statement.
  insertSuccess,

  /// Message shown after a successful generic statement.
  statementSuccess,

  /// Error shown when the workspace layout could not be saved.
  failedToSaveWorkspaceLayout,

  /// Error shown when a database could not be created.
  databaseCreationError,

  /// Error shown when the list of databases could not be fetched.
  fetchDatabasesError,

  /// Error shown when checking database existence fails.
  checkDatabaseExistsError,

  /// Error shown when a database could not be deleted.
  deleteDatabaseError,

  /// Error shown when a delete operation removed no records.
  noRecordDeleted,

  /// Error shown when toggling a database's favorite status fails.
  toggleDatabaseFavoriteError,

  /// Error shown when clearing data is not possible.
  unableToClear,

  /// Error shown when the app version could not be retrieved.
  failedToGetAppVersion,

  /// Error shown when executing SQL fails.
  sqlExecutionError,

  /// Error shown when no database is currently selected.
  noDatabaseSelected,

  /// Error shown when SQL suggestions could not be loaded.
  failedToLoadSqlSuggestions,

  /// Error shown when SQL suggestion settings could not be saved.
  failedToSaveSqlSuggestionsSettings,

  /// Error shown when advanced SQL suggestions could not be loaded.
  failedToLoadAdvancedSuggestions,

  /// Error shown when an advanced SQL suggestion could not be added.
  failedToAddAdvancedSuggestion,

  /// Error shown when an advanced SQL suggestion could not be updated.
  failedToUpdateAdvancedSuggestion,

  /// Error shown when an advanced SQL suggestion could not be removed.
  failedToRemoveAdvancedSuggestion,

  /// Error shown when advanced SQL suggestions could not be saved.
  failedToSaveAllAdvancedSuggestions,

  /// Error shown when advanced SQL suggestions could not be reordered.
  failedToReorderAdvancedSuggestions,

  /// Error shown when advanced SQL suggestions could not be reset.
  failedToResetAdvancedSuggestions,

  /// Error shown when basic SQL suggestions could not be loaded.
  failedToLoadBasicSuggestions,

  /// Error shown when a basic SQL suggestion could not be added.
  failedToAddBasicSuggestion,

  /// Error shown when basic SQL suggestions could not be updated.
  failedToUpdateBasicSuggestions,

  /// Error shown when a basic SQL suggestion could not be removed.
  failedToRemoveBasicSuggestion,

  /// Error shown when basic SQL suggestions could not be reset.
  failedToResetBasicSuggestions,

  /// Error shown when SQL files could not be loaded.
  failedToLoadSqlFiles,

  /// Error shown when SQL execution failed.
  failedToExecuteSql,

  /// Message shown after a database is reset successfully.
  databaseResetSuccessfully,

  /// Error shown when a database's structure could not be loaded.
  failedToLoadDatabaseStructure,

  /// Fallback message shown for unrecognized errors.
  unknownError,
}
