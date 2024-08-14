import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/theme/theme_helper.dart';

class SummaryCard extends StatelessWidget {
  final String imagePath;
  final String heading;
  final String callNumbers;
  final int callDuration;

  SummaryCard({
    Key? key,
    required this.imagePath,
    required this.heading,
    required this.callNumbers,
    required this.callDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minutes = callDuration ~/ 60;
    final seconds = callDuration % 60;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      shadowColor: Colors.black,
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            width: 180.h,
            padding: EdgeInsets.all(10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///heading and image
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: //svg
                          SvgPicture.asset(
                        imagePath,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        heading,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                ///call numbers
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.call_rounded,
                        size: 20,
                      ),
                      SizedBox(width: 5.h),
                      Expanded(
                        child: Text(
                          callNumbers,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.v),

                ///call duration
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 20,
                        color: heading == "Missed Calls" ||
                                heading == "Rejected Calls" ||
                                heading == "Never Attended Calls" ||
                                heading == "Not Picked by Client" ||
                                heading == "Unique Calls" ||
                                heading == "Connected Calls"
                            ? Colors.transparent
                            : Colors.black,
                      ),
                      SizedBox(width: 5.h),
                      Text(
                        "${minutes}m ${seconds}s",
                        style: TextStyle(
                          fontSize: 16,
                          color: heading == "Missed Calls" ||
                                  heading == "Rejected Calls" ||
                                  heading == "Never Attended Calls" ||
                                  heading == "Not Picked by Client" ||
                                  heading == "Unique Calls" ||
                                  heading == "Connected Calls"
                              ? Colors.transparent
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        /*  /// premium tag
          heading == "Unique Calls" ||
                  heading == "Connected Calls" ||
                  heading == "Never Attended Calls" ||
                  heading == "Not Picked by Client"
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.h, vertical: 2.v),
                    decoration: BoxDecoration(
                      color: PrimaryColors().purple ,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Premium",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Container(height: 0),*/
        ],
      ),
    );
  }
}
