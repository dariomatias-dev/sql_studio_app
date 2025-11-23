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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt')
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

  /// No description provided for @schemaCopied.
  ///
  /// In en, this message translates to:
  /// **'Schema copied!'**
  String get schemaCopied;

  /// No description provided for @seedCopied.
  ///
  /// In en, this message translates to:
  /// **'Seed copied!'**
  String get seedCopied;

  /// No description provided for @schemaAndSeedCopied.
  ///
  /// In en, this message translates to:
  /// **'Schema and Seed copied!'**
  String get schemaAndSeedCopied;

  /// No description provided for @viewStructure.
  ///
  /// In en, this message translates to:
  /// **'View Structure'**
  String get viewStructure;

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
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
