import 'dart:collection';
import 'package:call_log/call_log.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/bottom_nav_controller.dart';
import 'package:mithilesh_s_application1/presentation/analytics_screen/CallerModel.dart';
import 'package:mithilesh_s_application1/presentation/analytics_screen/AnalyticsScreen.dart';

/// Analysis controller help to fetch call log data from device
class AnalysisController extends GetxController {
  bool hasPremium = false;
  BottomNavController bottomNavController = Get.put(BottomNavController());
  String selectedDateText = "Today";
  String toAndFromDateText =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  int sim = 0;
  DateTime startDateMain = DateTime.now();
  DateTime endDateMain = DateTime.now();
  Map<String, AnaModel> topCallerHashmap = HashMap();
  Map<String, AnaModel> longCallHashMap = HashMap();
  RxBool simOneFlag = false.obs;
  RxBool simTwoFlag = false.obs;
  RxBool simAllFlag = true.obs;
  RxBool simAllOnFlag = true.obs;
  RxBool simOneOnFlag = false.obs;
  RxBool simTwoOnFlag = false.obs;
  List totalPhoneCalls = [];
  List totalIncomingCalls = [];
  List totalOutgoingCalls = [];
  List totalMissedCalls = [];
  List totalRejectedCalls = [];
  List totalNeverAttendedCalls = [];
  List totalConnectedCalls = [];
  List totalUniqueCalls = [];
  List totalNotPickedByClient = [];

  CallerModel topCaller = CallerModel(
    callerName: '',
    callerNumber: '',
    callCount: 0,
    totalDuration: 0,
    incomingCalls: 0,
    outgoingCalls: 0,
    missedCalls: 0,
  );
  CallerModel longestCaller = CallerModel(
    callerName: '',
    callerNumber: '',
    callCount: 0,
    totalDuration: 0,
    incomingCalls: 0,
    outgoingCalls: 0,
    missedCalls: 0,
  );
  List<CallData> callData = [];
  int totalCallCount = 0;
  int totalCallDuration = 0;
  DateTime selectedDate = DateTime.now();
  bool isLoading = true; // Track whether data is being loaded
  int incomingCalls = 0;
  int incomingCallDuration = 0;
  int outgoingCalls = 0;
  int outgoingCallDuration = 0;
  int missedCalls = 0;
  int neverAttendedCalls = 0;

