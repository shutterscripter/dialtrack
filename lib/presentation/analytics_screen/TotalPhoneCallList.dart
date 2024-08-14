import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/AnalysisController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';

class TotalPhoneCallList extends StatefulWidget {
  String dayName = "Today";
  String cardType = "Total Phone Calls";

  TotalPhoneCallList({Key? key, required this.dayName, required this.cardType})
      : super(key: key);

  @override
  State<TotalPhoneCallList> createState() => _TotalPhoneCallListState();
}

class _TotalPhoneCallListState extends State<TotalPhoneCallList> {
  AnalysisController analyticsController = Get.put(AnalysisController());
  List callLogs = [];

  initState() {
    super.initState();
    if (widget.cardType == "Total Phone Calls") {
      callLogs = analyticsController.totalPhoneCalls;
    } else if (widget.cardType == "Incoming Calls") {
      callLogs = analyticsController.totalIncomingCalls;
    } else if (widget.cardType == "Outgoing Calls") {
      callLogs = analyticsController.totalOutgoingCalls;
    } else if (widget.cardType == "Missed Calls") {
      callLogs = analyticsController.totalMissedCalls;
    } else if (widget.cardType == "Rejected Calls") {
      callLogs = analyticsController.totalRejectedCalls;
    } else if (widget.cardType == "Connected Calls") {
      callLogs = analyticsController.totalConnectedCalls;
    } else if (widget.cardType == "Unique Calls") {
      callLogs = analyticsController.totalUniqueCalls;
    } else if (widget.cardType == "Not Picked by Client") {
      callLogs = analyticsController.totalNotPickedByClient;
    } else if (widget.cardType == "Never Attended Calls") {
      callLogs = analyticsController.totalNeverAttendedCalls;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text("${widget.cardType} Phone Calls (${callLogs.length})",
            style: TextStyle(color: PrimaryColors().gray600)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: callLogs.length > 0
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: callLogs.length,
                itemBuilder: (context, index) {
                  CallLogEntry callLogEntry = callLogs[index];
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(
                      callLogEntry.timestamp ?? 0);
                  return Card(
                    color: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: checkColor(callLogEntry.callType),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(
                            checkIcons(callLogEntry.callType),
                            height: 23.v,
                            color: checkColor(callLogEntry.callType),
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            callLogEntry.name ?? "Unknown",
                            style: TextStyle(
                              fontSize: 14,
                              color: PrimaryColors().black900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //sim number
                          Spacer(),
                          Text(
                            ///getting the date and display time in am or pm
                            "${date.hour > 12 ? date.hour - 12 : date.hour}:${date.minute} ${date.hour > 12 ? "PM" : "AM"}",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 12.v,
                            width: 12.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    callLogEntry.phoneAccountId!.contains("2")
                                        ? "1"
                                        : callLogEntry.phoneAccountId!
                                                .contains("1")
                                            ? "1"
                                            : "2",
                                    style: TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                CustomImageView(
                                  svgPath: ImageConstant.imgFileBlack900,
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            callLogEntry.number!,
                            style: TextStyle(
                              color: PrimaryColors().black900,
                            ),
                          ),
                          Spacer(),
                          Text(
                            callLogEntry.duration! > 60
                                ? "${callLogEntry.duration! ~/ 60}m ${callLogEntry.duration! % 60}s"
                                : "${callLogEntry.duration!}s",
                            style: TextStyle(
                              color: PrimaryColors().black900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.not_interested_rounded,
                    size: 100,
                    color: PrimaryColors().purple,
                  ),
                  Text(
                    "No Data Found",
                    style: TextStyle(
                      fontSize: 24,
                      color: PrimaryColors().purple,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  checkIcons(CallType? callType) {
    if (callType == CallType.incoming) {
      return ImageConstant.incomingCallsWhite;
    } else if (callType == CallType.outgoing) {
      return ImageConstant.outgoingCallsWhite;
    } else if (callType == CallType.missed) {
      return ImageConstant.missedCallsWhite;
    } else if (callType == CallType.rejected) {
      return ImageConstant.rejectedCallsWhite;
    } else {
      return ImageConstant.imgCallTeal20001;
    }
  }

  checkColor(CallType? callType) {
    if (callType == CallType.incoming) {
      return appTheme.limeA70001;
    } else if (callType == CallType.outgoing) {
      return appTheme.amber500;
    } else if (callType == CallType.missed) {
      return appTheme.red200;
    } else if (callType == CallType.rejected) {
      return appTheme.red500;
    } else {
      return appTheme.limeA70001;
    }
  }
}
