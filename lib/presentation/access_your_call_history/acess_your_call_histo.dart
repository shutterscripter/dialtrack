import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/core/utils/image_constant.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/presentation/access_to_contact/accesstocontact.dart';
import 'package:mithilesh_s_application1/widgets/custom_elevated_button.dart';
import 'package:mithilesh_s_application1/widgets/custom_icon_button.dart';
import 'package:mithilesh_s_application1/widgets/custom_image_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class AccessYourCallHist extends StatefulWidget {
  const AccessYourCallHist({Key? key}) : super(key: key);

  @override
  State<AccessYourCallHist> createState() => _AccessYourCallHistState();
}

class _AccessYourCallHistState extends State<AccessYourCallHist> {
  @override
  Widget build(BuildContext context) {
    print("Access to contact screen called");
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.v),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle343329x383,
                height: 350.v,
                margin: EdgeInsets.only(top: 50.v),
                radius: BorderRadius.circular(
                  15.h,
                ),
              ),
              SizedBox(height: 50.h),
              Text(
                "ACCESS TO YOUR CALL - HISTORY",
                style: TextStyle(
                  fontSize: 20.v,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Callyzer would like to access your call history. By allowing Callyzer to access your call logs, the app can analyze your date and generate reports and statistics to monitor the results effectively. Call Log access is mandatory for Callyzer,  as its primary feature includes generating call reports.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12.v,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Callyzer does not upload your call log data to any cloud server without your consent. The data is stored locally on your device.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12.v,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Callyzer reads call logs when running in the background allowing the app to keep the logs even if it is deleted . Also, you can receive real-time reports without opening the app ",
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
                    bool permissionGranted =
                        await Permission.phone.status.isGranted;
                    if (!permissionGranted) {
                      await Permission.phone.request();
                    }
                    Get.to(AccessToContact());
                  },
                  text: "Allow Access",
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
                    "It is Secure!",
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
                  ///open link in browser "https://codezaza.com/dialtrack-privacy-policy/"
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
      ),
    );
  }
}
