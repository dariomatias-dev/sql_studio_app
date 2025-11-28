// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get databases => 'Databases';

  @override
  String get settings => 'Settings';

  @override
  String get general => 'General';

  @override
  String get language => 'Language';

  @override
  String get sqlSuggestions => 'SQL Suggestions';

  @override
  String get workspaceLayout => 'Workspace Layout';

  @override
  String get information => 'Information';

  @override
  String get appVersion => 'App Version';

  @override
  String get officialWebsite => 'Official Website';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get errorOpeningUrl => 'Error opening URL';

  @override
  String errorOpeningUrlDescription(Object url) {
    return 'The URL $url could not be opened.';
  }

  @override
  String get enterFullscreen => 'Enter Fullscreen';

  @override
  String get exitFullscreen => 'Exit Fullscreen';

  @override
  String get editor => 'Editor';

  @override
  String get viewVisualScheme => 'View Visual Scheme';

  @override
  String get resetDatabase => 'Reset Database';

  @override
  String get runQuery => 'Run Query';

  @override
  String get clearEditor => 'Clear Editor';

  @override
  String get console => 'Console';

  @override
  String get clearConsole => 'Clear Console';

  @override
  String get schemaCopied => 'Schema copied!';

  @override
  String get seedCopied => 'Seed copied!';

  @override
  String get schemaAndSeedCopied => 'Schema and Seed copied!';

  @override
  String get viewStructure => 'View Structure';

  @override
  String get copySchema => 'Copy Schema';

  @override
  String get copySeed => 'Copy Seed';

  @override
  String get copyAll => 'Copy All';

  @override
  String get searchDatabases => 'Search databases';

  @override
  String get newDatabase => 'New Database';

  @override
  String get favorites => 'Favorites';

  @override
  String get allDatabases => 'All Databases';

  @override
  String get favorite => 'Favorite';

  @override
  String get unfavorite => 'Unfavorite';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get attention => 'Attention';

  @override
  String get deleteDatabaseConfirmation => 'Are you sure you want to permanently delete this database? This action cannot be undone.';

  @override
  String get toDoListLabel => 'To-Do List';

  @override
  String get toDoListDescription => 'Simple task management database';

  @override
  String get contactsLabel => 'Contacts';

  @override
  String get contactsDescription => 'Contacts and groups database';

  @override
  String get libraryLabel => 'Library';

  @override
  String get libraryDescription => 'Library with books, members, and loans';

  @override
  String get fitnessClubLabel => 'Fitness Club';

  @override
  String get fitnessClubDescription => 'Gym members and subscriptions database';

  @override
  String get carRentalLabel => 'Car Rental';

  @override
  String get carRentalDescription => 'Car rental management database';

  @override
  String get restaurantLabel => 'Restaurant';

  @override
  String get restaurantDescription => 'Restaurant orders and menu items database';

  @override
  String get hrPayrollLabel => 'HR Payroll';

  @override
  String get hrPayrollDescription => 'Company departments, job positions, employees, and salary history';

  @override
  String get logisticsLabel => 'Logistics';

  @override
  String get logisticsDescription => 'Packages, drivers, deliveries, and status history database';

  @override
  String get pharmacyLabel => 'Pharmacy';

  @override
  String get pharmacyDescription => 'Pharmacy inventory, suppliers, customers, and sales database';

  @override
  String get schoolLabel => 'School';

  @override
  String get schoolDescription => 'School management with students, teachers, classes, enrollments, and grades';

  @override
  String get socialNetworkLabel => 'Social Network';

  @override
  String get socialNetworkDescription => 'Social media with users, posts, likes, comments, and followers';

  @override
  String get hotelLabel => 'Hotel';

  @override
  String get hotelDescription => 'Hotel reservations, rooms, payments, employees, and services database';

  @override
  String get bankingLabel => 'Banking';

  @override
  String get bankingDescription => 'Banking system with accounts, transactions, loans, and employees';

  @override
  String get eCommerceLabel => 'E-Commerce';

  @override
  String get eCommerceDescription => 'Online store with products, orders, carts, and reviews';

  @override
  String get openFullscreen => 'Open Fullscreen';

  @override
  String get options => 'Options';

  @override
  String get table => 'Table';

  @override
  String get tables => 'Tables';

  @override
  String get splitLayout => 'Split Layout';

  @override
  String get splitLayoutSubtitle => 'Editor above and console below.';

  @override
  String get tabsLayout => 'Tabs Layout';

  @override
  String get tabsLayoutSubtitle => 'Editor and console in tabs.';

  @override
  String get preview => 'Preview:';

  @override
  String get layoutSaved => 'Layout saved';

  @override
  String get suggestionSettings => 'Suggestion Settings';

  @override
  String get suggestionModes => 'Suggestion Modes';

  @override
  String get basicSuggestions => 'Basic Suggestions';

  @override
  String get basicSuggestionsDescription => 'Displays full SQL examples like \"SELECT * FROM\". Ideal for quick queries.';

  @override
  String get advancedSuggestions => 'Advanced Suggestions';

  @override
  String get advancedSuggestionsDescription => 'Shows short hints like \"ALL\" or \"COUNT\" that expand into full SQL statements when clicked.';

  @override
  String get otherSuggestions => 'Other Suggestions';

  @override
  String get characterSuggestions => 'Character Suggestions';

  @override
  String get characterSuggestionsDescription => 'Adds quick buttons to >, =, !, %, ; and more.';

  @override
  String get saveSettings => 'Save Settings';

  @override
  String get advancedSuggestionsInitialized => 'Advanced suggestions have been initialized successfully.';

  @override
  String get advancedSuggestionsFailed => 'Failed to initialize advanced suggestions.';

  @override
  String get settingsSavedSuccessfully => 'Settings saved successfully!';

  @override
  String get configure => 'Configure';

  @override
  String get createSuggestion => 'Create Suggestion';

  @override
  String get suggestionName => 'Suggestion name';

  @override
  String get create => 'Create';

  @override
  String get enterSuggestionName => 'Enter a name for the suggestion.';

  @override
  String get invalidCharacters => 'Invalid characters';

  @override
  String get removeSuggestion => 'Remove Suggestion';

  @override
  String get removeSuggestionDescription => 'Are you sure you want to remove this suggestion?';

  @override
  String get remove => 'Remove';

  @override
  String get resetSuggestions => 'Reset Suggestions';

  @override
  String get resetSuggestionsDescription => 'Are you sure you want to reset the suggestion list?';

  @override
  String get reset => 'Reset';

  @override
  String get advancedSuggestionAdded => 'Suggestion added successfully.';

  @override
  String get advancedSuggestionFailed => 'Failed to add suggestion.';

  @override
  String deleteSuggestionConfirmation(Object label) {
    return 'Are you sure you want to delete the suggestion \"$label\"?';
  }

  @override
  String get suggestionDeleted => 'Suggestion deleted successfully.';

  @override
  String get suggestionDeleteFailed => 'Failed to delete suggestion.';

  @override
  String get resetSuggestionsConfirm => 'Are you sure you want to reset the suggestions?';

  @override
  String get suggestionsResetSuccess => 'All suggestions have been reset successfully.';

  @override
  String get suggestionsResetFailed => 'Failed to reset suggestions. Please try again.';

  @override
  String get label => 'Label';

  @override
  String get sqlCode => 'SQL Code';

  @override
  String get selectableTextOptional => 'Selectable Text (optional)';

  @override
  String get selectableTextHint => 'Part of SQL to auto-select for user replacement';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get updateSuggestion => 'Update Suggestion';

  @override
  String get update => 'Update';

  @override
  String get updateSuggestionSuccess => 'Suggestion updated successfully.';

  @override
  String get updateSuggestionFail => 'Failed to update suggestion.';

  @override
  String get editSuggestion => 'Edit suggestion';

  @override
  String get deleteSuggestion => 'Delete suggestion';

  @override
  String get save => 'Save';

  @override
  String get exitScreen => 'Exit screen';

  @override
  String get error => 'Error';

  @override
  String get failedToSaveWorkspaceLayout => 'Failed to save workspace layout. Please try again.';

  @override
  String databaseCreationError(Object databaseName) {
    return 'Could not create the database \"$databaseName\".';
  }

  @override
  String get fetchDatabasesError => 'Could not fetch the created databases.';

  @override
  String get checkDatabaseExistsError => 'Unable to check if the database already exists.';

  @override
  String deleteDatabaseError(Object databaseName) {
    return 'Unable to delete the database \"$databaseName\".';
  }

  @override
  String get noRecordDeleted => 'No record was deleted';

  @override
  String toggleDatabaseFavoriteError(Object databaseName) {
    return 'Unable to change the favorite status of the database \"$databaseName\".';
  }

  @override
  String get unableToClear => 'Unable to clear databases';

  @override
  String get failedToGetAppVersion => 'Failed to get app version';

  @override
  String sqlExecutionError(Object error) {
    return 'SQL execution error: $error';
  }

  @override
  String get noDatabaseSelected => 'No database selected';

  @override
  String get failedToLoadSqlSuggestions => 'Failed to load SQL suggestions';

  @override
  String get failedToSaveSqlSuggestionsSettings => 'Failed to save SQL suggestions settings';

  @override
  String get failedToLoadAdvancedSuggestions => 'Failed to load advanced suggestions';

  @override
  String get failedToAddAdvancedSuggestion => 'Failed to add advanced suggestion';

  @override
  String get failedToUpdateAdvancedSuggestion => 'Failed to update advanced suggestion';

  @override
  String get failedToRemoveAdvancedSuggestion => 'Failed to remove advanced suggestion';

  @override
  String get failedToSaveAllAdvancedSuggestions => 'Failed to save all advanced suggestions';

  @override
  String get failedToReorderAdvancedSuggestions => 'Failed to reorder advanced suggestions';

  @override
  String get failedToResetAdvancedSuggestions => 'Failed to reset advanced suggestions';

  @override
  String get failedToLoadBasicSuggestions => 'Failed to load basic suggestions';

  @override
  String get failedToAddBasicSuggestion => 'Failed to add basic suggestion';

  @override
  String get failedToUpdateBasicSuggestions => 'Failed to update basic suggestions';

  @override
  String get failedToRemoveBasicSuggestion => 'Failed to remove basic suggestion';

  @override
  String get failedToResetBasicSuggestions => 'Failed to reset basic suggestions';

  @override
  String failedToLoadSqlFiles(Object error) {
    return 'Failed to load SQL files: $error';
  }

  @override
  String failedToExecuteSql(Object dbName, Object error) {
    return 'Failed to execute SQL for \"$dbName\": $error';
  }

  @override
  String get databaseResetSuccessfully => 'Database reset successfully';

  @override
  String get unknownError => 'Unknown error';
}
