import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/AccessToContactController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/controller/bottom_nav_controller.dart';

class BottomNavigationWrapper extends StatefulWidget {
  BottomNavigationWrapper({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWrapper> createState() =>
      _BottomNavigationWrapperState();
}

class _BottomNavigationWrapperState extends State<BottomNavigationWrapper> {
  final BottomNavController bottomNavController =
      Get.put(BottomNavController());
  final AccessToContactController accessToContactController =
      Get.put(AccessToContactController());

  // @override
  // void initState() {
  //   accessToContactController.getContactsFromFirebase().then((value) {
  //     accessToContactController.firebaseContacts.value = value;
  //     accessToContactController
  //         .uploadToFirebase(accessToContactController.uploadContacts);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 70.v,
        color: PrimaryColors().lightWhite,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 10.v,
        child: Container(
          color: Colors.transparent,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomAppBarItem(context,
                    icon: Icons.call, page: 0, label: "Calls"),
                _bottomAppBarItem(context,
                    icon: bottomNavController.currentPage.value == 1
                        ? Icons.analytics_rounded
                        : Icons.analytics_outlined,
                    page: 1,
                    label: "Analytics"),
                _bottomAppBarItem(context,
                    icon: Icons.workspace_premium, page: 2, label: "Premium"),
                _bottomAppBarItem(context,
                    icon: bottomNavController.currentPage.value == 3
                        ? Icons.contact_page
                        : Icons.contact_page_outlined,
                    page: 3,
                    label: "Contacts"),
                _bottomAppBarItem(context,
                    icon: Icons.menu_rounded, page: 4, label: "More"),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: bottomNavController.pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: bottomNavController.animateToTab,
        children: bottomNavController.pages,
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return InkWell(
      onTap: () => bottomNavController.goToTab(page),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: bottomNavController.currentPage == page
                ? PrimaryColors().purple
                : Colors.black,
            size: 20.v,
          ),
          Text(
            label,
            style: TextStyle(
                color: bottomNavController.currentPage == page
                    ? PrimaryColors().purple
                    : Colors.black,
                fontSize: 13,
                fontWeight: bottomNavController.currentPage == page
                    ? FontWeight.w600
                    : null),
          ),
        ],
      ),
    );
  }
}
