import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/CSVController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'dart:io';
import 'package:download/download.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/AutoCallDialerKeyboard.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/MakeCallsActivity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// `ShowDataCSV` is a StatefulWidget that displays a CSV file.
/// It allows the user to select a CSV file and displays its content.
/// It also provides an option to download a template CSV file.
class ShowDataCSV extends StatefulWidget {
  const ShowDataCSV({Key? key}) : super(key: key);

  @override
  State<ShowDataCSV> createState() => _ShowDataCSVState();
}

class _ShowDataCSVState extends State<ShowDataCSV> {
  CSVController controller = Get.put(CSVController());

  /// The `build` method returns a `Scaffold` widget that contains a `ListView` to display the CSV file content.
  /// It also contains a `FloatingActionButton` to make calls to the contacts in the CSV file.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: controller.flag.value
                ? ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? ListTile(
                              onTap: () =>
                                  controller.pickFileForAddMoreContacts(),
                              title: Text(
                                "Add More Contacts",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: PrimaryColors().purple),
                              ),
                              subtitle: Text(
                                "Import from CSV file",
                                style: TextStyle(color: Colors.grey),
                              ),
                              trailing: Icon(Icons.add),
                            )
                          : ListTile(
                              title: Text(
                                controller.data[index][0],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ), // Display the first column
                              subtitle: Text(
                                controller.data[index][5].toString(),
                                style: TextStyle(color: Colors.grey),
                              ), // Display the second column
                            );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.pickFile();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 30.0),
                          child: Text(
                            'Select CSV',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      InkWell(
                        onTap: () {
                          // controller.downloadFileToDownloadsFolder(context);
                          /// show dialog with image
                          showDialog(
                            barrierColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.all(20.h),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "CSV Format",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Image.asset('assets/images/csv.PNG'),
                                      SizedBox(height: 10.h),
                                      IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          'Click to view Template CSV file',
                          style: TextStyle(
                              fontSize: 12,
                              color: PrimaryColors().purple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        elevation: 0,
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: PrimaryColors().purple,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            elevation: 0,
            shape: CircleBorder(),
            backgroundColor: PrimaryColors().purple,
            child: Icon(
              Icons.call_rounded,
              color: Colors.white,
            ),
            label: 'Call First 10 Contacts',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              // Calculate the number of contacts to call
              int count =
                  controller.data.length > 11 ? 11 : controller.data.length;

              // Create a list of the first 10 contacts (or less if there are less than 10)
              List<String> temp = [];
              for (int i = 1; i < count; i++) {
                temp.add(controller.data[i][5].toString());
              }

              // Navigate to MakeCallsActivity with the list of contacts
              Get.to(MakeCallsActivity(temp: temp));

              // Remove the contacts from the original list
              controller.data.removeRange(1, count);

              // Update the UI
              setState(() {});
            },
          ),
          SpeedDialChild(
            elevation: 0,
            shape: CircleBorder(),
            backgroundColor: PrimaryColors().purple,
            child: Icon(
              Icons.call_rounded,
              color: Colors.white,
            ),
            label: 'Call First 50 Contacts',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              List<String> temp = [];
              for (int i = 1; i < controller.data.length; i++) {
                temp.add(controller.data[i][5].toString());
              }
              Get.to(MakeCallsActivity(
                  temp: temp.length > 50 ? temp.sublist(0, 50) : temp));

              // Remove the contacts from the original list
              controller.data.removeRange(
                  1, temp.length > 50 ? 51 : controller.data.length);

              // Update the UI
              setState(() {});
            },
          ),
          SpeedDialChild(
            elevation: 0,
            shape: CircleBorder(),
            backgroundColor: PrimaryColors().purple,
            child: Icon(
              Icons.call_rounded,
              color: Colors.white,
            ),
            label: 'Call First 100 Contacts',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              List<String> temp = [];
              for (int i = 1; i < controller.data.length; i++) {
                temp.add(controller.data[i][5].toString());
              }
              Get.to(MakeCallsActivity(
                  temp: temp.length > 100 ? temp.sublist(0, 100) : temp));

              // Remove the contacts from the original list
              controller.data.removeRange(
                  1, temp.length > 100 ? 101 : controller.data.length);

              // Update the UI
              setState(() {});
            },
          ),
          SpeedDialChild(
            elevation: 0,
            shape: CircleBorder(),
            backgroundColor: PrimaryColors().purple,
            child: Icon(
              Icons.dialpad_rounded,
              color: Colors.white,
            ),
            label: 'Add Custom Number',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Get.bottomSheet(
                Container(
                  color: PrimaryColors().lightWhite,
                  height: Get.height * 0.9,
                  child: AutoCallDialerKeyboard(),
                ),
                ignoreSafeArea: false,
                isScrollControlled: true,
                backgroundColor: PrimaryColors().lightWhite,
                enableDrag: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
