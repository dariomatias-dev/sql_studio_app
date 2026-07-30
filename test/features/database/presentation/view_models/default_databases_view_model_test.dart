import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/constants/default_databases.dart';
import 'package:sql_studio/src/features/database/presentation/providers.dart';

void main() {
  String resolveLabel(dynamic key) => (key as Enum).name;

  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  test('filtered returns every default database with no filter set', () {
    final viewModel = container.read(
      defaultDatabasesViewModelProvider.notifier,
    );

    final filtered = viewModel.filtered(resolveLabel);

    expect(filtered, defaultDatabases);
  });

  test(
    'filtered matches databases whose resolved label contains the filter, '
    'case-insensitively',
    () {
      final viewModel = container.read(
        defaultDatabasesViewModelProvider.notifier,
      );
      final target = defaultDatabases.first;
      final query = resolveLabel(target.labelKey).toUpperCase();

      final filtered = (viewModel..setFilter(query)).filtered(resolveLabel);

      expect(filtered, [target]);
    },
  );

  test('filtered returns no databases when nothing matches', () {
    final viewModel = container.read(
      defaultDatabasesViewModelProvider.notifier,
    );

    final filtered = (viewModel..setFilter('no-database-has-this-label'))
        .filtered(resolveLabel);

    expect(filtered, isEmpty);
  });

  test('setFilter updates the state filter', () {
    final viewModel = container.read(
      defaultDatabasesViewModelProvider.notifier,
    )..setFilter('library');

    expect(viewModel.state.filter, 'library');
  });

  test('setFilter does nothing when the filter is unchanged', () {
    final viewModel = container.read(
      defaultDatabasesViewModelProvider.notifier,
    )..setFilter('library');
    final stateAfterFirstSet = viewModel.state;

    viewModel.setFilter('library');

    expect(viewModel.state, same(stateAfterFirstSet));
  });
}
