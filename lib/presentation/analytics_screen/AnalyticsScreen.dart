import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mithilesh_s_application1/controller/AnalysisController.dart';
import 'package:mithilesh_s_application1/controller/CallPageController.dart';
import 'package:mithilesh_s_application1/controller/bottom_nav_controller.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/presentation/analytics_screen/TotalPhoneCallList.dart';
import 'package:mithilesh_s_application1/widgets/AnalysisCard.dart';
import 'package:mithilesh_s_application1/widgets/SummaryCard.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AnalyticsScreen extends StatefulWidget {
  AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  AnalysisController analysisController = Get.put(AnalysisController());
  CallPageController callPageController = Get.put(CallPageController());

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    analysisController.fetchCallLogData(date);
  }

  @override
  Widget build(BuildContext context) {
    late DateTime _startDate, _endDate;
    final DateRangePickerController _controller = DateRangePickerController();
    void selectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        _startDate = args.value.startDate;
        _endDate = args.value.endDate;
      });
    }

    return Scaffold(
      backgroundColor: PrimaryColors().lightWhite,
      appBar: AppBar(
        title: Text("Analytics"),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            child: Obx(
              () => callPageController.simAllOnFlag.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          analysisController.sim = 0;
                          analysisController.update();
                          callMethods();
                          callPageController.simAllFlag.value = true;
                          callPageController.simOneFlag.value = false;
                          callPageController.simTwoFlag.value = false;
                        },
                        child: Image.asset(
                          callPageController.simAllFlag.value
                              ? ImageConstant.dualSimCardActive
                              : ImageConstant.dualSimCardInactive,
                          height: 25.v,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
          Container(
            child: Obx(
              () => callPageController.simOneOnFlag.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          analysisController.sim = 1;
                          analysisController.update();
                          callMethods();
                          callPageController.simOneFlag.value = true;
                          callPageController.simAllFlag.value = false;
                          callPageController.simTwoFlag.value = false;
                        },
                        child: Image.asset(
                          callPageController.simOneFlag.value
                              ? ImageConstant.simCardOneActive
                              : ImageConstant.simCardOneInactive,
                          height: 25.v,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
          Container(
            child: Obx(
              () => callPageController.simTwoOnFlag.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          analysisController.sim = 2;
                          analysisController.update();
                          callMethods();
                          callPageController.simTwoFlag.value = true;
                          callPageController.simAllFlag.value = false;
                          callPageController.simOneFlag.value = false;
                        },
                        child: Obx(
                          () => Image.asset(
                            callPageController.simTwoFlag.value
                                ? ImageConstant.simCardTwoActive
                                : ImageConstant.simCardTwoInactive,
                            height: 25.v,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade300,
              padding: EdgeInsets.only(
                top: 15,
                bottom: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GetBuilder<AnalysisController>(
                    builder: (controller) {
                      return Text(
                        "Date: ${analysisController.toAndFromDateText}",
                        style: theme.textTheme.labelMedium,
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        backgroundColor: Colors.white,
                        elevation: 1,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 800.h,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: Container(
                                height: Get.height,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 30.h),
                                    ListTile(
                                      tileColor: Colors.grey.shade200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      title: Text(
                                        "Today",
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onTap: () {
                                        analysisController
                                            .fetchTodayCallLogs();
                                        Get.back();
                                      },
                                    ),
                                    SizedBox(height: 5.h),
                                    ListTile(
                                      tileColor: Colors.grey.shade200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      title: Text(
                                        "Yesterday",
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onTap: () {
                                        analysisController
                                            .fetchYesterdayCallLogs();
                                        Get.back();
                                      },
                                    ),
                                    SizedBox(height: 5.h),
                                    ListTile(
                                      tileColor: Colors.grey.shade200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      title: Text(
                                        "Week",
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onTap: () {
                                        analysisController
                                            .fetchWeekCallLogs();
                                        Get.back();
                                      },
                                    ),
                                    SizedBox(height: 5.h),
                                    ListTile(
                                      tileColor: Colors.grey.shade200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      title: Text(
                                        "Month",
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onTap: () {
                                        analysisController
                                            .fetchMonthCallLogs();
                                        Get.back();
                                      },
                                    ),
                                    SizedBox(height: 5.h),
                                    ListTile(
                                      tileColor: Colors.grey.shade200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      title: Text(
                                        "Year",
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onTap: () {
                                        analysisController
                                            .fetchYearCallLogs();
                                        Get.back();
                                      },
                                    ),
                                    SizedBox(height: 5.h),
                                    ListTile(
                                      tileColor: Colors.grey.shade200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      title: Text(
                                        "Custom",
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onTap: () {
                                        print("Custom");
                                        Get.back();
                                        Get.bottomSheet(
                                          Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 20),
                                            child: Container(
                                              padding: EdgeInsets.all(20),
                                              height: Get.height / 2.5,
                                              child: SfDateRangePicker(
                                                controller: _controller,
                                                onSelectionChanged:
                                                    selectionChanged,
                                                onSubmit: (value) {
                                                  analysisController
                                                      .fetchCustomCallLogs(
                                                          _startDate,
                                                          _endDate);
                                                  Get.back();
                                                },
                                                onCancel: () => Get.back(),
                                                selectionShape:
                                                    DateRangePickerSelectionShape
                                                        .circle,
                                                selectionRadius: 20,
                                                selectionColor:
                                                    PrimaryColors().purple,
                                                showActionButtons: true,
                                                toggleDaySelection: true,
                                                selectionMode:
                                                    DateRangePickerSelectionMode
                                                        .range,
                                              ),
                                            ),
                                          ),
                                          backgroundColor: Colors.white,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: PrimaryColors().lightWhite,
                      minimumSize: Size(150, 50), // Text color
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GetBuilder<AnalysisController>(
                          builder: (controller) =>
                              Text(analysisController.selectedDateText),
                        ),
                        Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///bar chart
            Padding(
              padding: EdgeInsets.only(
                top: 10.v,
                left: 30.h,
                right: 30.h,
              ),
              child: Material(
                color: Colors.white,
                elevation: 5,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 270.v,
                  child: GetBuilder<AnalysisController>(
                    builder: (controller) {
                      return BarChart(
                        analysisController.createSeries(),
                        animate: true,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.v),

            ///tab-bar view
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: PrimaryColors().gray100,
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelStyle: theme.textTheme.labelMedium,
                    padding: EdgeInsets.only(
                      left: 100.h,
                      right: 100.h,
                    ),
                    tabs: [
                      Tab(
                        text: "Summary",
                      ),
                      Tab(
                        text: "Analysis",
                      ),
                    ],
                  ),
                  SizedBox(height: 10.v),
                  Container(
                    height: Get.height / 1.2,
                    child: TabBarView(
                      children: [
                        ///summary
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///total calls and incoming calls
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ///total calls widget
                                GetBuilder<AnalysisController>(
                                  builder: (controller) {
                                    return GestureDetector(
                                      onTap: () {
                                        var day =
                                            analysisController.selectedDateText;
                                        Get.to(
                                          TotalPhoneCallList(
                                            dayName: day,
                                            cardType: "Total Phone Calls",
                                          ),
                                        );
                                      },
                                      child: SummaryCard(
                                        imagePath: ImageConstant.allCalls,
                                        heading: "Total Phone Calls",
                                        callNumbers: analysisController
                                            .totalPhoneCalls.length
                                            .toString(),
                                        callDuration: analysisController
                                            .totalCallDuration,
                                      ),
                                    );
                                  },
                                ),

                                ///summary incoming call widget
                                GetBuilder<AnalysisController>(
                                  builder: (controller) {
                                    return GestureDetector(
                                      onTap: () {
                                        var day =
                                            analysisController.selectedDateText;
                                        Get.to(
                                          TotalPhoneCallList(
                                            dayName: day,
                                            cardType: "Incoming Calls",
                                          ),
                                        );
                                      },
                                      child: SummaryCard(
                                        imagePath: ImageConstant.incomingCalls,
                                        heading: "Incoming Calls",
                                        callNumbers: analysisController
                                            .incomingCalls
                                            .toString(),
                                        callDuration: analysisController
                                            .incomingCallDuration,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10.v),

                            ///summary outgoing call widget and missed call widget
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ///total calls widget
                                GetBuilder<AnalysisController>(
                                  builder: (controller) {
                                    return GestureDetector(
                                      onTap: () {
                                        var day =
                                            analysisController.selectedDateText;
                                        Get.to(
                                          TotalPhoneCallList(
                                            dayName: day,
                                            cardType: "Outgoing Calls",
                                          ),
                                        );
                                      },
                                      child: SummaryCard(
                                        imagePath: ImageConstant.outgoingCalls,
                                        heading: "Outgoing Calls",
                                        callNumbers: analysisController
                                            .outgoingCalls
                                            .toString(),
                                        callDuration: analysisController
                                            .outgoingCallDuration,
                                      ),
                                    );
                                  },
                                ),

                                ///summary incoming call widget
                                GetBuilder<AnalysisController>(
                                  builder: (controller) {
                                    return GestureDetector(
                                      onTap: () {
                                        var day =
                                            analysisController.selectedDateText;
                                        Get.to(
                                          TotalPhoneCallList(
                                            dayName: day,
                                            cardType: "Missed Calls",
                                          ),
                                        );
                                      },
                                      child: SummaryCard(
                                        imagePath: ImageConstant.missedCalls,
                                        heading: "Missed Calls",
                                        callNumbers: analysisController
                                            .missedCalls
                                            .toString(),
                                        callDuration: 0,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10.v),

                            /// rejected calls and Never Attended calls
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ///total calls widget
                                GetBuilder<AnalysisController>(
                                  builder: (controller) {
                                    return GestureDetector(
                                      onTap: () {
                                        var day =
                                            analysisController.selectedDateText;
                                        Get.to(
                                          TotalPhoneCallList(
                                            dayName: day,
                                            cardType: "Rejected Calls",
                                          ),
                                        );
                                      },
                                      child: SummaryCard(
                                        imagePath: ImageConstant.rejectedCalls,
                                        heading: "Rejected Calls",
                                        callNumbers: analysisController
                                            .totalRejectedCalls.length
                                            .toString(),
                                        callDuration: 0,
                                      ),
                                    );
                                  },
                                ),
                                GetBuilder<AnalysisController>(
                                  builder: (controller) {
                                    return GestureDetector(
                                      onTap: () {
                                        var day =
                                            analysisController.selectedDateText;
                                        Get.to(
                                          TotalPhoneCallList(
                                            dayName: day,
                                            cardType: "Never Attended Calls",
                                          ),
                                        );
                                      },
                                      child: SummaryCard(
                                        imagePath: ImageConstant.rejectedCalls,
                                        heading: "Never Attended Calls",
                                        callNumbers: analysisController
                                            .totalNeverAttendedCalls.length
                                            .toString(),
                                        callDuration: 0,
                                      ),
                                    );
                                  },
                                ),

                                ///summary incoming call widget
                              ],
                            ),
                            SizedBox(height: 10.v),

                            /// not picked by client and connected calls
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GetBuilder<AnalysisController>(
                                  builder: (controller) {
                                    return GestureDetector(
                                      onTap: () {
                                        var day =
                                            analysisController.selectedDateText;
                                        Get.to(
                                          TotalPhoneCallList(
                                            dayName: day,
                                            cardType: "Not Picked by Client",
                                          ),
                                        );
                                      },
                                      child: SummaryCard(
                                        imagePath: ImageConstant.rejectedCalls,
                                        heading: "Not Picked by Client",
                                        callNumbers:
                                            '${controller.totalNotPickedByClient.length}',
                                        callDuration: 0,
                                      ),
                                    );
                                  },
                                ),
                                GetBuilder<AnalysisController>(
                                  builder: (controller) {
                                    return GestureDetector(
                                      onTap: () {
                                        var day =
                                            analysisController.selectedDateText;
                                        Get.to(
                                          TotalPhoneCallList(
                                            dayName: day,
                                            cardType: "Connected Calls",
                                          ),
                                        );
                                      },
                                      child: SummaryCard(
                                        imagePath: ImageConstant.rejectedCalls,
                                        heading: "Connected Calls",
                                        callNumbers:
                                            '${controller.totalConnectedCalls.length}',
                                        callDuration: 0,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10.v),

                            /// Connected Calls (unimplemented)
                            /*   Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ///unique calls widget
                                  GetBuilder<AnalysisController>(
                                    builder: (controller) {
                                      return GestureDetector(
                                        onTap: () {
                                          var day = analysisController
                                              .selectedDateText;
                                          Get.to(
                                            TotalPhoneCallList(
                                              dayName: day,
                                              cardType: "Unique Calls",
                                            ),
                                          );
                                        },
                                        child: SummaryCard(
                                          imagePath:
                                              ImageConstant.rejectedCalls,
                                          heading: "Unique Calls",
                                          callNumbers:
                                              '${controller.totalUniqueCalls.length}',
                                          callDuration: 0,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),*/
                          ],
                        ),

                        ///Analysis
                        Column(
                          children: [
                            /// TOP CALLER
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ///total calls widget
                                GetBuilder<AnalysisController>(
                                  builder: (controller) {
                                    return AnalysisCard(
                                      heading: "Top Caller",
                                      imagePath: ImageConstant.longestCallLogo,
                                      callerModel: analysisController.topCaller,
                                    );
                                  },
                                ),

                                ///LONGEST CALL
                                GetBuilder<AnalysisController>(
                                  builder: (controller) {
                                    return AnalysisCard(
                                      heading: "Longest Call",
                                      imagePath: ImageConstant.longestCallLogo,
                                      callerModel:
                                          analysisController.longestCaller,
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10.v),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ///TOP 10 Call duration
                                  GetBuilder<AnalysisController>(
                                    builder: (controller) {
                                      return AnalysisCard(
                                        heading: "Top 10 Call Duration",
                                        imagePath:
                                            ImageConstant.longestCallLogo,
                                        callerModel:
                                            analysisController.longestCaller,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  callMethods() {
    analysisController.selectedDateText == 'Today'
        ? analysisController.fetchTodayCallLogs()
        : analysisController.selectedDateText == 'Yesterday'
            ? analysisController.fetchYesterdayCallLogs()
            : analysisController.selectedDateText == 'Week'
                ? analysisController.fetchWeekCallLogs()
                : analysisController.selectedDateText == 'Month'
                    ? analysisController.fetchMonthCallLogs()
                    : analysisController.selectedDateText == 'Year'
                        ? analysisController.fetchYearCallLogs()
                        : analysisController.fetchCustomCallLogs(
                            analysisController.startDateMain,
                            analysisController.endDateMain);
  }
}

class CallData {
  final String callType;
  final int callCount;
  final int avgCallDuration; // in seconds

  CallData(this.callType, this.callCount, this.avgCallDuration);
}
