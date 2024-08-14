import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/presentation/BottomNavigationbar/BottomNavigationWrapper.dart';
import 'package:mithilesh_s_application1/presentation/CallPage/CallPage.dart';
import 'package:mithilesh_s_application1/presentation/GoogleAuth/FirebaseAuthScreen.dart';
import 'package:mithilesh_s_application1/presentation/PrivacyPolicy.dart';
import 'package:mithilesh_s_application1/presentation/Singup_page/Signupscreen.dart';
import 'package:mithilesh_s_application1/presentation/access_to_contact/accesstocontact.dart';
import 'package:mithilesh_s_application1/presentation/access_your_call_history/acess_your_call_histo.dart';
import 'package:mithilesh_s_application1/presentation/analytics_screen/TopTenCallersList.dart';
import 'package:mithilesh_s_application1/presentation/analytics_screen/AnalyticsScreen.dart';
import 'package:mithilesh_s_application1/presentation/contact/ContactScreen.dart';
import 'package:mithilesh_s_application1/presentation/contact_sim/ConnectSimTwo.dart';
import 'package:mithilesh_s_application1/presentation/contact_sim/connect_sim.dart';
import 'package:mithilesh_s_application1/presentation/dialer/dialer_page.dart';
import 'package:mithilesh_s_application1/presentation/more/BlogsScreen.dart';
import 'package:mithilesh_s_application1/presentation/more/CompareScreen.dart';
import 'package:mithilesh_s_application1/presentation/more/HelpAndSupportScreen.dart';
import 'package:mithilesh_s_application1/presentation/more/SettingsScreen.dart';
import 'package:mithilesh_s_application1/presentation/more/more_screen.dart';
import 'package:mithilesh_s_application1/presentation/more/settings/LanguagesScreen.dart';
import 'package:mithilesh_s_application1/presentation/more/settings/SetDefaultScreen.dart';
import 'package:mithilesh_s_application1/presentation/more/settings/ThemeScreen.dart';
import 'package:mithilesh_s_application1/presentation/more/settings/TimeFormatScreen.dart';
import 'package:mithilesh_s_application1/presentation/set_default_phone_app/setdefaultphoneappscreen.dart';
import 'package:mithilesh_s_application1/presentation/verify_sim_number/CallLogList.dart';
import 'package:mithilesh_s_application1/presentation/verify_sim_number/simnumber.dart';

class AppRoutes {
  static const String splashscreen = '/splashscreen';
  static const String setDefaultPhoneAppScreen = '/setdefaultphoneappscreen';
  static const String signUpPage = '/signup_page';
  static const String homepage = '/homepage';
  static const String homescreen = '/homescreen';
  static const String dialer = '/dialer_page';
  static const String analyticsScreen = '/analytics_screen';
  static const String contactsScreen = '/contacts_screen';
  static const String navigationScreen = '/BottomNavigationWrapper';

  static Map<String, WidgetBuilder> routes = {
    setDefaultPhoneAppScreen: (context) => SetDefaultApp(),
    signUpPage: (context) => SignUpPage(),
    // homescreen: (context) => HomeScreen(),
    analyticsScreen: (context) => AnalyticsScreen(),
    dialer: (context) => PhoneDialer(),
    navigationScreen: (context) => BottomNavigationWrapper(),
  };

  /// Author: Jayesh Shinde
  /// Topic: GetX Routes

  final getPages = [
    GetPage(name: '/signup', page: () => SignUpPage()),
    GetPage(name: '/detDefaultApp', page: () => SetDefaultApp()),
    GetPage(name: '/accessToCallHistory', page: () => AccessYourCallHist()),
    GetPage(name: '/accessToContacts', page: () => AccessToContact()),
    GetPage(name: '/googleAuth', page:()=>FirebaseAuthScreen()),
    GetPage(name: '/connectSim', page: () => ConnectSim()),
    GetPage(name: '/connectSimTwo', page: () => ConnectSimTwo()),
    GetPage(name: '/verifySimNumber', page: () => SimNumber()),
    GetPage(name: '/verifyCallLogListOne', page: () => CallLogList()),

    GetPage(name: '/home', page: () => BottomNavigationWrapper()),

    /// sub pages in home screen =>
    GetPage(name: '/homepage', page: () => CallPage()),
    GetPage(name: '/analytics', page: () => AnalyticsScreen()),
    GetPage(name: '/dialer', page: () => PhoneDialer()),
    GetPage(name: '/contacts', page: () => ContactsScreen()),
    GetPage(name: '/more', page: () => MoreScreen()),

    /// sub pages in more screen =>
    GetPage(name: '/blogs', page: () => BlogsScreen()),
    GetPage(name: '/settings', page: () => SettingsScreen()),
    GetPage(name: '/compare', page: () => CompareScreen()),
    GetPage(name: '/help', page: () => HelpAndSupportScreen()),

    /// sub pages in settings screen =>
    GetPage(name: '/theme', page: () => ThemeScreen()),
    GetPage(name: '/defaultScreen', page: () => SetDefaultScreen()),
    GetPage(name: '/languages', page: () => LanguagesScreen()),
    GetPage(name: '/timeFormat', page: () => TimeFormatScreen()),

    /// sub pages in analysis screen =>
    GetPage(name: '/topTenCallers', page: () => TopTenCallList()),

    ///privacy policy
    GetPage(name: '/privacyPolicy', page: () => PrivacyPolicy()),
  ];
}
