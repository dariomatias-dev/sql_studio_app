import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/navigation/widgets/root_drawer/drawer_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_nav_bar_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_swipe_wrapper_widget.dart';
import 'package:sql_studio/src/core/providers/navigation_provider.dart';

import 'package:sql_studio/src/screens/databases/databases_screen.dart';
import 'package:sql_studio/src/screens/home/home_screen.dart';
import 'package:sql_studio/src/screens/settings/settings_screen.dart';

/// Root scaffold hosting the app's drawer, swipeable pages, and bottom
/// navigation bar.
class RootNavigation extends ConsumerStatefulWidget {
  /// Creates the root navigation scaffold.
  const RootNavigation({super.key});

  @override
  ConsumerState<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends ConsumerState<RootNavigation> {
  late final PageController _pageController;
  late final ProviderSubscription<int> _indexSubscription;

  List<Widget> get _screens => <Widget>[
    const HomeScreen(),
    const DatabasesScreen(),
    const SettingsScreen(),
  ];

  void _onIndexChanged(int? previous, int page) {
    if (!_pageController.hasClients) return;

    if (_pageController.page?.round() == page) return;

    unawaited(
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutQuart,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _indexSubscription = ref.listenManual(
      navigationViewModelProvider,
      _onIndexChanged,
    );
  }

  @override
  void dispose() {
    _indexSubscription.close();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(navigationViewModelProvider.notifier);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black, size: 22),
          shape: const Border(
            bottom: BorderSide(color: Color(0xFFF2F2F2)),
          ),
        ),
        drawer: const RootDrawerWidget(),
        body: Stack(
          children: <Widget>[
            RootSwipeWrapperWidget(
              pageController: _pageController,
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => notifier.index = page,
                children: _screens,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: RootSwipeWrapperWidget(
                pageController: _pageController,
                child: RootNavBarWidget(pageController: _pageController),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
