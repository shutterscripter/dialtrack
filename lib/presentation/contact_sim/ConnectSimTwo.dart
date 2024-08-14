import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mithilesh_s_application1/controller/CustomDialPadController.dart';
import 'package:mithilesh_s_application1/core/utils/image_constant.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/presentation/verify_sim_number/simnumber.dart';
import 'package:mithilesh_s_application1/widgets/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectSimTwo extends StatefulWidget {
  const ConnectSimTwo({Key? key}) : super(key: key);

  @override
  State<ConnectSimTwo> createState() => _ConnectSimTwoState();
}

class _ConnectSimTwoState extends State<ConnectSimTwo> {
  var args = Get.arguments;
  String _phoneNumber = '';
  CustomDialPadController customDialPadController =
      Get.put(CustomDialPadController());

  @override
  void initState() {
    customDialPadController.getSimInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Connect Sim (SIM 2)'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.v),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded( // Wrap the Text widget with Expanded
                    child: Text(
                      "Due to latest Google Policy & Android we have to collect information by verifying your phone number",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.v,
              ),
              SizedBox(
                height: 20.v,
              ),
              Row(
                children: [
                  Image.asset(
                    ImageConstant.simCardTwoInactive,
                    height: 30.v,
                    width: 30.v,
                  ),
                  SizedBox(
                    width: 10.v,
                  ),
                  Text(
                    '${customDialPadController.simTwoNameTemp}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.v,
              ),
              IntlPhoneField(
                onChanged: (phone) {
                  _phoneNumber = phone.completeNumber;
                },
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
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  //order color black
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),

                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15.h),
                  ),
                ),
                initialCountryCode: 'IN',
              ),
              SizedBox(
                height: 10.v,
              ),
              CustomElevatedButton(
                height: 55.v,
                onTap: () {
                  if (_phoneNumber.length < 10) {
                    Get.snackbar(
                      'Error',
                      'Please enter valid phone number',
                      snackStyle: SnackStyle.FLOATING,
                    );
                    return;
                  }
                  if (_phoneNumber == args) {
                    Get.snackbar(
                      'Error',
                      'Please enter different phone number',
                      snackStyle: SnackStyle.FLOATING,
                    );
                    return;
                  }
                  Get.to(SimNumber(phoneNumber: _phoneNumber, simName: '2'));
                },
                text: "Submit",
                buttonStyle: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 40.v,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Send Log File',
                          style: TextStyle(
                            fontSize: 12.v,
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
