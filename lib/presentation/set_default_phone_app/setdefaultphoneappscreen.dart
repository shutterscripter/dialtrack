import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/core/utils/image_constant.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/presentation/access_your_call_history/acess_your_call_histo.dart';
import 'package:mithilesh_s_application1/widgets/custom_elevated_button.dart';
import 'package:mithilesh_s_application1/widgets/custom_image_view.dart';
import 'package:open_settings/open_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class SetDefaultApp extends StatelessWidget {
  const SetDefaultApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 20.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle343,
                height: 350.v,
                margin: EdgeInsets.only(top: 100.v),
                radius: BorderRadius.circular(
                  15.h,
                ),
              ),
              SizedBox(height: 50.h),
              Text(
                "Set Default phone App",
                style: TextStyle(
                  fontSize: 20.v,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "By permitting, you accept to initiate calls through callyzer application dialer when using this application.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.v,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomElevatedButton(
                      height: 55.v,
                      onTap: () {
                        OpenSettings.openManageDefaultAppsSetting();
                      },
                      width: 150.h,
                      text: "Yes, I Agree",
                      buttonStyle: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                  CustomElevatedButton(
                    height: 55.v,
                    onTap: () {
                      Get.to(AccessYourCallHist());
                    },
                    width: 150.h,
                    buttonStyle: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    text: "Skip",
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              TextButton(
                onPressed: () async {
                  //open link in browser "https://codezaza.com/dialtrack-privacy-policy/"
                  final Uri _url = Uri.parse(
                      'https://codezaza.com/dialtrack-privacy-policy/');
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
