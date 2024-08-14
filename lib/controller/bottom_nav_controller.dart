import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/PageNavigator.dart';
import 'package:mithilesh_s_application1/presentation/CallPage/CallsScreen.dart';
import 'package:mithilesh_s_application1/presentation/Premium/PremiumMain.dart';
import 'package:mithilesh_s_application1/presentation/analytics_screen/AnalyticsScreen.dart';
import 'package:mithilesh_s_application1/presentation/contact/ContactScreen.dart';
import 'package:mithilesh_s_application1/presentation/more/more_screen.dart';

/// Bottom Navigation Controller for handling bottom navigation bar in the app
class BottomNavController extends GetxController {
  late PageController pageController;

  RxInt currentPage = 0.obs;
  RxBool isDarkTheme = false.obs;

  List<Widget> pages = [
    CallsScreen(),
    AnalyticsScreen(),
    PremiumMain(),
    ContactsScreen(),
    MoreScreen(),
    PageNavigator()
  ];

  ThemeMode get theme => Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  /// Switches the theme of the app
  void switchTheme(ThemeMode mode) {
    Get.changeThemeMode(mode);
  }

  /// Changes the current page of the app to the given page
  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }


  /// Animates to the given page
  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
