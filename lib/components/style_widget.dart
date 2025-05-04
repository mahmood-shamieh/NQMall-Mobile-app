import 'package:app/controllers/home_screen_controller.dart';
import 'package:app/controllers/search_screen_controller.dart';
import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/search_screen.dart';
import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class StyleWidget extends StatelessWidget {
  final PersistentTabController controller =
      getIt.get<PersistentTabController>();
  StyleWidget({
    super.key,
  });

  void restTheScreenState(int index) {
    HomeScreenController homeScreenController;
    SearchScreenController searchScreenController;
    try {
      switch (index) {
        case 0:
          homeScreenController = Get.find<HomeScreenController>();
          homeScreenController.onInit();
          break;
        case 2:
          searchScreenController = Get.find<SearchScreenController>();
          searchScreenController.onInit();
          break;
        default:
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        onItemSelected: (value) {
          restTheScreenState(value);
        },
        // popAllScreensOnTapOfSelectedTab: true,
        // confineInSafeArea: true,
        backgroundColor: MyTheme.offWhiteColor, // Optional background color
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        decoration: const NavBarDecoration(boxShadow: [
          BoxShadow(
            color: MyTheme.shadowColor,
            blurRadius: 10,
            spreadRadius: 2,
          )
        ]),
        stateManagement: false,
        navBarStyle: NavBarStyle.style15, // Choose the style you like
      ),
      // body: ,
    );
  }
}

List<Widget> _buildScreens() {
  return [
    HomeScreen(),
    Screen2(),
    SearchScreen(
      key: UniqueKey(),
    ),
    ProfileScreen(),
    Screen3(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: const Icon(FontAwesomeIcons.house)),
      title: 'bottomBar.home'.tr,
      activeColorPrimary: MyTheme.mainColor,
      inactiveColorPrimary: MyTheme.textColor,
      textStyle: MyTheme.getButtonStyle(fontSize: MyTheme.textSizeXXSmall),
    ),
    PersistentBottomNavBarItem(
      icon: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: const Icon(FontAwesomeIcons.gift)),
      title: 'bottomBar.offers'.tr,
      activeColorPrimary: MyTheme.mainColor,
      inactiveColorPrimary: MyTheme.textColor,
      textStyle: MyTheme.getButtonStyle(fontSize: MyTheme.textSizeXXSmall),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(FontAwesomeIcons.search),
      title: 'bottomBar.search'.tr,
      activeColorPrimary: MyTheme.mainColor,
      activeColorSecondary: MyTheme.secondaryColor,
      inactiveColorPrimary: MyTheme.textColor,
      textStyle: MyTheme.getButtonStyle(fontSize: MyTheme.textSizeXXSmall),
    ),
    PersistentBottomNavBarItem(
      icon: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: const Icon(FontAwesomeIcons.person)),
      title: 'bottomBar.profile'.tr,
      activeColorPrimary: MyTheme.mainColor,
      inactiveColorPrimary: MyTheme.textColor,
      textStyle: MyTheme.getButtonStyle(fontSize: MyTheme.textSizeXXSmall),
    ),
    PersistentBottomNavBarItem(
      icon: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: const Icon(FontAwesomeIcons.boxes)),
      title: 'bottomBar.categories'.tr,
      activeColorPrimary: MyTheme.mainColor,
      inactiveColorPrimary: MyTheme.textColor,
      textStyle: MyTheme.getButtonStyle(fontSize: MyTheme.textSizeXXSmall),
    ),
  ];
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Screen')),
      body: Center(child: Text('Search for something!')),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Screen')),
      body: Center(child: Text('Your Profile Information')),
    );
  }
}
