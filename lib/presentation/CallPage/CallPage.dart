import 'package:call_log/call_log.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/CallPageController.dart';
import 'package:mithilesh_s_application1/widgets/customcalliconwidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/widgets/custom_search_view.dart';

/// this page is not in used and can be deleted after checking any reference
/// this page is replaced by callsScreen.dart and implemented with getx
/// Path: lib/presentation/CallPage/CallPage.dart

// ignore_for_file: must_be_immutable
class CallPage extends StatefulWidget {
  CallPage({Key? key})
      : super(
          key: key,
        );

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  CallPageController callPageController = Get.put(CallPageController());

  // List<CallLogEntry> _callLogs = [];
  //
  // String selectedCallType = "All Calls";
  // int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCallLogs();
  }

  // Function to filter call logs based on the selected call type
  Future<void> _getCallLogs() async {
    ///checking whether phone permission is granted or not
    bool permissionGranted = await Permission.phone.status.isGranted;
    if (!permissionGranted) {
      await Permission.phone.request();
    }

    ///getting call logs by getx controller
    print("Get Call Logs");
    callPageController.getCallLogs();

    //print all call logs
    print("Call Logs: ${callPageController.callLogs.length.obs}");
    // Remove after implementation
    // Iterable<CallLogEntry> entries = await CallLog.get();
    //
    // setState(() {
    //   _callLogs = entries.toList();
    // });
  }

  getFilteredCallLogs() {
    /// filtering call logs by getx controller
    // callPageController.filterCallLogs();
    if (callPageController.selectedCallType.value == "All Calls") {
      return callPageController.callLogs;
    } else if (callPageController.selectedCallType.value == "Incoming") {
      return callPageController.callLogs
          .where((log) => log.callType == CallType.incoming)
          .toList();
    } else if (callPageController.selectedCallType.value == "Missed") {
      return callPageController.callLogs
          .where((log) => log.callType == CallType.missed)
          .toList();
    } else if (callPageController.selectedCallType.value == "Outgoing") {
      return callPageController.callLogs
          .where((log) => log.callType == CallType.outgoing)
          .toList();
    } else if (callPageController.selectedCallType.value == "Rejected") {
      return callPageController.callLogs
          .where((log) => log.callType == CallType.rejected)
          .toList();
    } else {
      return [];
    }

    // Remove after implementation
    // if (selectedCallType == "All Calls") {
    //   return _callLogs;
    // } else if (selectedCallType == "Incoming") {
    //   return _callLogs
    //       .where((log) => log.callType == CallType.incoming)
    //       .toList();
    // } else if (selectedCallType == "Missed") {
    //   return _callLogs.where((log) => log.callType == CallType.missed).toList();
    // } else if (selectedCallType == "Outgoing") {
    //   return _callLogs
    //       .where((log) => log.callType == CallType.outgoing)
    //       .toList();
    // } else if (selectedCallType == "Rejected") {
    //   return _callLogs
    //       .where((log) => log.callType == CallType.rejected)
    //       .toList();
    // } else {
    //   return [];
    // }
  }

  void updateSelectedCallType(String callType) {
    RxString tempCallType = callType.obs;
    callPageController.updateIndex(tempCallType);

    // Remove after implementation
    // setState(() {
    //   selectedCallType = callType;
    // });
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Rebuild");
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillGray,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 13.h,
                    top: 10.v,
                  ),
                  child: Text(
                    "Call History",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomCallIconWidget(
                            iconImage: ImageConstant.allCalls,
                            isSelected:
                                callPageController.selectedIndex.value == 0
                                    ? true
                                    : false,
                            label: "All Calls",
                            onTap: () {
                              callPageController.updateIndex("All Calls".obs);
                            },
                          ),
                          CustomCallIconWidget(
                              iconImage: ImageConstant.incomingCalls,
                              label: "Incoming",
                              isSelected:
                                  callPageController.selectedIndex.value == 1
                                      ? true
                                      : false,
                              onTap: () {
                                callPageController.updateIndex("Incoming".obs);
                                setState(() {

                                });
                              }),
                          CustomCallIconWidget(
                              iconImage: ImageConstant.outgoingCalls,
                              label: "Outgoing",
                              isSelected:
                                  callPageController.selectedIndex.value == 2
                                      ? true
                                      : false,
                              onTap: () {
                                updateSelectedCallType("Outgoing");
                              }),
                          CustomCallIconWidget(
                              iconImage: ImageConstant.missedCalls,
                              label: "Missed",
                              isSelected:
                                  callPageController.selectedIndex.value == 3
                                      ? true
                                      : false,
                              onTap: () {
                                updateSelectedCallType("Missed");
                              }),
                          CustomCallIconWidget(
                            iconImage: ImageConstant.rejectedCalls,
                            label: "Rejected",
                            isSelected:
                                callPageController.selectedIndex.value == 4
                                    ? true
                                    : false,
                            onTap: () {
                              updateSelectedCallType("Rejected");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomSearchView(
                    margin: EdgeInsets.only(
                      left: 11.h,
                      top: 15.v,
                      right: 13.h,
                    ),
                    controller: searchController,
                    autofocus: false,
                    hintText: "Search",
                    hintStyle: CustomTextStyles.bodyMedium13_1,
                    alignment: Alignment.center,
                    prefix: Container(
                      margin: EdgeInsets.fromLTRB(15.h, 17.v, 18.h, 15.v),
                      child: CustomImageView(
                        svgPath: ImageConstant.imgSearch,
                      ),
                    ),
                    prefixConstraints: BoxConstraints(
                      maxHeight: 54.v,
                    ),
                    suffix: Padding(
                      padding: EdgeInsets.only(
                        right: 15.h,
                      ),
                      child: IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.v),
                Text(
                  "Calls",
                  style: CustomTextStyles.labelLargeBold13,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 2.h,
                    top: 7.v,
                  ),
                  child: Text(
                    "Today",
                    style: CustomTextStyles.titleSmallSemiBold,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5.h,
                      top: 11.v,
                      right: 4.h,
                    ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: getFilteredCallLogs().length,
                      // itemCount: callPageController.filterCallLogs().length,
                      itemBuilder: (BuildContext context, int index) {
                        // CallLogEntry entry = callPageController.filterCallLogs()[index];
                        CallLogEntry entry = getFilteredCallLogs()[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              right: 10.v, left: 10.v, bottom: 20.v),
                          child: Container(
                            decoration: AppDecoration.outlineBlack.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 11.h,
                                    top: 13.v,
                                    right: 11.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconButton(
                                        height: 30.adaptSize,
                                        width: 30.adaptSize,
                                        margin: EdgeInsets.only(bottom: 3.v),
                                        padding: EdgeInsets.all(5.h),
                                        decoration: BoxDecoration(
                                          color: checkColor(entry.callType),
                                          borderRadius:
                                              BorderRadius.circular(14.h),
                                        ),
                                        child: CustomImageView(
                                          svgPath: checkIcons(entry.callType),
                                          height: 25.adaptSize,
                                          width: 25.adaptSize,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 9.h),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 2.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      (entry.name ?? 'Unknown'),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.v,
                                                    ),
                                                    SizedBox(
                                                      height: 12.v,
                                                      width: 12.h,
                                                      child: Stack(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 1.h),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Text(
                                                                " 1",
                                                                style: CustomTextStyles
                                                                    .segoeUIBlack900SemiBold7_2,
                                                              ),
                                                            ),
                                                          ),
                                                          CustomImageView(
                                                            svgPath: ImageConstant
                                                                .imgFileBlack900,
                                                            height: 20.v,
                                                            width: 10.h,
                                                            radius: BorderRadius
                                                                .circular(
                                                              2.h,
                                                            ),
                                                            alignment: Alignment
                                                                .centerRight,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 2.v,
                                                  right: 3.h,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      (entry.number ?? "Nope"),
                                                      style: CustomTextStyles
                                                          .labelMediumBlack900SemiBold10_1,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 150.h),
                                                      child: Text(
                                                        '${entry.callType.toString().substring(9).toUpperCase()}',
                                                        style: theme.textTheme
                                                            .labelSmall,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 46.h,
                                    top: 8.v,
                                    right: 42.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                        svgPath:
                                            ImageConstant.imgFileBlack90020x16,
                                        height: 20.v,
                                        width: 16.h,
                                        radius: BorderRadius.circular(
                                          2.h,
                                        ),
                                        margin: EdgeInsets.only(
                                          top: 1.v,
                                          bottom: 2.v,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final url = 'sms:${entry.number}';
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Container(
                                          height: 15.v,
                                          width: 20.h,
                                          margin: EdgeInsets.only(
                                            top: 1.v,
                                            bottom: 5.v,
                                          ),
                                          child: Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              CustomImageView(
                                                svgPath:
                                                    ImageConstant.imgComputer,
                                                height: 15.v,
                                                width: 20.h,
                                                radius: BorderRadius.circular(
                                                  2.h,
                                                ),
                                                alignment: Alignment.center,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 3.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        height: 3.adaptSize,
                                                        width: 3.adaptSize,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              appTheme.teal200,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            1.h,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 3.adaptSize,
                                                        width: 3.adaptSize,
                                                        margin: EdgeInsets.only(
                                                            left: 1.h),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              appTheme.teal200,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            1.h,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 3.adaptSize,
                                                        width: 3.adaptSize,
                                                        margin: EdgeInsets.only(
                                                            left: 1.h),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              appTheme.teal200,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            1.h,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final url = 'sms:${entry.number}';
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: CustomImageView(
                                          imagePath: ImageConstant.imgWhatsapp1,
                                          height: 21.adaptSize,
                                          width: 21.adaptSize,
                                          margin: EdgeInsets.only(
                                            top: 1.v,
                                            bottom: 2.v,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          bool? res =
                                              await FlutterPhoneDirectCaller
                                                  .callNumber(entry.number!);
                                        },
                                        child: CustomImageView(
                                          svgPath:
                                              ImageConstant.imgCallTeal20001,
                                          height: 24.adaptSize,
                                          width: 24.adaptSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 11.v),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      return appTheme.limeA700;
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
