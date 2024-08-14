import 'package:flutter/material.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/presentation/CallPage/CallPage.dart';
import 'package:mithilesh_s_application1/presentation/analytics_screen/AnalyticsScreen.dart';
import 'package:mithilesh_s_application1/presentation/contact/ContactScreen.dart';
import 'package:mithilesh_s_application1/presentation/dialer/dialer_page.dart';
import 'package:mithilesh_s_application1/widgets/custom_bottom_bar.dart';


// ignore_for_file: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.homepage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
              pageBuilder: (ctx, ani, ani1) =>
                  getCurrentPage(routeSetting.name!),
              transitionDuration: Duration(seconds: 0)),
        ),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (BottomBarEnum type) {
            Navigator.pushNamed(
                navigatorKey.currentContext!, getCurrentRoute(type));
          },
        ),
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Callhistory:
        return AppRoutes.homepage;
      case BottomBarEnum.Analytics:
        return "/analytics_screen";
      case BottomBarEnum.Premium:
        return "/dialer_page";
      case BottomBarEnum.Contacts:
        return "/contacts_screen";
      case BottomBarEnum.More:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homepage:
        return CallPage();
      case AppRoutes.analyticsScreen:
        return AnalyticsScreen();
      case AppRoutes.contactsScreen:
        return ContactsScreen();
      case AppRoutes.dialer:
        return PhoneDialer();
      default:
        return DefaultWidget();
    }
  }
}
