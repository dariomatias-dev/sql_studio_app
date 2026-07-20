import 'package:sql_studio/src/core/database/default_database_model.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';

/// Built-in sample databases offered to users, ordered by table count.
const defaultDatabases = <DefaultDatabaseModel>[
  // 1 table
  DefaultDatabaseModel(
    name: 'to_do_list',
    labelKey: AppLocalizationsKey.toDoListLabel,
    descriptionKey: AppLocalizationsKey.toDoListDescription,
    tables: <String>['tasks'],
  ),

  // 2 tables
  DefaultDatabaseModel(
    name: 'contacts',
    labelKey: AppLocalizationsKey.contactsLabel,
    descriptionKey: AppLocalizationsKey.contactsDescription,
    tables: <String>['groups', 'contacts'],
  ),

  // 3 tables
  DefaultDatabaseModel(
    name: 'library',
    labelKey: AppLocalizationsKey.libraryLabel,
    descriptionKey: AppLocalizationsKey.libraryDescription,
    tables: <String>['books', 'members', 'loans'],
  ),
  DefaultDatabaseModel(
    name: 'fitness_club',
    labelKey: AppLocalizationsKey.fitnessClubLabel,
    descriptionKey: AppLocalizationsKey.fitnessClubDescription,
    tables: <String>['members', 'plans', 'subscriptions'],
  ),

  // 4 tables
  DefaultDatabaseModel(
    name: 'car_rental',
    labelKey: AppLocalizationsKey.carRentalLabel,
    descriptionKey: AppLocalizationsKey.carRentalDescription,
    tables: <String>['cars', 'customers', 'rentals', 'payments'],
  ),
  DefaultDatabaseModel(
    name: 'restaurant',
    labelKey: AppLocalizationsKey.restaurantLabel,
    descriptionKey: AppLocalizationsKey.restaurantDescription,
    tables: <String>['customers', 'menu_items', 'orders', 'order_items'],
  ),
  DefaultDatabaseModel(
    name: 'hr_payroll',
    labelKey: AppLocalizationsKey.hrPayrollLabel,
    descriptionKey: AppLocalizationsKey.hrPayrollDescription,
    tables: <String>[
      'departments',
      'job_positions',
      'employees',
      'salary_history',
    ],
  ),

  // 5 tables
  DefaultDatabaseModel(
    name: 'logistics',
    labelKey: AppLocalizationsKey.logisticsLabel,
    descriptionKey: AppLocalizationsKey.logisticsDescription,
    tables: <String>[
      'customers',
      'drivers',
      'packages',
      'deliveries',
      'status_history',
    ],
  ),
  DefaultDatabaseModel(
    name: 'pharmacy',
    labelKey: AppLocalizationsKey.pharmacyLabel,
    descriptionKey: AppLocalizationsKey.pharmacyDescription,
    tables: <String>[
      'products',
      'suppliers',
      'customers',
      'sales',
      'sale_items',
    ],
  ),
  DefaultDatabaseModel(
    name: 'school',
    labelKey: AppLocalizationsKey.schoolLabel,
    descriptionKey: AppLocalizationsKey.schoolDescription,
    tables: <String>[
      'students',
      'teachers',
      'classes',
      'enrollments',
      'grades',
    ],
  ),
  DefaultDatabaseModel(
    name: 'social_network',
    labelKey: AppLocalizationsKey.socialNetworkLabel,
    descriptionKey: AppLocalizationsKey.socialNetworkDescription,
    tables: <String>['users', 'followers', 'posts', 'comments', 'likes'],
  ),

  // 6 tables
  DefaultDatabaseModel(
    name: 'hotel',
    labelKey: AppLocalizationsKey.hotelLabel,
    descriptionKey: AppLocalizationsKey.hotelDescription,
    tables: <String>[
      'guests',
      'rooms',
      'reservations',
      'payments',
      'employees',
      'services',
    ],
  ),
  DefaultDatabaseModel(
    name: 'banking',
    labelKey: AppLocalizationsKey.bankingLabel,
    descriptionKey: AppLocalizationsKey.bankingDescription,
    tables: <String>[
      'customers',
      'accounts',
      'transactions',
      'employees',
      'branches',
      'loans',
    ],
  ),

  // 8 tables
  DefaultDatabaseModel(
    name: 'e_commerce',
    labelKey: AppLocalizationsKey.eCommerceLabel,
    descriptionKey: AppLocalizationsKey.eCommerceDescription,
    tables: <String>[
      'users',
      'categories',
      'products',
      'orders',
      'order_items',
      'reviews',
      'carts',
      'cart_items',
    ],
  ),
];
