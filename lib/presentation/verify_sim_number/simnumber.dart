import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mithilesh_s_application1/controller/CustomDialPadController.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/presentation/verify_sim_number/CallLogList.dart';
import 'package:mithilesh_s_application1/presentation/verify_sim_number/CallLogListforSimTwo.dart';
import 'package:mithilesh_s_application1/theme/theme_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class SimNumber extends StatefulWidget {
  final String? phoneNumber;
  final String? simName;

  const SimNumber({
    Key? key,
    this.phoneNumber,
    this.simName,
  }) : super(key: key);

  @override
  State<SimNumber> createState() => _SimNumberState();
}

class _SimNumberState extends State<SimNumber> {
  bool simOnePresent = false;
  bool simTwoPresent = false;
  CustomDialPadController customDialPadController =
      Get.put(CustomDialPadController());

  @override
  void initState() {
    super.initState();
    customDialPadController.getSimInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColors().lightWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Sim Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Text(
              "Choose one of the option to verify your number",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Card(
              surfaceTintColor: Colors.transparent,
              color: PrimaryColors().lightWhite,
              child: ListTile(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      height: Get.height / 2.4,
                      color: PrimaryColors().lightWhite,
                      child: widget.simName == '1'
                          ? CallLogList(
                              phoneNumber: widget.phoneNumber,
                              simOneName: widget.simName,
                            )
                          : CallLogListForSimTwo(
                              phoneNumber: widget.phoneNumber,
                              simOneName: widget.simName,
                            ),
                    ),
                  );
                },
                style: ListTileStyle.list,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                leading: Icon(
                  Icons.contact_page_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Verify via Call Log",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "App will show few call logs and you need to simply select which call you have dialed using ${widget.phoneNumber}.",
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            // Card(
            //   surfaceTintColor: Colors.transparent,
            //   color: PrimaryColors().lightWhite,
            //   child: ListTile(
            //     onTap: () {
            //       Get.defaultDialog(
            //         backgroundColor: PrimaryColors().lightWhite,
            //         contentPadding: EdgeInsets.symmetric(
            //           vertical: 10,
            //           horizontal: 20,
            //         ),
            //         title: "Are you sure you want to verify via call?",
            //         content: Column(
            //           children: [
            //             Text(
            //               "App will make a dummy call to your number itself.",
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 color: Colors.grey,
            //               ),
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Text(
            //               "Please note that you can verify this number from settings > SIM Number.",
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 color: Colors.grey,
            //               ),
            //             ),
            //           ],
            //         ),
            //         textConfirm: "Yes, Verify",
            //         textCancel: "No",
            //         cancelTextColor: Colors.black,
            //         confirmTextColor: Colors.red,
            //         buttonColor: Colors.transparent,
            //         onConfirm: () async {
            //           Get.toNamed('/home');
            //         },
            //         onCancel: () {
            //           Get.back();
            //         },
            //       );
            //     },
            //     style: ListTileStyle.list,
            //     contentPadding:
            //         EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            //     leading: Icon(
            //       Icons.call,
            //       color: Colors.black,
            //     ),
            //     title: Text(
            //       "Verify via call",
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     subtitle: Text(
            //       "App will make a dummy call to your number itself.",
            //       style: TextStyle(
            //         fontSize: 8,
            //         color: Colors.grey,
            //       ),
            //     ),
            //     trailing: Icon(
            //       Icons.arrow_forward_ios,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10.h),
            Card(
              color: PrimaryColors().lightWhite,
              surfaceTintColor: Colors.transparent,
              child: ListTile(
                onTap: () {
                  Get.defaultDialog(
                    backgroundColor: PrimaryColors().lightWhite,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    title: "Are you sure you want to skip verification?",
                    content: Column(
                      children: [
                        Text(
                          "The app won’t be able to identify which SIM is used for a call log and may face issue with reports and upcoming versions.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please note that you can verify this number from settings > SIM Number.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    textConfirm: "Yes, Skip",
                    textCancel: "No",
                    cancelTextColor: Colors.black,
                    confirmTextColor: Colors.red,
                    buttonColor: Colors.transparent,
                    onConfirm: () {
                      var box = Hive.box('simVerify');
                      bool simTwo =
                          box.get('simTwoVerified', defaultValue: false);
                      if (simTwoPresent) {
                        if (widget.simName == '1') {
                          customDialPadController.simInfo!.length == 1 && simTwo
                              ? Get.offAllNamed('/home')
                              : Get.toNamed('/connectSimTwo',
                                  arguments: widget.phoneNumber);
                        }
                      } else {
                        Get.offAllNamed('/home');
                      }
                    },
                    onCancel: () {},
                  );
                },
                style: ListTileStyle.list,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                leading: Icon(
                  Icons.cancel,
                  color: Colors.black,
                ),
                title: Text(
                  "Skip Verification",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "(Not Recommended)\nVerification process will be skipped and you would be able to use app. However, you may face issue with reports and upcoming versions.",
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getSimFlags() async {
    PermissionStatus status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
      if (!status.isGranted) {
        return;
      }
    }
// Now you can access the SIM card information
    await customDialPadController.getSimInfo();
    simOnePresent = await customDialPadController.simOneFlag.value;
    simTwoPresent = await customDialPadController.simTwoFlag.value;
    print("simOnePresent $simOnePresent");
    print("simTwoPresent $simTwoPresent");
  }
}
