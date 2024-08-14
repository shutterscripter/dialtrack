import 'package:call_log/call_log.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/CallPageController.dart';
import 'package:mithilesh_s_application1/controller/CustomDialPadController.dart';
import 'package:mithilesh_s_application1/core/utils/image_constant.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/theme/custom_text_style.dart';
import 'package:mithilesh_s_application1/theme/theme_helper.dart';
import 'package:mithilesh_s_application1/widgets/custom_icon_button.dart';
import 'package:mithilesh_s_application1/widgets/custom_image_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCallList extends StatefulWidget {
  RxList callLogs = RxList();

  CustomCallList({Key? key, required this.callLogs}) : super(key: key);

  @override
  State<CustomCallList> createState() => _CustomCallListState();
}

class _CustomCallListState extends State<CustomCallList> {
  CallPageController callPageController = Get.put(CallPageController());
  final ScrollController _scrollController = ScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  CustomDialPadController customDialpadController =
      Get.put(CustomDialPadController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    itemPositionsListener.itemPositions.addListener(() {
      callPageController.getIndexOfElement(
          itemPositionsListener.itemPositions.value.first.index);
      callPageController.getDateOfElement(widget
          .callLogs[itemPositionsListener.itemPositions.value.first.index]
          .timestamp!);
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == 0) {
      // At the top
      int firstVisibleIndex = 0;
      CallLogEntry firstVisibleEntry = widget.callLogs[firstVisibleIndex];
      print("First visible entry: ${firstVisibleEntry.name}");
    } else if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {}
  }

  @override
  void dispose() {
    // Dispose the scroll controller
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: 5.h,
          top: 11.v,
          right: 4.h,
        ),
        child: widget.callLogs.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.not_interested_rounded,
                      size: 50,
                      color: PrimaryColors().purple,
                    ),
                    Text("No Call Logs"),
                  ],
                ),
              )
            : Obx(
                () => ScrollablePositionedList.builder(
                  itemPositionsListener: itemPositionsListener,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.callLogs().length,
                  // itemCount: callPageController.filterCallLogs().length,
                  itemBuilder: (BuildContext context, int index) {
                    // CallLogEntry entry = callPageController.filterCallLogs()[index];
                    CallLogEntry entry = widget.callLogs[index];
                    DateTime date = DateTime.fromMillisecondsSinceEpoch(
                        entry.timestamp ?? 0);
                    return Padding(
                      padding: EdgeInsets.only(
                          right: 10.v, left: 10.v, bottom: 15.v),
                      child: Container(
                        decoration: BoxDecoration(
                          color: appTheme.whiteA700,
                          borderRadius: BorderRadius.circular(15.h),
                          boxShadow: [
                            BoxShadow(
                              color: appTheme.gray200,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
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
                                      borderRadius: BorderRadius.circular(14.h),
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
                                            padding: EdgeInsets.only(left: 2.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    (entry.name ?? 'Unknown'),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.v,
                                                ),
                                                SizedBox(
                                                  height: 12.v,
                                                  width: 12.h,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          entry.phoneAccountId!
                                                                  .contains("2")
                                                              ? "1"
                                                              : entry.phoneAccountId!
                                                                      .contains(
                                                                          "1")
                                                                  ? "1"
                                                                  : "2",
                                                          style: TextStyle(
                                                            fontSize: 7,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      CustomImageView(
                                                        svgPath: ImageConstant
                                                            .imgFileBlack900,
                                                        alignment:
                                                            Alignment.center,
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
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                //add time on call in am or pm
                                                Spacer(),
                                                Text(
                                                  ///getting the date and display time in am or pm
                                                  "${date.hour > 12 ? date.hour - 12 : date.hour}:${date.minute} ${date.hour > 12 ? "PM" : "AM"}",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                                Spacer(),
                                                //ad duration of call in minutes and sec
                                                Text(
                                                  // display sec only when is passes 60 sec
                                                  entry.duration! > 60
                                                      ? "${entry.duration! ~/ 60}m ${entry.duration! % 60}s"
                                                      : "${entry.duration!}s",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ///copy contact onto clipboard
                                      FlutterClipboard.copy(entry.number ?? "")
                                          .then(
                                        (value) => Get.snackbar(
                                          "Copied",
                                          "Contact copied to clipboard",
                                          snackPosition: SnackPosition.BOTTOM,
                                        ),
                                      );
                                    },
                                    child: CustomImageView(
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
                                            svgPath: ImageConstant.imgComputer,
                                            height: 15.v,
                                            width: 20.h,
                                            radius: BorderRadius.circular(
                                              2.h,
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 3.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    height: 3.adaptSize,
                                                    width: 3.adaptSize,
                                                    decoration: BoxDecoration(
                                                      color: appTheme.teal200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        1.h,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 3.adaptSize,
                                                    width: 3.adaptSize,
                                                    margin: EdgeInsets.only(
                                                        left: 1.h),
                                                    decoration: BoxDecoration(
                                                      color: appTheme.teal200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        1.h,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 3.adaptSize,
                                                    width: 3.adaptSize,
                                                    margin: EdgeInsets.only(
                                                        left: 1.h),
                                                    decoration: BoxDecoration(
                                                      color: appTheme.teal200,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                    onTap: () =>
                                        _makingPhoneCall(entry.number!),
                                    child: CustomImageView(
                                      svgPath: ImageConstant.imgCallTeal20001,
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

  _makingPhoneCall(number) async {
    //make a pop up to get the sim card choice from user
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: PrimaryColors().lightWhite,
          elevation: 2,
          title: Text("Choose SIM"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customDialpadController.simOneFlag.value
                  ? ListTile(
                      leading: Image.asset(
                        ImageConstant.simCardOneActive,
                        height: 25.v,
                      ),
                      title: Text(customDialpadController.simOneName.value),
                      onTap: () {
                        customDialpadController.dialCall(number, sim: 1);
                      },
                    )
                  : Container(height: 0),
              customDialpadController.simTwoFlag.value
                  ? ListTile(
                      leading: Image.asset(
                        ImageConstant.simCardTwoActive,
                        height: 25.v,
                      ),
                      title: Text(customDialpadController.simTwoName.value),
                      onTap: () {
                        Get.back();
                        customDialpadController.dialCall(number, sim: 2);
                      },
                    )
                  : Container(height: 0),
              ListTile(
                title: Text("Cancel"),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