  /// select date function to select date from calendar
  /// this function is called when user click on select date button
  /// this function will open calendar and user can select date
  /// after selecting date it will call fetchCallLogData function
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      print("picked date $picked"); //: picked date 2024-01-07 00:00:00.000
      update();
      fetchCallLogData(picked);
      update();
    }
  }

  ///fetchCallLogData function to fetch call log data from device
  ///this function will fetch call log data from device and store it in callData list
  ///this function will also find top caller and longest call by calling findTopCaller and findLongestCall function
  Future<void> fetchCallLogData(DateTime selectedDate) async {
    var callLog = await CallLog.query(
      dateFrom: selectedDate.millisecondsSinceEpoch,
      dateTo: selectedDate.add(Duration(days: 1)).millisecondsSinceEpoch,
    );

    totalPhoneCalls = callLog.toList();
    totalIncomingCalls = callLog
        .where((element) => element.callType == CallType.incoming)
        .toList();

    totalOutgoingCalls = callLog
        .where((element) => element.callType == CallType.outgoing)
        .toList();

    ///missed calls
    totalMissedCalls = callLog
        .where((element) => element.callType == CallType.missed)
        .toList();

    ///rejected calls
    totalRejectedCalls = callLog
        .where((element) => element.callType == CallType.rejected)
        .toList();

    /// connected calls
    totalConnectedCalls = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! > 1))
        .toList();

    ///not picked by client
    totalNotPickedByClient = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! <= 0))
        .toList();

    /// Never attended calls
    List outgoingNumbers =
        totalOutgoingCalls.map((call) => call.number).toList();
    totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
      return !outgoingNumbers.contains(missedCall.number);
    }).toList();

    if (sim == 1) {
      callLog = callLog
          .where((element) => element.phoneAccountId!.contains("2"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    } else if (sim == 2) {
      callLog = callLog
          .where((element) => element.phoneAccountId!.contains("4"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    }

    isLoading = true;
    totalCallCount = 0;
    totalCallDuration = 0;
    int incomingCalls = 0;
    int outgoingCalls = 0;
    int missedCalls = 0;
    int incomingCallDuration = 0;
    int outgoingCallDuration = 0;
    update();

    /** getting call data and storing inside the call analysis list*/
    topCallerHashmap = HashMap();
    callLog.forEach((record) {
      String name = record.name ?? "Unknown";
      String number = record.number ?? "Unknown";
      int duration = record.duration ?? 0;
      String callType = record.callType == CallType.incoming
          ? "Incoming"
          : record.callType == CallType.outgoing
              ? "Outgoing"
              : "Missed";

      topCallerHashmap.containsKey(name)
          ? topCallerHashmap[name] = AnaModel(
              name,
              number,
              topCallerHashmap[name]!.totalCalls + 1,
              topCallerHashmap[name]!.duration + duration,
              callType)
          : topCallerHashmap[name] =
              AnaModel(name, number, 1, duration, callType);
    });

    /** sorting the hashmap in descending order */
    topCallerHashmap = Map.fromEntries(topCallerHashmap.entries.toList()
      ..sort((e1, e2) => e2.value.totalCalls.compareTo(e1.value.totalCalls)));
    /**end*/

    callLog.forEach((log) {
      final callType = log.callType;
      var callDuration = log.duration;

      /// convert duration from seconds to minutes
      callDuration = callDuration!;
      totalCallDuration += callDuration;

      if (callType == CallType.incoming) {
        totalCallCount++;
        incomingCalls++;
        incomingCallDuration += callDuration;
      } else if (callType == CallType.outgoing) {
        totalCallCount++;
        outgoingCalls++;
        outgoingCallDuration += callDuration;
      } else if (callType == CallType.missed) {
        totalCallCount++;
        missedCalls++;
      }
    });
    //sets values for respective calls

    callData = [
      CallData("Incoming", incomingCalls, incomingCallDuration),
      CallData("Outgoing", outgoingCalls, outgoingCallDuration),
      CallData("Missed", missedCalls, 0),
    ];
    isLoading = false;
    getValues();
    update();
  }

  /// fetchCallLogData function to fetch call log data from device for today
  Future<void> fetchTodayCallLogs() async {
    //get today's date from  today date like 2024-01-08 00:00:00.00
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    var callLog = await CallLog.query(
      dateFrom: date.millisecondsSinceEpoch,
      dateTo: date.add(Duration(days: 1)).millisecondsSinceEpoch,
    );
    totalPhoneCalls = callLog.toList();
    //store incoming calls in totalIncomingCalls list
    totalIncomingCalls = callLog
        .where((element) => element.callType == CallType.incoming)
        .toList();
    totalOutgoingCalls = callLog
        .where((element) => element.callType == CallType.outgoing)
        .toList();

    ///missed calls
    totalMissedCalls = callLog
        .where((element) => element.callType == CallType.missed)
        .toList();

    ///rejected calls
    totalRejectedCalls = callLog
        .where((element) => element.callType == CallType.rejected)
        .toList();

    /// connected calls
    totalConnectedCalls = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! > 1))
        .toList();

    ///not picked by client
    totalNotPickedByClient = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! <= 0))
        .toList();

    /// Never attended calls
    List outgoingNumbers =
        totalOutgoingCalls.map((call) => call.number).toList();
    totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
      return !outgoingNumbers.contains(missedCall.number);
    }).toList();
    if (sim == 1) {
      callLog = callLog
          .where((element) =>
              element.phoneAccountId!.contains("2") ||
              element.phoneAccountId!.contains("1"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    } else if (sim == 2) {
      callLog = callLog
          .where((element) =>
              element.phoneAccountId!.contains("4") ||
              element.phoneAccountId!.contains("3"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    }

    selectedDateText = "Today";
    toAndFromDateText = "${now.day}/${now.month}/${now.year}";
    isLoading = true;
    totalCallCount = 0;
    totalCallDuration = 0;
    int incomingCalls = 0;
    int outgoingCalls = 0;
    int missedCalls = 0;
    int incomingCallDuration = 0;
    int outgoingCallDuration = 0;
    update();

    /** getting call data and storing inside the call analysis list*/
    topCallerHashmap = HashMap();
    callLog.forEach((record) {
      String name = record.name ?? "Unknown";
      String number = record.number ?? "Unknown";
      int duration = record.duration ?? 0;
      String callType = record.callType == CallType.incoming
          ? "Incoming"
          : record.callType == CallType.outgoing
              ? "Outgoing"
              : "Missed";

      topCallerHashmap.containsKey(name)
          ? topCallerHashmap[name] = AnaModel(
              name,
              number,
              topCallerHashmap[name]!.totalCalls + 1,
              topCallerHashmap[name]!.duration + duration,
              callType)
          : topCallerHashmap[name] =
              AnaModel(name, number, 1, duration, callType);
    });

    /** sorting the hashmap in descending order */
    topCallerHashmap = Map.fromEntries(topCallerHashmap.entries.toList()
      ..sort((e1, e2) => e2.value.totalCalls.compareTo(e1.value.totalCalls)));
    /**end*/

    callLog.forEach((log) {
      final callType = log.callType;
      var callDuration = log.duration;

      /// convert duration from seconds to minutes
      callDuration = callDuration!;
      totalCallDuration += callDuration;

      if (callType == CallType.incoming) {
        totalCallCount++;
        incomingCalls++;
        incomingCallDuration += callDuration;
      } else if (callType == CallType.outgoing) {
        totalCallCount++;
        outgoingCalls++;
        outgoingCallDuration += callDuration;
      } else if (callType == CallType.missed) {
        totalCallCount++;
        missedCalls++;
      }
    });
    //sets values for respective calls

    callData = [
      CallData("Incoming", incomingCalls, incomingCallDuration),
      CallData("Outgoing", outgoingCalls, outgoingCallDuration),
      CallData("Missed", missedCalls, 0),
    ];
    isLoading = false;
    getValues();
    update();
  }

  /// fetchCallLogData function to fetch call log data from device for yesterday
  Future<void> fetchYesterdayCallLogs() async {
    //get yesterdays date
    DateTime yesterdaysDate = DateTime.now().subtract(Duration(days: 1));

    var callLog = await CallLog.query(
      dateFrom: yesterdaysDate.millisecondsSinceEpoch,
      dateTo: yesterdaysDate.add(Duration(days: 1)).millisecondsSinceEpoch,
    );
    totalPhoneCalls = callLog.toList();
    totalIncomingCalls = callLog
        .where((element) => element.callType == CallType.incoming)
        .toList();
    totalOutgoingCalls = callLog
        .where((element) => element.callType == CallType.outgoing)
        .toList();

    ///missed calls
    totalMissedCalls = callLog
        .where((element) => element.callType == CallType.missed)
        .toList();

    ///rejected calls
    totalRejectedCalls = callLog
        .where((element) => element.callType == CallType.rejected)
        .toList();

    /// connected calls
    totalConnectedCalls = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! > 1))
        .toList();

    ///not picked by client
    totalNotPickedByClient = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! <= 0))
        .toList();

    /// Never attended calls
    List outgoingNumbers =
        totalOutgoingCalls.map((call) => call.number).toList();
    totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
      return !outgoingNumbers.contains(missedCall.number);
    }).toList();
    if (sim == 1) {
      callLog = callLog
          .where((element) =>
              element.phoneAccountId!.contains("2") ||
              element.phoneAccountId!.contains("1"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    } else if (sim == 2) {
      callLog = callLog
          .where((element) =>
              element.phoneAccountId!.contains("4") ||
              element.phoneAccountId!.contains("3"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    }

    selectedDateText = "Yesterday";
    DateTime to = yesterdaysDate.add(Duration(days: 1));
    toAndFromDateText =
        "${yesterdaysDate.day}/${yesterdaysDate.month}/${yesterdaysDate.year} - ${to.day}/${to.month}/${to.year}";
    isLoading = true;
    totalCallCount = 0;
    totalCallDuration = 0;
    int incomingCalls = 0;
    int outgoingCalls = 0;
    int missedCalls = 0;
    int incomingCallDuration = 0;
    int outgoingCallDuration = 0;
    update();

    /** getting call data and storing inside the call analysis list*/
    topCallerHashmap = HashMap();
    callLog.forEach((record) {
      String name = record.name ?? "Unknown";
      String number = record.number ?? "Unknown";
      int duration = record.duration ?? 0;
      String callType = record.callType == CallType.incoming
          ? "Incoming"
          : record.callType == CallType.outgoing
              ? "Outgoing"
              : "Missed";

      topCallerHashmap.containsKey(name)
          ? topCallerHashmap[name] = AnaModel(
              name,
              number,
              topCallerHashmap[name]!.totalCalls + 1,
              topCallerHashmap[name]!.duration + duration,
              callType)
          : topCallerHashmap[name] =
              AnaModel(name, number, 1, duration, callType);
    });

    /** sorting the hashmap in descending order */
    topCallerHashmap = Map.fromEntries(topCallerHashmap.entries.toList()
      ..sort((e1, e2) => e2.value.totalCalls.compareTo(e1.value.totalCalls)));
    /**end*/

    callLog.forEach((log) {
      final callType = log.callType;
      var callDuration = log.duration;

      /// convert duration from seconds to minutes
      callDuration = callDuration!;
      totalCallDuration += callDuration;

      if (callType == CallType.incoming) {
        totalCallCount++;
        incomingCalls++;
        incomingCallDuration += callDuration;
      } else if (callType == CallType.outgoing) {
        totalCallCount++;
        outgoingCalls++;
        outgoingCallDuration += callDuration;
      } else if (callType == CallType.missed) {
        totalCallCount++;
        missedCalls++;
      }
    });
    //sets values for respective calls

    callData = [
      CallData("Incoming", incomingCalls, incomingCallDuration),
      CallData("Outgoing", outgoingCalls, outgoingCallDuration),
      CallData("Missed", missedCalls, 0),
    ];
    isLoading = false;
    getValues();
    update();
  }

  /// fetchCallLogData function to fetch call log data from device for last 7 days - a week
  Future<void> fetchWeekCallLogs() async {
    //get last 7 days date
    DateTime last7DaysDate = DateTime.now().subtract(Duration(days: 7));
    var callLog = await CallLog.query(
      dateFrom: last7DaysDate.millisecondsSinceEpoch,
      dateTo: last7DaysDate.add(Duration(days: 7)).millisecondsSinceEpoch,
    );
    totalPhoneCalls = callLog.toList();
    totalIncomingCalls = callLog
        .where((element) => element.callType == CallType.incoming)
        .toList();
    totalOutgoingCalls = callLog
        .where((element) => element.callType == CallType.outgoing)
        .toList();

    ///missed calls
    totalMissedCalls = callLog
        .where((element) => element.callType == CallType.missed)
        .toList();

    ///rejected calls
    totalRejectedCalls = callLog
        .where((element) => element.callType == CallType.rejected)
        .toList();

    /// connected calls
    totalConnectedCalls = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! > 1))
        .toList();

    ///not picked by client
    totalNotPickedByClient = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! <= 0))
        .toList();

    /// Never attended calls
    List outgoingNumbers =
        totalOutgoingCalls.map((call) => call.number).toList();
    totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
      return !outgoingNumbers.contains(missedCall.number);
    }).toList();
    if (sim == 1) {
      callLog = callLog
          .where((element) => element.phoneAccountId!.contains("2"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    } else if (sim == 2) {
      callLog = callLog
          .where((element) => element.phoneAccountId!.contains("4"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    }

    selectedDateText = "Week";
    DateTime to = last7DaysDate.add(Duration(days: 7));
    toAndFromDateText =
        "${last7DaysDate.day}/${last7DaysDate.month}/${last7DaysDate.year} - ${to.day}/${to.month}/${to.year}";
    isLoading = true;
    totalCallCount = 0;
    totalCallDuration = 0;
    int incomingCalls = 0;
    int outgoingCalls = 0;
    int missedCalls = 0;
    int incomingCallDuration = 0;
    int outgoingCallDuration = 0;
    update();

    /** getting call data and storing inside the call analysis list*/
    topCallerHashmap = HashMap();
    callLog.forEach((record) {
      String name = record.name ?? "Unknown";
      String number = record.number ?? "Unknown";
      int duration = record.duration ?? 0;
      String callType = record.callType == CallType.incoming
          ? "Incoming"
          : record.callType == CallType.outgoing
              ? "Outgoing"
              : "Missed";

      topCallerHashmap.containsKey(name)
          ? topCallerHashmap[name] = AnaModel(
              name,
              number,
              topCallerHashmap[name]!.totalCalls + 1,
              topCallerHashmap[name]!.duration + duration,
              callType)
          : topCallerHashmap[name] =
              AnaModel(name, number, 1, duration, callType);
    });

    /** sorting the hashmap in descending order */
    topCallerHashmap = Map.fromEntries(topCallerHashmap.entries.toList()
      ..sort((e1, e2) => e2.value.totalCalls.compareTo(e1.value.totalCalls)));
    /**end*/

    callLog.forEach((log) {
      final callType = log.callType;
      var callDuration = log.duration;

      /// convert duration from seconds to minutes
      callDuration = callDuration!;
      totalCallDuration += callDuration;

      if (callType == CallType.incoming) {
        totalCallCount++;
        incomingCalls++;
        incomingCallDuration += callDuration;
      } else if (callType == CallType.outgoing) {
        totalCallCount++;
        outgoingCalls++;
        outgoingCallDuration += callDuration;
      } else if (callType == CallType.missed) {
        totalCallCount++;
        missedCalls++;
      }
    });
    //sets values for respective calls

    callData = [
      CallData("Incoming", incomingCalls, incomingCallDuration),
      CallData("Outgoing", outgoingCalls, outgoingCallDuration),
      CallData("Missed", missedCalls, 0),
    ];
    isLoading = false;
    getValues();
    update();
  }

  /// fetchCallLogData function to fetch call log data from device for last 30 days- a month
  Future<void> fetchMonthCallLogs() async {
    //get last 30 days date
    DateTime last30DaysDate = DateTime.now().subtract(Duration(days: 30));
    DateTime to = last30DaysDate.add(Duration(days: 30));
    var callLog = await CallLog.query(
      dateFrom: last30DaysDate.millisecondsSinceEpoch,
      dateTo: last30DaysDate.add(Duration(days: 30)).millisecondsSinceEpoch,
    );
    totalPhoneCalls = callLog.toList();
    totalIncomingCalls = callLog
        .where((element) => element.callType == CallType.incoming)
        .toList();
    totalOutgoingCalls = callLog
        .where((element) => element.callType == CallType.outgoing)
        .toList();

    ///missed calls
    totalMissedCalls = callLog
        .where((element) => element.callType == CallType.missed)
        .toList();

    ///rejected calls
    totalRejectedCalls = callLog
        .where((element) => element.callType == CallType.rejected)
        .toList();

    /// connected calls
    totalConnectedCalls = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! > 1))
        .toList();

    ///not picked by client
    totalNotPickedByClient = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! <= 0))
        .toList();

    /// Never attended calls
    List outgoingNumbers =
        totalOutgoingCalls.map((call) => call.number).toList();
    totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
      return !outgoingNumbers.contains(missedCall.number);
    }).toList();

    if (sim == 1) {
      callLog = callLog
          .where((element) => element.phoneAccountId!.contains("2"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    } else if (sim == 2) {
      callLog = callLog
          .where((element) => element.phoneAccountId!.contains("4"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    }

    selectedDateText = "Month";
    toAndFromDateText =
        "${last30DaysDate.day}/${last30DaysDate.month}/${last30DaysDate.year} - ${to.day}/${to.month}/${to.year}";
    isLoading = true;
    totalCallCount = 0;
    totalCallDuration = 0;
    int incomingCalls = 0;
    int outgoingCalls = 0;
    int missedCalls = 0;
    int incomingCallDuration = 0;
    int outgoingCallDuration = 0;
    update();

    /** getting call data and storing inside the call analysis list*/
    topCallerHashmap = HashMap();
    callLog.forEach((record) {
      String name = record.name ?? "Unknown";
      String number = record.number ?? "Unknown";
      int duration = record.duration ?? 0;
      String callType = record.callType == CallType.incoming
          ? "Incoming"
          : record.callType == CallType.outgoing
              ? "Outgoing"
              : "Missed";

      topCallerHashmap.containsKey(name)
          ? topCallerHashmap[name] = AnaModel(
              name,
              number,
              topCallerHashmap[name]!.totalCalls + 1,
              topCallerHashmap[name]!.duration + duration,
              callType)
          : topCallerHashmap[name] =
              AnaModel(name, number, 1, duration, callType);
    });

    /** sorting the hashmap in descending order */
    topCallerHashmap = Map.fromEntries(topCallerHashmap.entries.toList()
      ..sort((e1, e2) => e2.value.totalCalls.compareTo(e1.value.totalCalls)));
    /**end*/

    callLog.forEach((log) {
      final callType = log.callType;
      var callDuration = log.duration;

      /// convert duration from seconds to minutes
      callDuration = callDuration!;
      totalCallDuration += callDuration;

      if (callType == CallType.incoming) {
        totalCallCount++;
        incomingCalls++;
        incomingCallDuration += callDuration;
      } else if (callType == CallType.outgoing) {
        totalCallCount++;
        outgoingCalls++;
        outgoingCallDuration += callDuration;
      } else if (callType == CallType.missed) {
        totalCallCount++;
        missedCalls++;
      }
    });
    //sets values for respective calls

    callData = [
      CallData("Incoming", incomingCalls, incomingCallDuration),
      CallData("Outgoing", outgoingCalls, outgoingCallDuration),
      CallData("Missed", missedCalls, 0),
    ];
    isLoading = false;
    getValues();
    update();
  }

  /// fetchCallLogData function to fetch call log data from device for last 365 days- a year
  Future<void> fetchYearCallLogs() async {
    //get last 365 days date
    DateTime last365DaysDate = DateTime.now().subtract(Duration(days: 365));
    var callLog = await CallLog.query(
      dateFrom: last365DaysDate.millisecondsSinceEpoch,
      dateTo: last365DaysDate.add(Duration(days: 365)).millisecondsSinceEpoch,
    );
    totalPhoneCalls = callLog.toList();
    totalIncomingCalls = callLog
        .where((element) => element.callType == CallType.incoming)
        .toList();
    totalOutgoingCalls = callLog
        .where((element) => element.callType == CallType.outgoing)
        .toList();

    ///missed calls
    totalMissedCalls = callLog
        .where((element) => element.callType == CallType.missed)
        .toList();

    ///rejected calls
    totalRejectedCalls = callLog
        .where((element) => element.callType == CallType.rejected)
        .toList();

    /// connected calls
    totalConnectedCalls = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! > 1))
        .toList();

    ///not picked by client
    totalNotPickedByClient = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! <= 0))
        .toList();

    /// Never attended calls
    List outgoingNumbers =
        totalOutgoingCalls.map((call) => call.number).toList();
    totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
      return !outgoingNumbers.contains(missedCall.number);
    }).toList();

    if (sim == 1) {
      callLog = callLog
          .where((element) => element.phoneAccountId!.contains("2"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    } else if (sim == 2) {
      callLog = callLog
          .where((element) => element.phoneAccountId!.contains("4"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalIncomingCalls = callLog
          .where((element) => element.callType == CallType.incoming)
          .toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    }

    selectedDateText = "Year";
    DateTime to = last365DaysDate.add(Duration(days: 365));
    toAndFromDateText =
        "${last365DaysDate.day}/${last365DaysDate.month}/${last365DaysDate.year} - ${to.day}/${to.month}/${to.year}";
    isLoading = true;
    totalCallCount = 0;
    totalCallDuration = 0;
    int incomingCalls = 0;
    int outgoingCalls = 0;
    int missedCalls = 0;
    int incomingCallDuration = 0;
    int outgoingCallDuration = 0;
    update();

    /** getting call data and storing inside the call analysis list*/
    topCallerHashmap = HashMap();
    callLog.forEach((record) {
      String name = record.name ?? "Unknown";
      String number = record.number ?? "Unknown";
      int duration = record.duration ?? 0;
      String callType = record.callType == CallType.incoming
          ? "Incoming"
          : record.callType == CallType.outgoing
              ? "Outgoing"
              : "Missed";

      topCallerHashmap.containsKey(name)
          ? topCallerHashmap[name] = AnaModel(
              name,
              number,
              topCallerHashmap[name]!.totalCalls + 1,
              topCallerHashmap[name]!.duration + duration,
              callType)
          : topCallerHashmap[name] =
              AnaModel(name, number, 1, duration, callType);
    });

    /** sorting the hashmap in descending order */
    topCallerHashmap = Map.fromEntries(topCallerHashmap.entries.toList()
      ..sort((e1, e2) => e2.value.totalCalls.compareTo(e1.value.totalCalls)));
    /**end*/

    callLog.forEach((log) {
      final callType = log.callType;
      var callDuration = log.duration;

      /// convert duration from seconds to minutes
      callDuration = callDuration!;
      totalCallDuration += callDuration;

      if (callType == CallType.incoming) {
        totalCallCount++;
        incomingCalls++;
        incomingCallDuration += callDuration;
      } else if (callType == CallType.outgoing) {
        totalCallCount++;
        outgoingCalls++;
        outgoingCallDuration += callDuration;
      } else if (callType == CallType.missed) {
        totalCallCount++;
        missedCalls++;
      }
    });
    //sets values for respective calls

    callData = [
      CallData("Incoming", incomingCalls, incomingCallDuration),
      CallData("Outgoing", outgoingCalls, outgoingCallDuration),
      CallData("Missed", missedCalls, 0),
    ];
    isLoading = false;
    getValues();
    update();
  }

  /// fetchCallLogData function to fetch call log data from device for custom dates range
  Future<void> fetchCustomCallLogs(start, end) async {
    // custom date range
    DateTime startDate = start;
    DateTime endDate = end;
    startDateMain = startDate;
    endDateMain = endDate;
    var callLog = await CallLog.query(
      dateFrom: startDate.millisecondsSinceEpoch,
      dateTo: endDate.millisecondsSinceEpoch,
    );
    totalPhoneCalls = callLog.toList();
    totalOutgoingCalls = callLog
        .where((element) => element.callType == CallType.outgoing)
        .toList();

    ///missed calls
    totalMissedCalls = callLog
        .where((element) => element.callType == CallType.missed)
        .toList();

    ///rejected calls
    totalRejectedCalls = callLog
        .where((element) => element.callType == CallType.rejected)
        .toList();

    /// connected calls
    totalConnectedCalls = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! > 1))
        .toList();

    ///not picked by client
    totalNotPickedByClient = callLog
        .where((element) =>
            element.callType == CallType.outgoing && (element.duration! <= 0))
        .toList();

    /// Never attended calls
    List outgoingNumbers =
        totalOutgoingCalls.map((call) => call.number).toList();
    totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
      return !outgoingNumbers.contains(missedCall.number);
    }).toList();
    if (sim == 1) {
      callLog = callLog
          .where((element) => element.phoneAccountId!.contains("2"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    } else if (sim == 2) {
      callLog = callLog
          .where((element) => element.phoneAccountId!.contains("4"))
          .toList();
      totalPhoneCalls = callLog.toList();
      totalOutgoingCalls = callLog
          .where((element) => element.callType == CallType.outgoing)
          .toList();

      ///missed calls
      totalMissedCalls = callLog
          .where((element) => element.callType == CallType.missed)
          .toList();

      ///rejected calls
      totalRejectedCalls = callLog
          .where((element) => element.callType == CallType.rejected)
          .toList();

      /// connected calls
      totalConnectedCalls = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! > 1))
          .toList();

      ///not picked by client
      totalNotPickedByClient = callLog
          .where((element) =>
              element.callType == CallType.outgoing && (element.duration! <= 0))
          .toList();

      /// Never attended calls
      List outgoingNumbers =
          totalOutgoingCalls.map((call) => call.number).toList();
      totalNeverAttendedCalls = totalMissedCalls.where((missedCall) {
        return !outgoingNumbers.contains(missedCall.number);
      }).toList();
    }

    selectedDateText = "Custom";
    toAndFromDateText =
        "${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}";
    isLoading = true;
    totalCallCount = 0;
    totalCallDuration = 0;
    int incomingCalls = 0;
    int outgoingCalls = 0;
    int missedCalls = 0;
    int incomingCallDuration = 0;
    int outgoingCallDuration = 0;
    update();

    /** getting call data and storing inside the call analysis list*/
    topCallerHashmap = HashMap();
    callLog.forEach((record) {
      String name = record.name ?? "Unknown";
      String number = record.number ?? "Unknown";
      int duration = record.duration ?? 0;
      String callType = record.callType == CallType.incoming
          ? "Incoming"
          : record.callType == CallType.outgoing
              ? "Outgoing"
              : "Missed";

      topCallerHashmap.containsKey(name)
          ? topCallerHashmap[name] = AnaModel(
              name,
              number,
              topCallerHashmap[name]!.totalCalls + 1,
              topCallerHashmap[name]!.duration + duration,
              callType)
          : topCallerHashmap[name] =
              AnaModel(name, number, 1, duration, callType);
    });

    /** sorting the hashmap in descending order */
    topCallerHashmap = Map.fromEntries(topCallerHashmap.entries.toList()
      ..sort((e1, e2) => e2.value.totalCalls.compareTo(e1.value.totalCalls)));
    /**end*/

    callLog.forEach((log) {
      final callType = log.callType;
      var callDuration = log.duration;

      /// convert duration from seconds to minutes
      callDuration = callDuration!;
      totalCallDuration += callDuration;

      if (callType == CallType.incoming) {
        totalCallCount++;
        incomingCalls++;
        incomingCallDuration += callDuration;
      } else if (callType == CallType.outgoing) {
        totalCallCount++;
        outgoingCalls++;
        outgoingCallDuration += callDuration;
      } else if (callType == CallType.missed) {
        totalCallCount++;
        missedCalls++;
      }
    });
    //sets values for respective calls

    callData = [
      CallData("Incoming", incomingCalls, incomingCallDuration),
      CallData("Outgoing", outgoingCalls, outgoingCallDuration),
      CallData("Missed", missedCalls, 0),
    ];
    isLoading = false;
    getValues();
    update();
  }

  List<charts.Series<CallData, String>> createSeries() {
    return [
      charts.Series<CallData, String>(
        id: 'Calls',
        domainFn: (CallData data, _) => data.callType,
        measureFn: (CallData data, _) => data.callCount,
        data: callData,
        labelAccessorFn: (CallData data, _) => data.callCount.toString(),
        colorFn: (CallData data, _) {
          switch (data.callType) {
            case "Incoming":
              return charts.ColorUtil.fromDartColor(Colors.lightGreen);
            case "Outgoing":
              return charts.ColorUtil.fromDartColor(Colors.orange);
            case "Missed":
              return charts.ColorUtil.fromDartColor(Colors.red);
            default:
              return charts.ColorUtil.fromDartColor(Colors.black);
          }
        },
      ),
    ];
  }

  void getLongestCall() {
    longCallHashMap = HashMap();
    longCallHashMap = Map.fromEntries(topCallerHashmap.entries.toList()
      ..sort((e1, e2) => e2.value.duration.compareTo(e1.value.duration)));
  }

  void getValues() {
    ///variables used for chartsScreen UI to display data like incoming, outgoing, missed calls
    incomingCalls = callData.isNotEmpty ? callData[0].callCount : 0;
    incomingCallDuration =
        callData.isNotEmpty ? callData[0].avgCallDuration : 0;
    outgoingCalls = callData.isNotEmpty ? callData[1].callCount : 0;
    outgoingCallDuration =
        callData.isNotEmpty ? callData[1].avgCallDuration : 0;
    missedCalls = callData.isNotEmpty ? callData[2].callCount : 0;

    ///variables used for top caller UI to display data like top caller name, number, call count, total duration
    AnaModel temp = topCallerHashmap.isNotEmpty
        ? topCallerHashmap.values.first
        : AnaModel("Unknown", "Unknown", 0, 0, "Unknown");
    topCaller = CallerModel(
        callerName: temp.name,
        callerNumber: temp.number,
        callCount: temp.totalCalls,
        totalDuration: temp.duration,
        incomingCalls: 0,
        outgoingCalls: 0,
        missedCalls: 0);

    getLongestCall();
    AnaModel longestcall = longCallHashMap.isNotEmpty
        ? longCallHashMap.values.first
        : AnaModel("Unknown", "Unknown", 0, 0, "Unknown");
    longestCaller = CallerModel(
        callerName: longestcall.name,
        callerNumber: longestcall.number,
        callCount: longestcall.totalCalls,
        totalDuration: longestcall.duration,
        incomingCalls: 0,
        outgoingCalls: 0,
        missedCalls: 0);
    update();
  }

  void checkIfHasPremiere() {
    if (hasPremium) {
      print("has premium");
    } else {
      bottomNavController.animateToTab(2);
    }
  }
}

class AnaModel {
  String name;
  String number;
  int totalCalls;
  int duration;
  String callType;

  AnaModel(
      this.name, this.number, this.totalCalls, this.duration, this.callType);
}
