import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mithilesh_s_application1/controller/CustomDialPadController.dart';
import 'package:mithilesh_s_application1/controller/VerifySimController.dart';

class CallLogList extends StatefulWidget {
  final String? phoneNumber;
  final String? simOneName;

  const CallLogList({Key? key, this.phoneNumber, this.simOneName})
      : super(key: key);

  @override
  State<CallLogList> createState() => _CallLogListState();
}

class _CallLogListState extends State<CallLogList> {
  VerifySimController verifySimNumberController =
  Get.put(VerifySimController());
  CustomDialPadController customDialPadController =
  Get.put(CustomDialPadController());

  @override
  void initState() {
    super.initState();
    verifySimNumberController.getCallLogs();
  }
  @override
  Widget build(BuildContext context) {
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
          future: verifySimNumberController.getCallLogs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("In the card->");
              print("Call Logs: ${verifySimNumberController.sortedCallLogs}");

              return Obx(
                () {
                  if (verifySimNumberController.sortedCallLogs.length > 0) {
                    return ListView.builder(
                      itemCount: verifySimNumberController.sortedCallLogs.length,
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
                                    onPressed: () {
                                      //hive
                                      var box = Hive.box('simVerify');
                                      box.put('simOneVerified', true);

                                      if (verifySimNumberController
                                              .sortedCallLogs[index].number ==
                                          verifySimNumberController
                                              .callLogs[0].number) {
                                        customDialPadController
                                                    .simInfo?.length ==
                                                1
                                            ? Get.offAllNamed('/home')
                                            : Get.toNamed('/connectSimTwo',
                                                arguments: widget.phoneNumber);

                                        const snackBar = SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            'Sim 1 Verified Successfully',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
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
                                      .sortedCallLogs[index].name ??
                                  'Unknown',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: Checkbox(
                              value: false,
                              onChanged: (value) {
                                //hive
                                var box = Hive.box('simVerify');
                                box.put('simOneVerified', true);

                                if (verifySimNumberController
                                        .sortedCallLogs[index].number ==
                                    verifySimNumberController
                                        .callLogs[0].number) {
                                  customDialPadController.simInfo?.length == 1
                                      ? Get.offAll('/home')
                                      : Get.toNamed('/connectSimTwo',
                                          arguments: widget.phoneNumber);

                                  const snackBar = SnackBar(
                                    content:
                                        Text('Sim 1 Verified Successfully'),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
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
                                      .sortedCallLogs[index].number! ??
                                  'NA',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Center(
                        child: Text("No Call Logs Found"),
                      ),
                    );
                  }
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
