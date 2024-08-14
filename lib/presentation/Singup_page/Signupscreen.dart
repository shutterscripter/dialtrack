import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mithilesh_s_application1/controller/SignUpController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/widgets/custom_elevated_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _phoneNumber = '';
  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (value) => signUpController.isOtpSent
          ? Scaffold(
              /// appbar
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
              ),

              /// body
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.v),
                      Text(
                        "Enter your mobile number to continue",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      SizedBox(height: 50.v),

                      /// phone number text-field and country code dropdown
                      IntlPhoneField(
                        onChanged: (phone) =>
                            _phoneNumber = phone.completeNumber,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          hintText: 'Enter phone number',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintFadeDuration: Duration(milliseconds: 100),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: PrimaryColors().purple,
                            ),
                            borderRadius: BorderRadius.circular(15.h),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: PrimaryColors().purple,
                            ),
                            borderRadius: BorderRadius.circular(15.h),
                          ),
                        ),
                        disableLengthCheck: false,
                        pickerDialogStyle: PickerDialogStyle(
                          backgroundColor: Colors.white,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialCountryCode: 'IN',
                      ),
                      SizedBox(height: 20.v),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: CustomElevatedButton(
                          text: "Send OTP",
                          onTap: () async {
                            if (_phoneNumber.length < 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please enter a valid phone number!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );

                            }

                            await signUpController
                                .verifyPhoneNumber(_phoneNumber);
                          },
                        ),
                      ),
                      SizedBox(height: 50.v),

                      ///OR Divider
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            SizedBox(width: 10.h),
                            Text(
                              "or",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10.h),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 50.v),
                      Center(
                        child: Text(
                          'Social Medial Login',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.v),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///google logo
                          Container(
                            height: 50.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.transparent,
                                backgroundColor: Colors.white,
                                elevation: 1,
                                surfaceTintColor: Colors.transparent,
                              ),
                              onPressed: () {},
                              child: Image.asset(ImageConstant.googleLogo),
                            ),
                          ),

                          /// facebook logo
                          SizedBox(width: 20.h),
                          Container(
                            height: 50.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.transparent,
                                backgroundColor:
                                    Color.fromRGBO(24, 119, 242, 1),
                                elevation: 1,
                                surfaceTintColor: Colors.transparent,
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(ImageConstant.facebookLogo),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.h),

                          ///apple logo
                          Container(
                            height: 50.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.transparent,
                                backgroundColor: Colors.white,
                                elevation: 1,
                                surfaceTintColor: Colors.transparent,
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(ImageConstant.apple),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
