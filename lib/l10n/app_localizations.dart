import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// Title of the home screen.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Title of the databases screen listing the sample databases.
  ///
  /// In en, this message translates to:
  /// **'Databases'**
  String get databases;

  /// Title of the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label of the home tab in the bottom navigation bar.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Label of the databases tab in the bottom navigation bar.
  ///
  /// In en, this message translates to:
  /// **'Databases'**
  String get navDatabases;

  /// Label of the settings tab in the bottom navigation bar.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Header of the general group in settings.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// Label of the setting that opens the app language picker.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Label of the setting that opens the app theme picker.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Name of the light theme in the theme picker.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Name of the dark theme in the theme picker.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Name of the theme option that follows the system setting.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// Toast confirming the app theme changed.
  ///
  /// In en, this message translates to:
  /// **'Theme updated to {theme}'**
  String themeUpdated(Object theme);

  /// Label of the setting that opens the SQL suggestion settings.
  ///
  /// In en, this message translates to:
  /// **'SQL Suggestions'**
  String get sqlSuggestions;

  /// Label of the setting that opens the workspace layout settings.
  ///
  /// In en, this message translates to:
  /// **'Workspace Layout'**
  String get workspaceLayout;

  /// Header of the information group on the about screen.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// Label of the row showing the installed app version.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// Title of the about screen.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// One-sentence description of the app, shown on the about screen.
  ///
  /// In en, this message translates to:
  /// **'Practice SQL on your phone with local, editable, fully offline SQLite databases.'**
  String get appDescription;

  /// Installed app version, shown on the about screen.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(Object version);

  /// Label of the entry that opens the open-source licenses screen.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// Credit line naming the app developer, shown on the about screen.
  ///
  /// In en, this message translates to:
  /// **'Developed by {name}'**
  String developedBy(Object name);

  /// Number of open-source packages listed on the licenses screen.
  ///
  /// In en, this message translates to:
  /// **'{count} open-source packages'**
  String packagesCount(Object count);

  /// Label of the link to the project website.
  ///
  /// In en, this message translates to:
  /// **'Official Website'**
  String get officialWebsite;

  /// Label of the settings entry that opens the privacy policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Label of the link that opens the contact address.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// Title of the dialog shown when a link cannot be opened.
  ///
  /// In en, this message translates to:
  /// **'Error opening URL'**
  String get errorOpeningUrl;

  /// Body of the dialog shown when a link cannot be opened.
  ///
  /// In en, this message translates to:
  /// **'The URL {url} could not be opened.'**
  String errorOpeningUrlDescription(Object url);

  /// Tooltip of the button that expands a workspace panel to full screen.
  ///
  /// In en, this message translates to:
  /// **'Enter Fullscreen'**
  String get enterFullscreen;

  /// Tooltip of the button that restores a full screen workspace panel.
  ///
  /// In en, this message translates to:
  /// **'Exit Fullscreen'**
  String get exitFullscreen;

  /// Title of the SQL editor panel.
  ///
  /// In en, this message translates to:
  /// **'Editor'**
  String get editor;

  /// Label of the action opening the visual schema of the active database.
  ///
  /// In en, this message translates to:
  /// **'View Visual Scheme'**
  String get viewVisualScheme;

  /// Label of the action restoring a sample database to its bundled data.
  ///
  /// In en, this message translates to:
  /// **'Reset Database'**
  String get resetDatabase;

  /// Tooltip of the button that runs the SQL in the editor.
  ///
  /// In en, this message translates to:
  /// **'Run Query'**
  String get runQuery;

  /// Tooltip of the button that empties the SQL editor.
  ///
  /// In en, this message translates to:
  /// **'Clear Editor'**
  String get clearEditor;

  /// Title of the console panel showing query results.
  ///
  /// In en, this message translates to:
  /// **'Console'**
  String get console;

  /// Tooltip of the button that clears the console output.
  ///
  /// In en, this message translates to:
  /// **'Clear Console'**
  String get clearConsole;

  /// Console placeholder shown before any query has run.
  ///
  /// In en, this message translates to:
  /// **'Run a query to see the results here'**
  String get noQueryRunYet;

  /// Console message shown when a query returns no rows.
  ///
  /// In en, this message translates to:
  /// **'Query executed, no data to display'**
  String get queryExecutedNoResult;

  /// Toast confirming the schema SQL was copied.
  ///
  /// In en, this message translates to:
  /// **'Schema copied'**
  String get schemaCopied;

  /// Toast confirming the seed SQL was copied.
  ///
  /// In en, this message translates to:
  /// **'Seed copied'**
  String get seedCopied;

  /// Toast confirming both the schema and the seed SQL were copied.
  ///
  /// In en, this message translates to:
  /// **'Schema and Seed copied'**
  String get schemaAndSeedCopied;

  /// Label of the action opening the visual schema of a sample database.
  ///
  /// In en, this message translates to:
  /// **'View Structure'**
  String get viewStructure;

  /// Tooltip of the action that queries every row of a table in the visualizer.
  ///
  /// In en, this message translates to:
  /// **'View table data'**
  String get viewTableData;

  /// Label of the action copying the schema SQL of a sample database.
  ///
  /// In en, this message translates to:
  /// **'Copy Schema'**
  String get copySchema;

  /// Label of the action copying the seed SQL of a sample database.
  ///
  /// In en, this message translates to:
  /// **'Copy Seed'**
  String get copySeed;

  /// Label of the action copying both the schema and the seed SQL.
  ///
  /// In en, this message translates to:
  /// **'Copy All'**
  String get copyAll;

  /// Header of the sample database menu section about its structure.
  ///
  /// In en, this message translates to:
  /// **'Structure'**
  String get structureSection;

  /// Header of the sample database menu section about its SQL files.
  ///
  /// In en, this message translates to:
  /// **'SQL files'**
  String get sqlFilesSection;

  /// Hint of the field that filters the database list by name.
  ///
  /// In en, this message translates to:
  /// **'Search databases'**
  String get searchDatabases;

  /// Label of the action that opens the create database dialog.
  ///
  /// In en, this message translates to:
  /// **'New Database'**
  String get newDatabase;

  /// Header of the favorite databases group in the list.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Header of the non-favorite databases group in the list.
  ///
  /// In en, this message translates to:
  /// **'All Databases'**
  String get allDatabases;

  /// Label of the action marking a database as a favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// Label of the action removing a database from the favorites.
  ///
  /// In en, this message translates to:
  /// **'Unfavorite'**
  String get unfavorite;

  /// Label of a destructive confirm action.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Label of the button dismissing a dialog without acting.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Label of the button acknowledging a dialog.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Title of a confirmation dialog for a destructive action.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get attention;

  /// Body of the dialog confirming a database is deleted for good.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete this database? This action cannot be undone.'**
  String get deleteDatabaseConfirmation;

  /// Name of the to-do list sample database.
  ///
  /// In en, this message translates to:
  /// **'To-Do List'**
  String get toDoListLabel;

  /// Description of the to-do list sample database.
  ///
  /// In en, this message translates to:
  /// **'Simple task management database'**
  String get toDoListDescription;

  /// Name of the contacts sample database.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsLabel;

  /// Description of the contacts sample database.
  ///
  /// In en, this message translates to:
  /// **'Contacts and groups database'**
  String get contactsDescription;

  /// Name of the library sample database.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryLabel;

  /// Description of the library sample database.
  ///
  /// In en, this message translates to:
  /// **'Library with books, members, and loans'**
  String get libraryDescription;

  /// Name of the fitness club sample database.
  ///
  /// In en, this message translates to:
  /// **'Fitness Club'**
  String get fitnessClubLabel;

  /// Description of the fitness club sample database.
  ///
  /// In en, this message translates to:
  /// **'Gym members and subscriptions database'**
  String get fitnessClubDescription;

  /// Name of the car rental sample database.
  ///
  /// In en, this message translates to:
  /// **'Car Rental'**
  String get carRentalLabel;

  /// Description of the car rental sample database.
  ///
  /// In en, this message translates to:
  /// **'Car rental management database'**
  String get carRentalDescription;

  /// Name of the restaurant sample database.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get restaurantLabel;

  /// Description of the restaurant sample database.
  ///
  /// In en, this message translates to:
  /// **'Restaurant orders and menu items database'**
  String get restaurantDescription;

  /// Name of the HR payroll sample database.
  ///
  /// In en, this message translates to:
  /// **'HR Payroll'**
  String get hrPayrollLabel;

  /// Description of the HR payroll sample database.
  ///
  /// In en, this message translates to:
  /// **'Company departments, job positions, employees, and salary history'**
  String get hrPayrollDescription;

  /// Name of the logistics sample database.
  ///
  /// In en, this message translates to:
  /// **'Logistics'**
  String get logisticsLabel;

  /// Description of the logistics sample database.
  ///
  /// In en, this message translates to:
  /// **'Packages, drivers, deliveries, and status history database'**
  String get logisticsDescription;

  /// Name of the pharmacy sample database.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get pharmacyLabel;

  /// Description of the pharmacy sample database.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy inventory, suppliers, customers, and sales database'**
  String get pharmacyDescription;

  /// Name of the school sample database.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get schoolLabel;

  /// Description of the school sample database.
  ///
  /// In en, this message translates to:
  /// **'School management with students, teachers, classes, enrollments, and grades'**
  String get schoolDescription;

  /// Name of the social network sample database.
  ///
  /// In en, this message translates to:
  /// **'Social Network'**
  String get socialNetworkLabel;

  /// Description of the social network sample database.
  ///
  /// In en, this message translates to:
  /// **'Social media with users, posts, likes, comments, and followers'**
  String get socialNetworkDescription;

  /// Name of the hotel sample database.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get hotelLabel;

  /// Description of the hotel sample database.
  ///
  /// In en, this message translates to:
  /// **'Hotel reservations, rooms, payments, employees, and services database'**
  String get hotelDescription;

  /// Name of the banking sample database.
  ///
  /// In en, this message translates to:
  /// **'Banking'**
  String get bankingLabel;

  /// Description of the banking sample database.
  ///
  /// In en, this message translates to:
  /// **'Banking system with accounts, transactions, loans, and employees'**
  String get bankingDescription;

  /// Name of the e-commerce sample database.
  ///
  /// In en, this message translates to:
  /// **'E-Commerce'**
  String get eCommerceLabel;

  /// Description of the e-commerce sample database.
  ///
  /// In en, this message translates to:
  /// **'Online store with products, orders, carts, and reviews'**
  String get eCommerceDescription;

  /// Tooltip of the control that opens a panel in full screen.
  ///
  /// In en, this message translates to:
  /// **'Open Fullscreen'**
  String get openFullscreen;

  /// Tooltip of the button that opens a popup menu of actions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// Singular noun for a database table.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get table;

  /// Header above the list of tables a sample database contains.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get tables;

  /// Name of the layout that stacks the editor above the console.
  ///
  /// In en, this message translates to:
  /// **'Split Layout'**
  String get splitLayout;

  /// Description of the split workspace layout.
  ///
  /// In en, this message translates to:
  /// **'Editor above and console below.'**
  String get splitLayoutSubtitle;

  /// Name of the layout that puts the editor and console in tabs.
  ///
  /// In en, this message translates to:
  /// **'Tabs Layout'**
  String get tabsLayout;

  /// Description of the tabbed workspace layout.
  ///
  /// In en, this message translates to:
  /// **'Editor and console in tabs.'**
  String get tabsLayoutSubtitle;

  /// Header above the live preview of the selected workspace layout.
  ///
  /// In en, this message translates to:
  /// **'Preview:'**
  String get preview;

  /// Toast confirming the workspace layout was saved.
  ///
  /// In en, this message translates to:
  /// **'Layout saved'**
  String get layoutSaved;

  /// Title of the SQL suggestion settings screen.
  ///
  /// In en, this message translates to:
  /// **'Suggestion Settings'**
  String get suggestionSettings;

  /// Header of the group toggling each suggestion mode.
  ///
  /// In en, this message translates to:
  /// **'Suggestion Modes'**
  String get suggestionModes;

  /// Name of the suggestion mode offering full SQL examples.
  ///
  /// In en, this message translates to:
  /// **'Basic Suggestions'**
  String get basicSuggestions;

  /// Description of the basic suggestion mode.
  ///
  /// In en, this message translates to:
  /// **'Displays full SQL examples like \"SELECT * FROM\". Ideal for quick queries.'**
  String get basicSuggestionsDescription;

  /// Name of the suggestion mode offering short expandable hints.
  ///
  /// In en, this message translates to:
  /// **'Advanced Suggestions'**
  String get advancedSuggestions;

  /// Description of the advanced suggestion mode.
  ///
  /// In en, this message translates to:
  /// **'Shows short hints like \"ALL\" or \"COUNT\" that expand into full SQL statements when clicked.'**
  String get advancedSuggestionsDescription;

  /// Header of the group holding the remaining editor shortcuts.
  ///
  /// In en, this message translates to:
  /// **'Editor Shortcuts'**
  String get otherSuggestions;

  /// Name of the shortcut bar offering SQL symbols.
  ///
  /// In en, this message translates to:
  /// **'Quick Symbols'**
  String get characterSuggestions;

  /// Description of the quick symbols shortcut bar.
  ///
  /// In en, this message translates to:
  /// **'Adds quick buttons to >, =, !, %, ; and more.'**
  String get characterSuggestionsDescription;

  /// Label of the button saving the suggestion settings.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get saveSettings;

  /// Toast confirming the advanced suggestions were seeded with the defaults.
  ///
  /// In en, this message translates to:
  /// **'Advanced suggestions have been initialized successfully'**
  String get advancedSuggestionsInitialized;

  /// Toast shown when seeding the default advanced suggestions fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize advanced suggestions'**
  String get advancedSuggestionsFailed;

  /// Toast confirming the suggestion settings were saved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully'**
  String get settingsSavedSuccessfully;

  /// Label of the action opening the settings of a suggestion mode.
  ///
  /// In en, this message translates to:
  /// **'Configure'**
  String get configure;

  /// Title of the dialog creating a suggestion.
  ///
  /// In en, this message translates to:
  /// **'Create Suggestion'**
  String get createSuggestion;

  /// Label of the field holding the name of a suggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion name'**
  String get suggestionName;

  /// Label of the button confirming creation.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Validation error shown when the suggestion name is empty.
  ///
  /// In en, this message translates to:
  /// **'Enter a name for the suggestion.'**
  String get enterSuggestionName;

  /// Validation error shown when a suggestion name contains unsupported characters.
  ///
  /// In en, this message translates to:
  /// **'Invalid characters'**
  String get invalidCharacters;

  /// Title of the dialog removing a suggestion.
  ///
  /// In en, this message translates to:
  /// **'Remove Suggestion'**
  String get removeSuggestion;

  /// Body of the dialog confirming a suggestion is removed.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this suggestion?'**
  String get removeSuggestionDescription;

  /// Label of the action removing an item from a list.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// Label of the action restoring the default suggestions.
  ///
  /// In en, this message translates to:
  /// **'Reset Suggestions'**
  String get resetSuggestions;

  /// Body of the dialog confirming the suggestion list is reset.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset the suggestion list?'**
  String get resetSuggestionsDescription;

  /// Label of the button confirming a reset to defaults.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Toast confirming an advanced suggestion was created.
  ///
  /// In en, this message translates to:
  /// **'Suggestion added successfully'**
  String get advancedSuggestionAdded;

  /// Toast shown when creating an advanced suggestion fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to add suggestion'**
  String get advancedSuggestionFailed;

  /// Body of the dialog confirming a suggestion is deleted.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the suggestion \"{label}\"?'**
  String deleteSuggestionConfirmation(Object label);

  /// Toast confirming a suggestion was deleted.
  ///
  /// In en, this message translates to:
  /// **'Suggestion deleted successfully'**
  String get suggestionDeleted;

  /// Toast shown when deleting a suggestion fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete suggestion'**
  String get suggestionDeleteFailed;

  /// Body of the dialog confirming the advanced suggestions are reset.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset the suggestions?'**
  String get resetSuggestionsConfirm;

  /// Toast confirming the suggestions were restored to the defaults.
  ///
  /// In en, this message translates to:
  /// **'All suggestions have been reset successfully'**
  String get suggestionsResetSuccess;

  /// Toast shown when restoring the default suggestions fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset suggestions. Please try again'**
  String get suggestionsResetFailed;

  /// Label of the field holding the display name of a database.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// Label of the field holding the SQL a suggestion inserts.
  ///
  /// In en, this message translates to:
  /// **'SQL Code'**
  String get sqlCode;

  /// Label of the optional field naming the part of the SQL to pre-select.
  ///
  /// In en, this message translates to:
  /// **'Selectable Text (optional)'**
  String get selectableTextOptional;

  /// Hint explaining what the selectable text field is for.
  ///
  /// In en, this message translates to:
  /// **'Part of SQL to auto-select for user replacement'**
  String get selectableTextHint;

  /// Validation error shown when a required suggestion field is empty.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// Title of the dialog editing a suggestion.
  ///
  /// In en, this message translates to:
  /// **'Update Suggestion'**
  String get updateSuggestion;

  /// Label of the button confirming an update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Toast confirming a suggestion was updated.
  ///
  /// In en, this message translates to:
  /// **'Suggestion updated successfully'**
  String get updateSuggestionSuccess;

  /// Toast shown when updating a suggestion fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to update suggestion'**
  String get updateSuggestionFail;

  /// Tooltip of the button that edits a suggestion.
  ///
  /// In en, this message translates to:
  /// **'Edit suggestion'**
  String get editSuggestion;

  /// Tooltip of the button that deletes a suggestion.
  ///
  /// In en, this message translates to:
  /// **'Delete suggestion'**
  String get deleteSuggestion;

  /// Label of the button persisting the current changes.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Tooltip of the button that closes a full screen view.
  ///
  /// In en, this message translates to:
  /// **'Exit screen'**
  String get exitScreen;

  /// Title of the screen shown when the app cannot load its local state.
  ///
  /// In en, this message translates to:
  /// **'Could not start SQL Studio'**
  String get startupFailedTitle;

  /// Body of the screen shown when the app cannot load its local state.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while loading your data. Try again, or clear the app data if the problem persists.'**
  String get startupFailedMessage;

  /// Label of the button running the startup sequence again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// Label of the button deleting every database and setting on the device.
  ///
  /// In en, this message translates to:
  /// **'Clear app data'**
  String get clearAppData;

  /// Body of the dialog confirming every database and setting is deleted.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes every database and setting stored on this device. This action cannot be undone.'**
  String get clearAppDataConfirmation;

  /// Fallback message shown when a widget fails to build in release.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get unexpectedError;

  /// Range of result rows currently shown, and the total row count.
  ///
  /// In en, this message translates to:
  /// **'{start}-{end} of {total}'**
  String tableRowsRange(int start, int end, int total);

  /// Tooltip of the button that clears the database search field.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// Tooltip of the button that empties a text field.
  ///
  /// In en, this message translates to:
  /// **'Clear field'**
  String get clearField;

  /// Tooltip of the button showing the previous page of result rows.
  ///
  /// In en, this message translates to:
  /// **'Previous page'**
  String get previousPage;

  /// Tooltip of the button showing the next page of result rows.
  ///
  /// In en, this message translates to:
  /// **'Next page'**
  String get nextPage;

  /// Tooltip of the visualizer control that zooms the canvas in.
  ///
  /// In en, this message translates to:
  /// **'Zoom in'**
  String get zoomIn;

  /// Tooltip of the visualizer control that zooms the canvas out.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get zoomOut;

  /// Tooltip of the visualizer control that restores the default zoom.
  ///
  /// In en, this message translates to:
  /// **'Reset zoom'**
  String get resetZoom;

  /// Title of the dialog reporting a failure.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Failure shown when the workspace layout cannot be saved.
  ///
  /// In en, this message translates to:
  /// **'Failed to save workspace layout. Please try again.'**
  String get failedToSaveWorkspaceLayout;

  /// Failure shown when a database cannot be created.
  ///
  /// In en, this message translates to:
  /// **'Could not create the database \"{databaseName}\".'**
  String databaseCreationError(Object databaseName);

  /// Failure shown when the database list cannot be read.
  ///
  /// In en, this message translates to:
  /// **'Could not fetch the created databases.'**
  String get fetchDatabasesError;

  /// Failure shown when the app cannot tell whether a database already exists.
  ///
  /// In en, this message translates to:
  /// **'Unable to check if the database already exists.'**
  String get checkDatabaseExistsError;

  /// Failure shown when a database cannot be deleted.
  ///
  /// In en, this message translates to:
  /// **'Unable to delete the database \"{databaseName}\".'**
  String deleteDatabaseError(Object databaseName);

  /// Failure shown when a delete matched no record.
  ///
  /// In en, this message translates to:
  /// **'No record was deleted'**
  String get noRecordDeleted;

  /// Failure shown when the favorite state of a database cannot be changed.
  ///
  /// In en, this message translates to:
  /// **'Unable to change the favorite status of the database \"{databaseName}\".'**
  String toggleDatabaseFavoriteError(Object databaseName);

  /// Failure shown when the databases cannot be cleared.
  ///
  /// In en, this message translates to:
  /// **'Unable to clear databases'**
  String get unableToClear;

  /// Failure shown when the installed app version cannot be read.
  ///
  /// In en, this message translates to:
  /// **'Failed to get app version'**
  String get failedToGetAppVersion;

  /// Failure shown when the SQL entered by the user cannot be executed.
  ///
  /// In en, this message translates to:
  /// **'SQL execution error: {error}'**
  String sqlExecutionError(Object error);

  /// Failure shown when a query runs with no active database.
  ///
  /// In en, this message translates to:
  /// **'No database selected'**
  String get noDatabaseSelected;

  /// Failure shown when the SQL suggestions cannot be read.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SQL suggestions'**
  String get failedToLoadSqlSuggestions;

  /// Failure shown when the suggestion settings cannot be saved.
  ///
  /// In en, this message translates to:
  /// **'Failed to save SQL suggestions settings'**
  String get failedToSaveSqlSuggestionsSettings;

  /// Failure shown when the advanced suggestions cannot be read.
  ///
  /// In en, this message translates to:
  /// **'Failed to load advanced suggestions'**
  String get failedToLoadAdvancedSuggestions;

  /// Failure shown when an advanced suggestion cannot be created.
  ///
  /// In en, this message translates to:
  /// **'Failed to add advanced suggestion'**
  String get failedToAddAdvancedSuggestion;

  /// Failure shown when an advanced suggestion cannot be updated.
  ///
  /// In en, this message translates to:
  /// **'Failed to update advanced suggestion'**
  String get failedToUpdateAdvancedSuggestion;

  /// Failure shown when an advanced suggestion cannot be removed.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove advanced suggestion'**
  String get failedToRemoveAdvancedSuggestion;

  /// Failure shown when the advanced suggestions cannot be saved.
  ///
  /// In en, this message translates to:
  /// **'Failed to save all advanced suggestions'**
  String get failedToSaveAllAdvancedSuggestions;

  /// Failure shown when the advanced suggestions cannot be reordered.
  ///
  /// In en, this message translates to:
  /// **'Failed to reorder advanced suggestions'**
  String get failedToReorderAdvancedSuggestions;

  /// Failure shown when the advanced suggestions cannot be reset.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset advanced suggestions'**
  String get failedToResetAdvancedSuggestions;

  /// Failure shown when the basic suggestions cannot be read.
  ///
  /// In en, this message translates to:
  /// **'Failed to load basic suggestions'**
  String get failedToLoadBasicSuggestions;

  /// Failure shown when a basic suggestion cannot be created.
  ///
  /// In en, this message translates to:
  /// **'Failed to add basic suggestion'**
  String get failedToAddBasicSuggestion;

  /// Failure shown when the basic suggestions cannot be updated.
  ///
  /// In en, this message translates to:
  /// **'Failed to update basic suggestions'**
  String get failedToUpdateBasicSuggestions;

  /// Failure shown when a basic suggestion cannot be removed.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove basic suggestion'**
  String get failedToRemoveBasicSuggestion;

  /// Failure shown when the basic suggestions cannot be reset.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset basic suggestions'**
  String get failedToResetBasicSuggestions;

  /// Failure shown when the bundled SQL files of a sample database cannot be read.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SQL files: {error}'**
  String failedToLoadSqlFiles(Object error);

  /// Failure shown when seeding a sample database fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to execute SQL for \"{dbName}\": {error}'**
  String failedToExecuteSql(Object dbName, Object error);

  /// Toast confirming a sample database was restored.
  ///
  /// In en, this message translates to:
  /// **'Database reset successfully'**
  String get databaseResetSuccessfully;

  /// Failure shown when the structure of a database cannot be read.
  ///
  /// In en, this message translates to:
  /// **'Could not load the database structure.'**
  String get failedToLoadDatabaseStructure;

  /// Toast confirming a database was created.
  ///
  /// In en, this message translates to:
  /// **'Database created successfully'**
  String get databaseCreatedSuccessfully;

  /// Toast confirming a database was deleted.
  ///
  /// In en, this message translates to:
  /// **'Database deleted successfully'**
  String get databaseDeletedSuccessfully;

  /// Message used when a failure carries no more specific reason.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// Title of the dialog where a new database is created.
  ///
  /// In en, this message translates to:
  /// **'Create Database'**
  String get createDatabase;

  /// Label of the field holding the file name of a database.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Validation error shown when the label field is empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a label'**
  String get pleaseEnterLabel;

  /// Validation error shown when the name field is empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get pleaseEnterName;

  /// Validation error shown when a database name contains unsupported characters.
  ///
  /// In en, this message translates to:
  /// **'Invalid characters detected'**
  String get invalidCharactersDetected;

  /// Validation error shown when a database with that name already exists.
  ///
  /// In en, this message translates to:
  /// **'Database \"{name}\" already exists'**
  String databaseAlreadyExists(Object name);

  /// Toast confirming the app language changed.
  ///
  /// In en, this message translates to:
  /// **'Language updated to {lang}'**
  String languageUpdated(Object lang);

  /// Text shown under the progress bar on the splash screen.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Message shown when the visualized database has no tables.
  ///
  /// In en, this message translates to:
  /// **'The database is empty'**
  String get theDatabaseIsEmpty;

  /// Message shown when no database has been created yet.
  ///
  /// In en, this message translates to:
  /// **'No databases yet'**
  String get noDatabasesYet;

  /// Message shown when the search filter matches no database.
  ///
  /// In en, this message translates to:
  /// **'No databases found'**
  String get noDatabasesFound;

  /// Message shown when the suggestion list is empty.
  ///
  /// In en, this message translates to:
  /// **'No suggestions yet'**
  String get noSuggestionsYet;

  /// Tooltip of the control that switches between light and dark theme.
  ///
  /// In en, this message translates to:
  /// **'Toggle Theme'**
  String get toggleTheme;

  /// Title shown when a route does not match any screen.
  ///
  /// In en, this message translates to:
  /// **'Screen Not Found'**
  String get screenNotFound;

  /// Body text shown when a route does not match any screen.
  ///
  /// In en, this message translates to:
  /// **'The screen you are looking for does not exist or has been moved.'**
  String get screenNotFoundDescription;

  /// Label of the button returning to the home screen from the not-found screen.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get goHome;

  /// Label of the button confirming a form dialog.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Validation error shown when a required dialog field is empty.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get thisFieldIsRequired;

  /// Toast confirming a reordered list was saved.
  ///
  /// In en, this message translates to:
  /// **'Sort order saved successfully'**
  String get sortOrderSavedSuccessfully;

  /// Toast shown when saving a reordered list fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to save sort order'**
  String get failedToSaveSortOrder;

  /// Console message reporting how many rows a DELETE removed.
  ///
  /// In en, this message translates to:
  /// **'Delete executed successfully. {count} rows affected.'**
  String deleteSuccess(Object count);

  /// Console message reporting how many rows an UPDATE changed.
  ///
  /// In en, this message translates to:
  /// **'Update executed successfully. {count} rows affected.'**
  String updateSuccess(Object count);

  /// Console message reporting the id of the inserted row.
  ///
  /// In en, this message translates to:
  /// **'Insert executed successfully. {count} rows affected.'**
  String insertSuccess(Object count);

  /// Console message reporting a statement ran with no rows to show.
  ///
  /// In en, this message translates to:
  /// **'Statement executed successfully.'**
  String get statementSuccess;

  /// Tooltip of the button that restores the last executed query.
  ///
  /// In en, this message translates to:
  /// **'Load Last SQL'**
  String get loadLastSql;

  /// Tooltip of the button that shares the editor content as text.
  ///
  /// In en, this message translates to:
  /// **'Share query'**
  String get shareSql;

  /// Tooltip of the button that saves the editor content as a .sql file.
  ///
  /// In en, this message translates to:
  /// **'Download query'**
  String get downloadSql;

  /// Toast shown when the editor is empty and there is nothing to share.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to share'**
  String get nothingToShare;

  /// Toast confirming the query was shared.
  ///
  /// In en, this message translates to:
  /// **'SQL shared successfully'**
  String get sqlSharedSuccess;

  /// Tooltip of the button that copies the editor content.
  ///
  /// In en, this message translates to:
  /// **'Copy query'**
  String get copySql;

  /// Toast shown when the editor is empty and there is nothing to copy.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to copy'**
  String get nothingToCopy;

  /// Toast confirming the query was copied to the clipboard.
  ///
  /// In en, this message translates to:
  /// **'SQL copied to clipboard'**
  String get sqlCopied;

  /// Header of the editor menu section acting on the current query.
  ///
  /// In en, this message translates to:
  /// **'Current query'**
  String get currentQuerySection;

  /// Header of the editor menu section acting on the active database.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get databaseSection;

  /// Toast shown when the editor is empty and there is nothing to save.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to download'**
  String get nothingToDownload;

  /// Toast confirming the query was saved as a file.
  ///
  /// In en, this message translates to:
  /// **'Query saved as a .sql file'**
  String get sqlDownloaded;

  /// Toast shown when there is no previous query to restore.
  ///
  /// In en, this message translates to:
  /// **'No previous query to load'**
  String get nothingToLoad;

  /// Toast confirming the last executed query was restored.
  ///
  /// In en, this message translates to:
  /// **'Last query loaded'**
  String get lastSqlLoaded;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
