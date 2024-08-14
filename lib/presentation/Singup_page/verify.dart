import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/SignUpController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/widgets/custom_elevated_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  VerifyOtpScreen({required this.verificationId, required this.phoneNumber});

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController _otpController = TextEditingController();
  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: appTheme.black900,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgRectangle343,
                      height: 300.v,
                      width: 300.h,
                      radius: BorderRadius.circular(
                        15.h,
                      ),
                    ),
                    SizedBox(height: 94.v),
                    Text(
                      "Enter The Verification Code",
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: 20.v),
                    Text(
                        "We have sent you an SMS with a code to number ${widget.phoneNumber}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.v,
                          color: Colors.grey,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            controller: _otpController,
                            decoration: InputDecoration(
                              hintText: "Enter OTP",
                              hintStyle: TextStyle(
                                fontSize: 16.v,
                                color: Colors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: PrimaryColors().purple,
                                ),
                                borderRadius: BorderRadius.circular(10.h),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: PrimaryColors().purple,
                                ),
                                borderRadius: BorderRadius.circular(10.h),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          CustomElevatedButton(
                            onTap: () async {
                              signUpController.verifyOTP(
                                  _otpController.text, widget.verificationId);
                            },
                            text: "Continue",
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't Received Anything?",
                                style: TextStyle(
                                  fontSize: 16.v,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 2.h),
                              Text(
                                "Resend Code",
                                style: TextStyle(
                                  fontSize: 16.v,
                                  color: PrimaryColors().purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
