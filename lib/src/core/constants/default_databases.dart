import 'package:sql_studio/src/shared/models/default_database_model.dart';

const defaultDatabases = <DefaultDatabaseModel>[
  // 1 table
  DefaultDatabaseModel(
    name: 'to_do_list',
    labelKey: 'toDoListLabel',
    descriptionKey: 'toDoListDescription',
    tables: <String>['tasks'],
  ),

  // 2 tables
  DefaultDatabaseModel(
    name: 'contacts',
    labelKey: 'contactsLabel',
    descriptionKey: 'contactsDescription',
    tables: <String>['groups', 'contacts'],
  ),

  // 3 tables
  DefaultDatabaseModel(
    name: 'library',
    labelKey: 'libraryLabel',
    descriptionKey: 'libraryDescription',
    tables: <String>['books', 'members', 'loans'],
  ),
  DefaultDatabaseModel(
    name: 'fitness_club',
    labelKey: 'fitnessClubLabel',
    descriptionKey: 'fitnessClubDescription',
    tables: <String>['members', 'plans', 'subscriptions'],
  ),

  // 4 tables
  DefaultDatabaseModel(
    name: 'car_rental',
    labelKey: 'carRentalLabel',
    descriptionKey: 'carRentalDescription',
    tables: <String>['cars', 'customers', 'rentals', 'payments'],
  ),
  DefaultDatabaseModel(
    name: 'restaurant',
    labelKey: 'restaurantLabel',
    descriptionKey: 'restaurantDescription',
    tables: <String>['customers', 'menu_items', 'orders', 'order_items'],
  ),
  DefaultDatabaseModel(
    name: 'hr_payroll',
    labelKey: 'hrPayrollLabel',
    descriptionKey: 'hrPayrollDescription',
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
    labelKey: 'logisticsLabel',
    descriptionKey: 'logisticsDescription',
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
    labelKey: 'pharmacyLabel',
    descriptionKey: 'pharmacyDescription',
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
    labelKey: 'schoolLabel',
    descriptionKey: 'schoolDescription',
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
    labelKey: 'socialNetworkLabel',
    descriptionKey: 'socialNetworkDescription',
    tables: <String>['users', 'followers', 'posts', 'comments', 'likes'],
  ),

  // 6 tables
  DefaultDatabaseModel(
    name: 'hotel',
    labelKey: 'hotelLabel',
    descriptionKey: 'hotelDescription',
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
    labelKey: 'bankingLabel',
    descriptionKey: 'bankingDescription',
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
    labelKey: 'eCommerceLabel',
    descriptionKey: 'eCommerceDescription',
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
