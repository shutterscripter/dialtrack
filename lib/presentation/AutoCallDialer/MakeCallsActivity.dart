import 'dart:io';

import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/AutoCallDialerController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';

// This is a StatefulWidget that represents the MakeCallsActivity screen.
class MakeCallsActivity extends StatefulWidget {
  // Constructor for MakeCallsActivity, takes a list of temporary data as input.
  MakeCallsActivity({Key? key, required this.temp}) : super(key: key);
  final List temp;

  // Creates the mutable state for this widget at a given location in the tree.
  @override
  State<MakeCallsActivity> createState() => _MakeCallsActivityState();
}

// This is the private State class that goes with MakeCallsActivity.
class _MakeCallsActivityState extends State<MakeCallsActivity> {
  // Controller for the AutoCallDialer
  AutoCallDialerController autoCallDialerController =
      Get.put(AutoCallDialerController());

  // List to hold the queue of calls
  List tempCallQueue = [];
  String nextNumber = "";
  bool granted = false;

  // Function to request phone permissions
  Future<bool> requestPermission() async {
    var status = await Permission.phone.request();

    return status == PermissionStatus.granted ||
        status == PermissionStatus.provisional;
  }

  // Function that is called when this object is inserted into the tree.
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) setStream();
    tempCallQueue = widget.temp;
  }

  // Function to set up the phone state stream
  void setStream() {
    PhoneState.stream.listen((event) {
      if (event.status == PhoneStateStatus.CALL_ENDED) {
        ///Make a delay of 10 seconds between the calls
        Future.delayed(const Duration(seconds: 10));
        if (tempCallQueue.isNotEmpty) {
          var tem = tempCallQueue.removeAt(0);
          makeCall(tem);
          setState(() {});
        }
      }
    });
  }

  // Function to make a call to a given number
  makeCall(number) {
    final DirectCaller directCaller = DirectCaller();
    directCaller.makePhoneCall(number);
  }

  // Function to build the widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text('Remaining: ${tempCallQueue.length} calls'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // show dialog with the info
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    content: const Text('Delay between calls is 2 seconds.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.info_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: tempCallQueue.length > 0
          ? ListView.builder(
              itemCount: tempCallQueue.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    tempCallQueue[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Calling...',
                    style: TextStyle(color: Colors.grey),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: PrimaryColors().purple,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cancel_outlined,
                    size: 60,
                    color: PrimaryColors().purple,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No more calls to make',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PrimaryColors().purple,
        elevation: 0,
        onPressed: !granted
            ? () async {
                bool temp = await requestPermission();
                granted = temp;
                if (granted) {
                  setStream();
                  if (tempCallQueue.isNotEmpty) {
                    makeCall(tempCallQueue.removeAt(0));
                    setState(() {});
                  }
                }
              }
            : null,
        child: const Icon(
          Icons.call,
          color: Colors.white,
        ),
      ),
    );
  }
}
