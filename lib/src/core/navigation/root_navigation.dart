import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sql_studio/src/core/navigation/widgets/root_drawer/drawer_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_nav_bar_widget.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_swipe_wrapper_widget.dart';

import 'package:sql_studio/src/notifiers/navigation_notifier.dart';

import 'package:sql_studio/src/screens/databases/databases_screen.dart';
import 'package:sql_studio/src/screens/home/home_screen.dart';
import 'package:sql_studio/src/screens/settings/settings_screen.dart';

/// Root scaffold hosting the app's drawer, swipeable pages, and bottom
/// navigation bar.
class RootNavigation extends StatefulWidget {
  /// Creates the root navigation scaffold.
  const RootNavigation({super.key});

  @override
  State<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  late final PageController _pageController;
  late final NavigationNotifier _notifier;

  List<Widget> get _screens => <Widget>[
    const HomeScreen(),
    const DatabasesScreen(),
    const SettingsScreen(),
  ];

  void _onIndexChanged() {
    if (!_pageController.hasClients) return;

    final page = _notifier.index;

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
    _notifier = context.read<NavigationNotifier>();

    _notifier.addListener(_onIndexChanged);
  }

  @override
  void dispose() {
    _notifier.removeListener(_onIndexChanged);
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<NavigationNotifier>();

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
              notifier: notifier,
              pageController: _pageController,
              child: PageView(
                controller: _pageController,
                onPageChanged: notifier.setIndex,
                children: _screens,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: RootSwipeWrapperWidget(
                notifier: notifier,
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
