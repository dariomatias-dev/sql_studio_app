import 'package:sql_studio/src/shared/models/default_database_model.dart';

const defaultDatabases = <DefaultDatabaseModel>[
  DefaultDatabaseModel(
    name: 'to_do_list',
    label: 'TodoList',
    description: 'Simple task management database',
    tables: <String>['tasks'],
  ),
  DefaultDatabaseModel(
    name: 'contacts',
    label: 'Contacts',
    description: 'Contacts and groups database',
    tables: <String>['groups', 'contacts'],
  ),
  DefaultDatabaseModel(
    name: 'library',
    label: 'Library',
    description: 'Library with books, members, and loans',
    tables: <String>['books', 'members', 'loans'],
  ),
  DefaultDatabaseModel(
    name: 'fitness_club',
    label: 'FitnessClub',
    description: 'Gym members and subscriptions database',
    tables: <String>['members', 'plans', 'subscriptions'],
  ),
  DefaultDatabaseModel(
    name: 'restaurant',
    label: 'Restaurant',
    description: 'Restaurant orders and menu items database',
    tables: <String>['customers', 'menu_items', 'orders', 'order_items'],
  ),
  DefaultDatabaseModel(
    name: 'car_rental',
    label: 'CarRental',
    description: 'Car rental management database',
    tables: <String>['cars', 'customers', 'rentals', 'payments'],
  ),
  DefaultDatabaseModel(
    name: 'school',
    label: 'School',
    description: 'School management database',
    tables: <String>[
      'students',
      'teachers',
      'classes',
      'enrollments',
      'grades',
    ],
  ),
  DefaultDatabaseModel(
    name: 'pharmacy',
    label: 'Pharmacy',
    description: 'Pharmacy inventory and sales database',
    tables: <String>[
      'products',
      'suppliers',
      'customers',
      'sales',
      'sale_items',
    ],
  ),
  DefaultDatabaseModel(
    name: 'hotel',
    label: 'Hotel',
    description: 'Hotel reservations and payments database',
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
    label: 'Banking',
    description: 'Banking system with accounts and transactions',
    tables: <String>[
      'customers',
      'accounts',
      'transactions',
      'employees',
      'branches',
      'loans',
    ],
  ),
];
