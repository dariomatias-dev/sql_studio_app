import 'package:sql_studio/l10n/app_localizations.dart';

extension LocalizationExtension on AppLocalizations {
  static final Map<String, String Function(AppLocalizations)> _translations = {
    'toDoListLabel': (l) => l.toDoListLabel,
    'toDoListDescription': (l) => l.toDoListDescription,
    'contactsLabel': (l) => l.contactsLabel,
    'contactsDescription': (l) => l.contactsDescription,
    'libraryLabel': (l) => l.libraryLabel,
    'libraryDescription': (l) => l.libraryDescription,
    'fitnessClubLabel': (l) => l.fitnessClubLabel,
    'fitnessClubDescription': (l) => l.fitnessClubDescription,
    'carRentalLabel': (l) => l.carRentalLabel,
    'carRentalDescription': (l) => l.carRentalDescription,
    'restaurantLabel': (l) => l.restaurantLabel,
    'restaurantDescription': (l) => l.restaurantDescription,
    'hrPayrollLabel': (l) => l.hrPayrollLabel,
    'hrPayrollDescription': (l) => l.hrPayrollDescription,
    'logisticsLabel': (l) => l.logisticsLabel,
    'logisticsDescription': (l) => l.logisticsDescription,
    'pharmacyLabel': (l) => l.pharmacyLabel,
    'pharmacyDescription': (l) => l.pharmacyDescription,
    'schoolLabel': (l) => l.schoolLabel,
    'schoolDescription': (l) => l.schoolDescription,
    'socialNetworkLabel': (l) => l.socialNetworkLabel,
    'socialNetworkDescription': (l) => l.socialNetworkDescription,
    'hotelLabel': (l) => l.hotelLabel,
    'hotelDescription': (l) => l.hotelDescription,
    'bankingLabel': (l) => l.bankingLabel,
    'bankingDescription': (l) => l.bankingDescription,
    'eCommerceLabel': (l) => l.eCommerceLabel,
    'eCommerceDescription': (l) => l.eCommerceDescription,
  };

  String key(String k) => _translations[k]?.call(this) ?? k;
}
