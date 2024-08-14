import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mithilesh_s_application1/controller/VerifySimController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';

class CallLogListForSimTwo extends StatefulWidget {
  final String? phoneNumber;
  final String? simOneName;

  const CallLogListForSimTwo({Key? key, this.phoneNumber, this.simOneName})
      : super(key: key);

  @override
  State<CallLogListForSimTwo> createState() => _CallLogListForSimTwoState();
}

class _CallLogListForSimTwoState extends State<CallLogListForSimTwo> {
  @override
  Widget build(BuildContext context) {
    VerifySimController verifySimNumberController =
        Get.put(VerifySimController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Container(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
        title: Text(
          "Select a Call Log which has been dialed with the SIM number ${widget.phoneNumber}",
          softWrap: true,
          style: TextStyle(
            //adjust to new line
            overflow: TextOverflow.visible,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: FutureBuilder(
          future: verifySimNumberController.getCallLogsForSimTwo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Obx(
                () {
                  return ListView.builder(
                    itemCount:
                        verifySimNumberController.sortedCallLogsTwo.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        child: ListTile(
                          onTap: () {
                            //get confirmation from user about choice by showing dialog
                            Get.defaultDialog(
                              backgroundColor: Colors.white,
                              title: "Confirm",
                              content: Text(
                                "Are you sure you want to verify this number?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          title: Text(
                            verifySimNumberController
                                    .sortedCallLogsTwo[index].name ??
                                'Unknown',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Checkbox(
                            value: false,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: PrimaryColors().purple,
                              ),
                            ),
                            onChanged: (value) {
                              //hive
                              var box = Hive.box('simVerify');
                              box.put('simTwoVerified', true);

                              if (verifySimNumberController
                                      .sortedCallLogsTwo[index].number ==
                                  verifySimNumberController
                                      .callLogsTwo[0].number) {
                                Get.offAll('/home');

                                var snackBar = SnackBar(
                                  content: Text('Sim 2 Verified Successfully'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                Get.back();
                                Get.snackbar(
                                  'Error',
                                  'Please select correct call log',
                                  snackStyle: SnackStyle.FLOATING,
                                );
                              }
                            },
                          ),
                          subtitle: Text(
                            verifySimNumberController
                                    .sortedCallLogsTwo[index].number! ??
                                'NA',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
