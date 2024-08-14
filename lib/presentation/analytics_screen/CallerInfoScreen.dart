import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/presentation/analytics_screen/CallerModel.dart';
import 'package:mithilesh_s_application1/theme/theme_helper.dart';

class CallerInfoScreen extends StatelessWidget {
  final String heading;
  final CallerModel callerModel;

  const CallerInfoScreen({
    Key? key,
    required this.callerModel,
    this.heading = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minutes = callerModel.totalDuration ~/ 60;
    final seconds = callerModel.totalDuration % 60;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          heading,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.info_outline,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: Get.width,
        color: Colors.white,
        child: Column(
          children: [
            // top section includes circle avatar and name
            Container(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: PrimaryColors().amber500,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                        child: Text(
                          callerModel.callerName[0],
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    callerModel.callerName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Divider(thickness: 1),
            SizedBox(height: 40.h),

            // middle section includes call details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone Number",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  callerModel.callerNumber,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            ///total calls
            SizedBox(height: 20.h),
            Divider(),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Calls",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  callerModel.callCount.toString(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            ///Total duration
            SizedBox(height: 20.h),
            Divider(),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Duration",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${minutes}m ${seconds}s",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
