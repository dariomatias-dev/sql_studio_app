import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_swipe_wrapper_widget.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';

void main() {
  testWidgets(
    'swiping the wrapped page view syncs the navigation index with the '
    'settled page',
    (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final pageController = PageController();
      addTearDown(pageController.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: RootSwipeWrapperWidget(
              pageController: pageController,
              child: PageView(
                controller: pageController,
                children: const <Widget>[
                  ColoredBox(color: Colors.red),
                  ColoredBox(color: Colors.green),
                  ColoredBox(color: Colors.blue),
                ],
              ),
            ),
          ),
        ),
      );

      expect(container.read(navigationViewModelProvider), 0);

      await tester.drag(find.byType(PageView), const Offset(-800, 0));
      await tester.pumpAndSettle();

      expect(container.read(navigationViewModelProvider), 1);
      expect(pageController.page?.round(), 1);
    },
  );

  testWidgets('does nothing when the page controller has no clients yet', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final pageController = PageController();
    addTearDown(pageController.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: RootSwipeWrapperWidget(
            pageController: pageController,
            child: const SingleChildScrollView(
              child: SizedBox(height: 2000),
            ),
          ),
        ),
      ),
    );

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();

    expect(container.read(navigationViewModelProvider), 0);
  });
}
