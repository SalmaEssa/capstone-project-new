import 'package:axon/UI/home/discover/discover_screen.dart';
import 'package:axon/UI/home/settings_screen.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _tabController =
        PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      controller: _tabController,
      screens: [
        DiscoverScreen(),
        Scaffold(),
        Scaffold(),
        Scaffold(),
        SettingsScreen(),
      ],
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 350),
      ),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: AppColors.white,
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return <PersistentBottomNavBarItem>[
      _buildNavBarItem(CodeStrings.homeIcon),
      _buildNavBarItem(CodeStrings.fileIcon),
      _buildNavBarItem(CodeStrings.qrIcon),
      _buildNavBarItem(CodeStrings.bellIcon),
      _buildNavBarItem(CodeStrings.userIcon),
    ];
  }

  PersistentBottomNavBarItem _buildNavBarItem(String icon) {
    return PersistentBottomNavBarItem(
      contentPadding: 1,
      icon: Image.asset(icon),
      activeColor: AppColors.greenAccent,
      inactiveColor: AppColors.grey,
    );
  }
}
