import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/features/database/domain/entities/database_entity.dart';
import 'package:sql_studio/src/features/database/presentation/view_models/database_list_state.dart';

void main() {
  DatabaseEntity model(String name, {bool isFavorite = false}) =>
      DatabaseEntity(label: name, name: name, isFavorite: isFavorite);

  test('splits the databases by favorite, keeping their order', () {
    final state = DatabaseListState(
      databases: [
        model('todo', isFavorite: true),
        model('contacts'),
        model('library', isFavorite: true),
      ],
    );

    expect(state.favorites.map((db) => db.name), ['todo', 'library']);
    expect(state.others.map((db) => db.name), ['contacts']);
  });

  test('matches the filter case-insensitively on both lists', () {
    final state = DatabaseListState(
      databases: [
        model('todo_list', isFavorite: true),
        model('contacts'),
        model('todo_archive'),
      ],
      filter: 'TODO',
    );

    expect(state.favorites.map((db) => db.name), ['todo_list']);
    expect(state.others.map((db) => db.name), ['todo_archive']);
  });

  test('copyWith replaces only the given fields', () {
    final original = DatabaseListState(databases: [model('todo')]);

    final updated = original.copyWith(filter: 'x');

    expect(updated.databases, original.databases);
    expect(updated.filter, 'x');
    expect(updated.isLoading, original.isLoading);
  });
}
