import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/AccessToContactController.dart';
import 'package:mithilesh_s_application1/core/utils/image_constant.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/widgets/custom_elevated_button.dart';
import 'package:mithilesh_s_application1/widgets/custom_image_view.dart';
import 'package:url_launcher/url_launcher.dart';

class AccessToContact extends StatefulWidget {
  const AccessToContact({Key? key}) : super(key: key);

  @override
  State<AccessToContact> createState() => _AccessToContactState();
}

class _AccessToContactState extends State<AccessToContact> {
  AccessToContactController accessToContactController =
      Get.put(AccessToContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRectangle343376x377,
              height: 350.v,
              margin: EdgeInsets.only(top: 50.v),
              radius: BorderRadius.circular(
                15.h,
              ),
            ),
            SizedBox(height: 50.h),
            Text(
              "ACCESS TO YOUR CONTACTS",
              style: TextStyle(
                fontSize: 20.v,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Callyzer needs to access your contracts to display respective names and analyse contact call data. Granting contact permission is mandatory as it supports core feature of Callyzer.",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12.v,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "We assure you that your contacts will not be uploaded to cloud server. we store the data within your device.",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12.v,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "If the contact is more than 3000, we run the process in backgound to avoid wait time.",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12.v,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: CustomElevatedButton(
                height: 55.v,
                onTap: () async {
                  await accessToContactController
                      .checkPermissionAndGetContacts();
                },
                text: "Let’s do it",
                buttonStyle: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // svg
                SvgPicture.asset(
                  ImageConstant.imgArrowdown,
                  height: 20.v,
                  width: 20.h,
                ),
                SizedBox(width: 5.h),
                Text(
                  "We are Safe!",
                  style: TextStyle(
                    fontSize: 14.v,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            TextButton(
              onPressed: () async {
                //open link in browser "https://codezaza.com/dialtrack-privacy-policy/"
                final Uri _url =
                    Uri.parse('https://codezaza.com/dialtrack-privacy-policy/');
                await launchUrl(_url);
              },
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 12.v,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
