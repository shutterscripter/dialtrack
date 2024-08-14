import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mithilesh_s_application1/controller/bottom_nav_controller.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/PageNavigator.dart';
import 'package:mithilesh_s_application1/widgets/custom_setting_tile.dart';
import 'package:mithilesh_s_application1/widgets/custom_social_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //add twitter image form image constant
                        CustomSocialCard(
                          assetName: ImageConstant.imgTwitter,
                          toDoFunction: () {},
                        ),
                        CustomSocialCard(
                          assetName: ImageConstant.imgInstagram,
                          toDoFunction: () {},
                        ),
                        CustomSocialCard(
                          assetName: ImageConstant.imgFacebook,
                          toDoFunction: () {},
                        ),
                      ],
                    ),
                    auth.currentUser?.uid != null
                        ? IconButton(
                            onPressed: () async {
                              /// logout from the app
                              await auth.signOut();
                              Get.offAllNamed('/googleAuth');
                            },
                            icon: Icon(
                              Icons.logout_rounded,
                              color: Colors.black,
                            ),
                          )
                        : Container(),
                  ],
                ),

                SizedBox(
                  height: 40,
                ),
                // settings starts here
                SizedBox(
                  height: 10,
                ),
                CustomSettingTile(
                  title: "Automate Calls",
                  assetName: ImageConstant.allCalls,
                  toDoFunction: () {
                    // Get.to(AutoCallDialerMain());
                    // Get.to(PageNavigator());
                    bottomNavController
                        .animateToTab(bottomNavController.pages.length - 1);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomSettingTile(
                  title: "Blogs",
                  assetName: ImageConstant.imgFolder,
                  toDoFunction: () => Get.toNamed('/blogs'),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomSettingTile(
                  title: "Compare",
                  assetName: ImageConstant.imgMinimize,
                  toDoFunction: () => Get.toNamed('/compare'),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomSettingTile(
                  title: "Settings",
                  assetName: ImageConstant.imgSettings,
                  toDoFunction: () => Get.toNamed('/settings'),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomSettingTile(
                  title: "Help & Support",
                  assetName: ImageConstant.imgQuestion,
                  toDoFunction: () => Get.toNamed('/help'),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomSettingTile(
                  title: "Invite Friends",
                  assetName: ImageConstant.imgUserOnprimarycontainer,
                  toDoFunction: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                CustomSettingTile(
                  title: "Rate App",
                  assetName: ImageConstant.imgMail,
                  toDoFunction: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                CustomSettingTile(
                  title: "About App",
                  assetName: ImageConstant.imgInfo,
                  toDoFunction: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                // settings ends here

                TextButton(
                  onPressed: () async {
                    //open link in browser "https://codezaza.com/dialtrack-privacy-policy/"
                    final Uri _url = Uri.parse(
                        'https://codezaza.com/dialtrack-privacy-policy/');
                    await launchUrl(_url);
                  },
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500),
                  ),
                ),

                SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      "If You want to delete the Account or Data then please contact us at",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final Uri _url = Uri.parse(
                            'https://codezaza.com/dialtrack-delete-info/');
                        await launchUrl(_url);
                      },
                      child: Text(
                        "https://codezaza.com/dialtrack-delete-info/",
                        style: TextStyle(
                            color: PrimaryColors().purple,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
