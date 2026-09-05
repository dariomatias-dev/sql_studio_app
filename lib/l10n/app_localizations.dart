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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @databases.
  ///
  /// In en, this message translates to:
  /// **'Databases'**
  String get databases;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navDatabases.
  ///
  /// In en, this message translates to:
  /// **'Databases'**
  String get navDatabases;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeUpdated.
  ///
  /// In en, this message translates to:
  /// **'Theme updated to {theme}'**
  String themeUpdated(Object theme);

  /// No description provided for @sqlSuggestions.
  ///
  /// In en, this message translates to:
  /// **'SQL Suggestions'**
  String get sqlSuggestions;

  /// No description provided for @workspaceLayout.
  ///
  /// In en, this message translates to:
  /// **'Workspace Layout'**
  String get workspaceLayout;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Practice SQL on your phone with local, editable, fully offline SQLite databases.'**
  String get appDescription;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(Object version);

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// No description provided for @developedBy.
  ///
  /// In en, this message translates to:
  /// **'Developed by {name}'**
  String developedBy(Object name);

  /// No description provided for @packagesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} open-source packages'**
  String packagesCount(Object count);

  /// No description provided for @officialWebsite.
  ///
  /// In en, this message translates to:
  /// **'Official Website'**
  String get officialWebsite;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @errorOpeningUrl.
  ///
  /// In en, this message translates to:
  /// **'Error opening URL'**
  String get errorOpeningUrl;

  /// No description provided for @errorOpeningUrlDescription.
  ///
  /// In en, this message translates to:
  /// **'The URL {url} could not be opened.'**
  String errorOpeningUrlDescription(Object url);

  /// No description provided for @enterFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Enter Fullscreen'**
  String get enterFullscreen;

  /// No description provided for @exitFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Exit Fullscreen'**
  String get exitFullscreen;

  /// No description provided for @editor.
  ///
  /// In en, this message translates to:
  /// **'Editor'**
  String get editor;

  /// No description provided for @viewVisualScheme.
  ///
  /// In en, this message translates to:
  /// **'View Visual Scheme'**
  String get viewVisualScheme;

  /// No description provided for @resetDatabase.
  ///
  /// In en, this message translates to:
  /// **'Reset Database'**
  String get resetDatabase;

  /// No description provided for @runQuery.
  ///
  /// In en, this message translates to:
  /// **'Run Query'**
  String get runQuery;

  /// No description provided for @clearEditor.
  ///
  /// In en, this message translates to:
  /// **'Clear Editor'**
  String get clearEditor;

  /// No description provided for @console.
  ///
  /// In en, this message translates to:
  /// **'Console'**
  String get console;

  /// No description provided for @clearConsole.
  ///
  /// In en, this message translates to:
  /// **'Clear Console'**
  String get clearConsole;

  /// No description provided for @noQueryRunYet.
  ///
  /// In en, this message translates to:
  /// **'Run a query to see the results here'**
  String get noQueryRunYet;

  /// No description provided for @queryExecutedNoResult.
  ///
  /// In en, this message translates to:
  /// **'Query executed, no data to display'**
  String get queryExecutedNoResult;

  /// No description provided for @schemaCopied.
  ///
  /// In en, this message translates to:
  /// **'Schema copied'**
  String get schemaCopied;

  /// No description provided for @seedCopied.
  ///
  /// In en, this message translates to:
  /// **'Seed copied'**
  String get seedCopied;

  /// No description provided for @schemaAndSeedCopied.
  ///
  /// In en, this message translates to:
  /// **'Schema and Seed copied'**
  String get schemaAndSeedCopied;

  /// No description provided for @viewStructure.
  ///
  /// In en, this message translates to:
  /// **'View Structure'**
  String get viewStructure;

  /// No description provided for @viewTableData.
  ///
  /// In en, this message translates to:
  /// **'View table data'**
  String get viewTableData;

  /// No description provided for @copySchema.
  ///
  /// In en, this message translates to:
  /// **'Copy Schema'**
  String get copySchema;

  /// No description provided for @copySeed.
  ///
  /// In en, this message translates to:
  /// **'Copy Seed'**
  String get copySeed;

  /// No description provided for @copyAll.
  ///
  /// In en, this message translates to:
  /// **'Copy All'**
  String get copyAll;

  /// No description provided for @structureSection.
  ///
  /// In en, this message translates to:
  /// **'Structure'**
  String get structureSection;

  /// No description provided for @sqlFilesSection.
  ///
  /// In en, this message translates to:
  /// **'SQL files'**
  String get sqlFilesSection;

  /// No description provided for @searchDatabases.
  ///
  /// In en, this message translates to:
  /// **'Search databases'**
  String get searchDatabases;

  /// No description provided for @newDatabase.
  ///
  /// In en, this message translates to:
  /// **'New Database'**
  String get newDatabase;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @allDatabases.
  ///
  /// In en, this message translates to:
  /// **'All Databases'**
  String get allDatabases;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @unfavorite.
  ///
  /// In en, this message translates to:
  /// **'Unfavorite'**
  String get unfavorite;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @attention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get attention;

  /// No description provided for @deleteDatabaseConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete this database? This action cannot be undone.'**
  String get deleteDatabaseConfirmation;

  /// No description provided for @toDoListLabel.
  ///
  /// In en, this message translates to:
  /// **'To-Do List'**
  String get toDoListLabel;

  /// No description provided for @toDoListDescription.
  ///
  /// In en, this message translates to:
  /// **'Simple task management database'**
  String get toDoListDescription;

  /// No description provided for @contactsLabel.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsLabel;

  /// No description provided for @contactsDescription.
  ///
  /// In en, this message translates to:
  /// **'Contacts and groups database'**
  String get contactsDescription;

  /// No description provided for @libraryLabel.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryLabel;

  /// No description provided for @libraryDescription.
  ///
  /// In en, this message translates to:
  /// **'Library with books, members, and loans'**
  String get libraryDescription;

  /// No description provided for @fitnessClubLabel.
  ///
  /// In en, this message translates to:
  /// **'Fitness Club'**
  String get fitnessClubLabel;

  /// No description provided for @fitnessClubDescription.
  ///
  /// In en, this message translates to:
  /// **'Gym members and subscriptions database'**
  String get fitnessClubDescription;

  /// No description provided for @carRentalLabel.
  ///
  /// In en, this message translates to:
  /// **'Car Rental'**
  String get carRentalLabel;

  /// No description provided for @carRentalDescription.
  ///
  /// In en, this message translates to:
  /// **'Car rental management database'**
  String get carRentalDescription;

  /// No description provided for @restaurantLabel.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get restaurantLabel;

  /// No description provided for @restaurantDescription.
  ///
  /// In en, this message translates to:
  /// **'Restaurant orders and menu items database'**
  String get restaurantDescription;

  /// No description provided for @hrPayrollLabel.
  ///
  /// In en, this message translates to:
  /// **'HR Payroll'**
  String get hrPayrollLabel;

  /// No description provided for @hrPayrollDescription.
  ///
  /// In en, this message translates to:
  /// **'Company departments, job positions, employees, and salary history'**
  String get hrPayrollDescription;

  /// No description provided for @logisticsLabel.
  ///
  /// In en, this message translates to:
  /// **'Logistics'**
  String get logisticsLabel;

  /// No description provided for @logisticsDescription.
  ///
  /// In en, this message translates to:
  /// **'Packages, drivers, deliveries, and status history database'**
  String get logisticsDescription;

  /// No description provided for @pharmacyLabel.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get pharmacyLabel;

  /// No description provided for @pharmacyDescription.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy inventory, suppliers, customers, and sales database'**
  String get pharmacyDescription;

  /// No description provided for @schoolLabel.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get schoolLabel;

  /// No description provided for @schoolDescription.
  ///
  /// In en, this message translates to:
  /// **'School management with students, teachers, classes, enrollments, and grades'**
  String get schoolDescription;

  /// No description provided for @socialNetworkLabel.
  ///
  /// In en, this message translates to:
  /// **'Social Network'**
  String get socialNetworkLabel;

  /// No description provided for @socialNetworkDescription.
  ///
  /// In en, this message translates to:
  /// **'Social media with users, posts, likes, comments, and followers'**
  String get socialNetworkDescription;

  /// No description provided for @hotelLabel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get hotelLabel;

  /// No description provided for @hotelDescription.
  ///
  /// In en, this message translates to:
  /// **'Hotel reservations, rooms, payments, employees, and services database'**
  String get hotelDescription;

  /// No description provided for @bankingLabel.
  ///
  /// In en, this message translates to:
  /// **'Banking'**
  String get bankingLabel;

  /// No description provided for @bankingDescription.
  ///
  /// In en, this message translates to:
  /// **'Banking system with accounts, transactions, loans, and employees'**
  String get bankingDescription;

  /// No description provided for @eCommerceLabel.
  ///
  /// In en, this message translates to:
  /// **'E-Commerce'**
  String get eCommerceLabel;

  /// No description provided for @eCommerceDescription.
  ///
  /// In en, this message translates to:
  /// **'Online store with products, orders, carts, and reviews'**
  String get eCommerceDescription;

  /// No description provided for @openFullscreen.
  ///
  /// In en, this message translates to:
  /// **'Open Fullscreen'**
  String get openFullscreen;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @table.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get table;

  /// No description provided for @tables.
  ///
  /// In en, this message translates to:
  /// **'Tables'**
  String get tables;

  /// No description provided for @splitLayout.
  ///
  /// In en, this message translates to:
  /// **'Split Layout'**
  String get splitLayout;

  /// No description provided for @splitLayoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Editor above and console below.'**
  String get splitLayoutSubtitle;

  /// No description provided for @tabsLayout.
  ///
  /// In en, this message translates to:
  /// **'Tabs Layout'**
  String get tabsLayout;

  /// No description provided for @tabsLayoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Editor and console in tabs.'**
  String get tabsLayoutSubtitle;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview:'**
  String get preview;

  /// No description provided for @layoutSaved.
  ///
  /// In en, this message translates to:
  /// **'Layout saved'**
  String get layoutSaved;

  /// No description provided for @suggestionSettings.
  ///
  /// In en, this message translates to:
  /// **'Suggestion Settings'**
  String get suggestionSettings;

  /// No description provided for @suggestionModes.
  ///
  /// In en, this message translates to:
  /// **'Suggestion Modes'**
  String get suggestionModes;

  /// No description provided for @basicSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Basic Suggestions'**
  String get basicSuggestions;

  /// No description provided for @basicSuggestionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Displays full SQL examples like \"SELECT * FROM\". Ideal for quick queries.'**
  String get basicSuggestionsDescription;

  /// No description provided for @advancedSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Advanced Suggestions'**
  String get advancedSuggestions;

  /// No description provided for @advancedSuggestionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Shows short hints like \"ALL\" or \"COUNT\" that expand into full SQL statements when clicked.'**
  String get advancedSuggestionsDescription;

  /// No description provided for @otherSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Editor Shortcuts'**
  String get otherSuggestions;

  /// No description provided for @characterSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Quick Symbols'**
  String get characterSuggestions;

  /// No description provided for @characterSuggestionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Adds quick buttons to >, =, !, %, ; and more.'**
  String get characterSuggestionsDescription;

  /// No description provided for @saveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get saveSettings;

  /// No description provided for @advancedSuggestionsInitialized.
  ///
  /// In en, this message translates to:
  /// **'Advanced suggestions have been initialized successfully'**
  String get advancedSuggestionsInitialized;

  /// No description provided for @advancedSuggestionsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize advanced suggestions'**
  String get advancedSuggestionsFailed;

  /// No description provided for @settingsSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully'**
  String get settingsSavedSuccessfully;

  /// No description provided for @configure.
  ///
  /// In en, this message translates to:
  /// **'Configure'**
  String get configure;

  /// No description provided for @createSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Create Suggestion'**
  String get createSuggestion;

  /// No description provided for @suggestionName.
  ///
  /// In en, this message translates to:
  /// **'Suggestion name'**
  String get suggestionName;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @enterSuggestionName.
  ///
  /// In en, this message translates to:
  /// **'Enter a name for the suggestion.'**
  String get enterSuggestionName;

  /// No description provided for @invalidCharacters.
  ///
  /// In en, this message translates to:
  /// **'Invalid characters'**
  String get invalidCharacters;

  /// No description provided for @removeSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Remove Suggestion'**
  String get removeSuggestion;

  /// No description provided for @removeSuggestionDescription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this suggestion?'**
  String get removeSuggestionDescription;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @resetSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Reset Suggestions'**
  String get resetSuggestions;

  /// No description provided for @resetSuggestionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset the suggestion list?'**
  String get resetSuggestionsDescription;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @advancedSuggestionAdded.
  ///
  /// In en, this message translates to:
  /// **'Suggestion added successfully'**
  String get advancedSuggestionAdded;

  /// No description provided for @advancedSuggestionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add suggestion'**
  String get advancedSuggestionFailed;

  /// No description provided for @deleteSuggestionConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the suggestion \"{label}\"?'**
  String deleteSuggestionConfirmation(Object label);

  /// No description provided for @suggestionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Suggestion deleted successfully'**
  String get suggestionDeleted;

  /// No description provided for @suggestionDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete suggestion'**
  String get suggestionDeleteFailed;

  /// No description provided for @resetSuggestionsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset the suggestions?'**
  String get resetSuggestionsConfirm;

  /// No description provided for @suggestionsResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'All suggestions have been reset successfully'**
  String get suggestionsResetSuccess;

  /// No description provided for @suggestionsResetFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset suggestions. Please try again'**
  String get suggestionsResetFailed;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @sqlCode.
  ///
  /// In en, this message translates to:
  /// **'SQL Code'**
  String get sqlCode;

  /// No description provided for @selectableTextOptional.
  ///
  /// In en, this message translates to:
  /// **'Selectable Text (optional)'**
  String get selectableTextOptional;

  /// No description provided for @selectableTextHint.
  ///
  /// In en, this message translates to:
  /// **'Part of SQL to auto-select for user replacement'**
  String get selectableTextHint;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @updateSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Update Suggestion'**
  String get updateSuggestion;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @updateSuggestionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Suggestion updated successfully'**
  String get updateSuggestionSuccess;

  /// No description provided for @updateSuggestionFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to update suggestion'**
  String get updateSuggestionFail;

  /// No description provided for @editSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Edit suggestion'**
  String get editSuggestion;

  /// No description provided for @deleteSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Delete suggestion'**
  String get deleteSuggestion;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @exitScreen.
  ///
  /// In en, this message translates to:
  /// **'Exit screen'**
  String get exitScreen;

  /// No description provided for @startupFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not start SQL Studio'**
  String get startupFailedTitle;

  /// No description provided for @startupFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while loading your data. Try again, or clear the app data if the problem persists.'**
  String get startupFailedMessage;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @clearAppData.
  ///
  /// In en, this message translates to:
  /// **'Clear app data'**
  String get clearAppData;

  /// No description provided for @clearAppDataConfirmation.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes every database and setting stored on this device. This action cannot be undone.'**
  String get clearAppDataConfirmation;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get unexpectedError;

  /// No description provided for @tableRowsRange.
  ///
  /// In en, this message translates to:
  /// **'{start}-{end} of {total}'**
  String tableRowsRange(int start, int end, int total);

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @clearField.
  ///
  /// In en, this message translates to:
  /// **'Clear field'**
  String get clearField;

  /// No description provided for @previousPage.
  ///
  /// In en, this message translates to:
  /// **'Previous page'**
  String get previousPage;

  /// No description provided for @nextPage.
  ///
  /// In en, this message translates to:
  /// **'Next page'**
  String get nextPage;

  /// No description provided for @zoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom in'**
  String get zoomIn;

  /// No description provided for @zoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get zoomOut;

  /// No description provided for @resetZoom.
  ///
  /// In en, this message translates to:
  /// **'Reset zoom'**
  String get resetZoom;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @failedToSaveWorkspaceLayout.
  ///
  /// In en, this message translates to:
  /// **'Failed to save workspace layout. Please try again.'**
  String get failedToSaveWorkspaceLayout;

  /// No description provided for @databaseCreationError.
  ///
  /// In en, this message translates to:
  /// **'Could not create the database \"{databaseName}\".'**
  String databaseCreationError(Object databaseName);

  /// No description provided for @fetchDatabasesError.
  ///
  /// In en, this message translates to:
  /// **'Could not fetch the created databases.'**
  String get fetchDatabasesError;

  /// No description provided for @checkDatabaseExistsError.
  ///
  /// In en, this message translates to:
  /// **'Unable to check if the database already exists.'**
  String get checkDatabaseExistsError;

  /// No description provided for @deleteDatabaseError.
  ///
  /// In en, this message translates to:
  /// **'Unable to delete the database \"{databaseName}\".'**
  String deleteDatabaseError(Object databaseName);

  /// No description provided for @noRecordDeleted.
  ///
  /// In en, this message translates to:
  /// **'No record was deleted'**
  String get noRecordDeleted;

  /// No description provided for @toggleDatabaseFavoriteError.
  ///
  /// In en, this message translates to:
  /// **'Unable to change the favorite status of the database \"{databaseName}\".'**
  String toggleDatabaseFavoriteError(Object databaseName);

  /// No description provided for @unableToClear.
  ///
  /// In en, this message translates to:
  /// **'Unable to clear databases'**
  String get unableToClear;

  /// No description provided for @failedToGetAppVersion.
  ///
  /// In en, this message translates to:
  /// **'Failed to get app version'**
  String get failedToGetAppVersion;

  /// No description provided for @sqlExecutionError.
  ///
  /// In en, this message translates to:
  /// **'SQL execution error: {error}'**
  String sqlExecutionError(Object error);

  /// No description provided for @noDatabaseSelected.
  ///
  /// In en, this message translates to:
  /// **'No database selected'**
  String get noDatabaseSelected;

  /// No description provided for @failedToLoadSqlSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SQL suggestions'**
  String get failedToLoadSqlSuggestions;

  /// No description provided for @failedToSaveSqlSuggestionsSettings.
  ///
  /// In en, this message translates to:
  /// **'Failed to save SQL suggestions settings'**
  String get failedToSaveSqlSuggestionsSettings;

  /// No description provided for @failedToLoadAdvancedSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Failed to load advanced suggestions'**
  String get failedToLoadAdvancedSuggestions;

  /// No description provided for @failedToAddAdvancedSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Failed to add advanced suggestion'**
  String get failedToAddAdvancedSuggestion;

  /// No description provided for @failedToUpdateAdvancedSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Failed to update advanced suggestion'**
  String get failedToUpdateAdvancedSuggestion;

  /// No description provided for @failedToRemoveAdvancedSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove advanced suggestion'**
  String get failedToRemoveAdvancedSuggestion;

  /// No description provided for @failedToSaveAllAdvancedSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Failed to save all advanced suggestions'**
  String get failedToSaveAllAdvancedSuggestions;

  /// No description provided for @failedToReorderAdvancedSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Failed to reorder advanced suggestions'**
  String get failedToReorderAdvancedSuggestions;

  /// No description provided for @failedToResetAdvancedSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset advanced suggestions'**
  String get failedToResetAdvancedSuggestions;

  /// No description provided for @failedToLoadBasicSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Failed to load basic suggestions'**
  String get failedToLoadBasicSuggestions;

  /// No description provided for @failedToAddBasicSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Failed to add basic suggestion'**
  String get failedToAddBasicSuggestion;

  /// No description provided for @failedToUpdateBasicSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Failed to update basic suggestions'**
  String get failedToUpdateBasicSuggestions;

  /// No description provided for @failedToRemoveBasicSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove basic suggestion'**
  String get failedToRemoveBasicSuggestion;

  /// No description provided for @failedToResetBasicSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset basic suggestions'**
  String get failedToResetBasicSuggestions;

  /// No description provided for @failedToLoadSqlFiles.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SQL files: {error}'**
  String failedToLoadSqlFiles(Object error);

  /// No description provided for @failedToExecuteSql.
  ///
  /// In en, this message translates to:
  /// **'Failed to execute SQL for \"{dbName}\": {error}'**
  String failedToExecuteSql(Object dbName, Object error);

  /// No description provided for @databaseResetSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Database reset successfully'**
  String get databaseResetSuccessfully;

  /// No description provided for @failedToLoadDatabaseStructure.
  ///
  /// In en, this message translates to:
  /// **'Could not load the database structure.'**
  String get failedToLoadDatabaseStructure;

  /// No description provided for @databaseCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Database created successfully'**
  String get databaseCreatedSuccessfully;

  /// No description provided for @databaseDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Database deleted successfully'**
  String get databaseDeletedSuccessfully;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @createDatabase.
  ///
  /// In en, this message translates to:
  /// **'Create Database'**
  String get createDatabase;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @pleaseEnterLabel.
  ///
  /// In en, this message translates to:
  /// **'Please enter a label'**
  String get pleaseEnterLabel;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get pleaseEnterName;

  /// No description provided for @invalidCharactersDetected.
  ///
  /// In en, this message translates to:
  /// **'Invalid characters detected'**
  String get invalidCharactersDetected;

  /// No description provided for @databaseAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Database \"{name}\" already exists'**
  String databaseAlreadyExists(Object name);

  /// No description provided for @languageUpdated.
  ///
  /// In en, this message translates to:
  /// **'Language updated to {lang}'**
  String languageUpdated(Object lang);

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @theDatabaseIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'The database is empty'**
  String get theDatabaseIsEmpty;

  /// No description provided for @noDatabasesYet.
  ///
  /// In en, this message translates to:
  /// **'No databases yet'**
  String get noDatabasesYet;

  /// No description provided for @noDatabasesFound.
  ///
  /// In en, this message translates to:
  /// **'No databases found'**
  String get noDatabasesFound;

  /// No description provided for @noSuggestionsYet.
  ///
  /// In en, this message translates to:
  /// **'No suggestions yet'**
  String get noSuggestionsYet;

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle Theme'**
  String get toggleTheme;

  /// No description provided for @screenNotFound.
  ///
  /// In en, this message translates to:
  /// **'Screen Not Found'**
  String get screenNotFound;

  /// No description provided for @screenNotFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'The screen you are looking for does not exist or has been moved.'**
  String get screenNotFoundDescription;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get goHome;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @thisFieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get thisFieldIsRequired;

  /// No description provided for @sortOrderSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Sort order saved successfully'**
  String get sortOrderSavedSuccessfully;

  /// No description provided for @failedToSaveSortOrder.
  ///
  /// In en, this message translates to:
  /// **'Failed to save sort order'**
  String get failedToSaveSortOrder;

  /// No description provided for @deleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Delete executed successfully. {count} rows affected.'**
  String deleteSuccess(Object count);

  /// No description provided for @updateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Update executed successfully. {count} rows affected.'**
  String updateSuccess(Object count);

  /// No description provided for @insertSuccess.
  ///
  /// In en, this message translates to:
  /// **'Insert executed successfully. {count} rows affected.'**
  String insertSuccess(Object count);

  /// No description provided for @statementSuccess.
  ///
  /// In en, this message translates to:
  /// **'Statement executed successfully.'**
  String get statementSuccess;

  /// No description provided for @loadLastSql.
  ///
  /// In en, this message translates to:
  /// **'Load Last SQL'**
  String get loadLastSql;

  /// No description provided for @shareSql.
  ///
  /// In en, this message translates to:
  /// **'Share query'**
  String get shareSql;

  /// No description provided for @downloadSql.
  ///
  /// In en, this message translates to:
  /// **'Download query'**
  String get downloadSql;

  /// No description provided for @nothingToShare.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to share'**
  String get nothingToShare;

  /// No description provided for @sqlSharedSuccess.
  ///
  /// In en, this message translates to:
  /// **'SQL shared successfully'**
  String get sqlSharedSuccess;

  /// No description provided for @copySql.
  ///
  /// In en, this message translates to:
  /// **'Copy query'**
  String get copySql;

  /// No description provided for @nothingToCopy.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to copy'**
  String get nothingToCopy;

  /// No description provided for @sqlCopied.
  ///
  /// In en, this message translates to:
  /// **'SQL copied to clipboard'**
  String get sqlCopied;

  /// No description provided for @currentQuerySection.
  ///
  /// In en, this message translates to:
  /// **'Current query'**
  String get currentQuerySection;

  /// No description provided for @databaseSection.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get databaseSection;

  /// No description provided for @nothingToDownload.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to download'**
  String get nothingToDownload;

  /// No description provided for @sqlDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Query saved as a .sql file'**
  String get sqlDownloaded;

  /// No description provided for @nothingToLoad.
  ///
  /// In en, this message translates to:
  /// **'No previous query to load'**
  String get nothingToLoad;

  /// No description provided for @lastSqlLoaded.
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
