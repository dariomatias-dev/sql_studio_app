import 'package:sql_studio/src/shared/models/default_database_model.dart';

const defaultDatabases = <DefaultDatabaseModel>[
  // 1 table
  DefaultDatabaseModel(
    name: 'to_do_list',
    label: 'TodoList',
    description: 'Simple task management database',
    tables: <String>['tasks'],
  ),

  // 2 tables
  DefaultDatabaseModel(
    name: 'contacts',
    label: 'Contacts',
    description: 'Contacts and groups database',
    tables: <String>['groups', 'contacts'],
  ),

  // 3 tables
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

  // 4 tables
  DefaultDatabaseModel(
    name: 'car_rental',
    label: 'CarRental',
    description: 'Car rental management database',
    tables: <String>['cars', 'customers', 'rentals', 'payments'],
  ),
  DefaultDatabaseModel(
    name: 'restaurant',
    label: 'Restaurant',
    description: 'Restaurant orders and menu items database',
    tables: <String>['customers', 'menu_items', 'orders', 'order_items'],
  ),
  DefaultDatabaseModel(
    name: 'hr_payroll',
    label: 'HR Payroll',
    description:
        'Company departments, job positions, employees, and salary history',
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
    label: 'Logistics',
    description: 'Packages, drivers, deliveries, and status history database',
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
    label: 'Pharmacy',
    description: 'Pharmacy inventory, suppliers, customers, and sales database',
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
    label: 'School',
    description:
        'School management database with students, teachers, classes, enrollments, and grades',
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
    label: 'Social Network',
    description:
        'Social media platform with users, posts, likes, comments, and followers',
    tables: <String>['users', 'followers', 'posts', 'comments', 'likes'],
  ),

  // 6 tables
  DefaultDatabaseModel(
    name: 'hotel',
    label: 'Hotel',
    description:
        'Hotel reservations, rooms, payments, employees, and services database',
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
    description:
        'Banking system with accounts, transactions, loans, and employees',
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
    label: 'ECommerce',
    description: 'Online store with products, orders, carts, and reviews',
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
