import 'package:app/localization_service.dart';
import 'package:app/main.dart';
import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class StyleWidget extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  StyleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        // confineInSafeArea: true,
        backgroundColor: MyTheme.offWhiteColor, // Optional background color
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        decoration: NavBarDecoration(boxShadow: [
          BoxShadow(
            color: MyTheme.shadowColor,
            blurRadius: 10,
            spreadRadius: 2,
          )
        ]),
        stateManagement: true,
        navBarStyle: NavBarStyle.style15, // Choose the style you like
      ),
      // body: ,
    );
  }
}

List<Widget> _buildScreens() {
  return [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen3(),
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
      activeColorSecondary: MyTheme.whiteColor,
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
