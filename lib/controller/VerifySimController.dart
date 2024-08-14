import 'package:call_log/call_log.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class VerifySimController extends GetxController {
  RxList callLogs = [].obs;
  RxList sortedCallLogs = [].obs;
  List<String> cardNums = [];

  RxList callLogsTwo = [].obs;
  RxList sortedCallLogsTwo = [].obs;
  List<String> cardNumsTwo = [];

  Future<List> getCallLogs() async {
    bool permissionGranted = await Permission.phone.status.isGranted;
    if (!permissionGranted) {
      await Permission.phone.request();
    }

    /// get call logs
    Iterable<CallLogEntry> entries = await CallLog.get();

    /// get first3 call records from call logs from sim 1
    entries.forEach((element) {
      if (element.phoneAccountId == "1" ||
          element.phoneAccountId == "2" ||
          element.simDisplayName == "SIM1" ||
          element.simDisplayName == "sim1") {
        callLogs.add(element);
      }
    });

    // store first 3 unieq number in sortedCallLogs from call logs list
    var temp = [];
    callLogs.forEach((element) {
      if (!cardNums.contains(element.number)) {
        cardNums.add(element.number);
        temp.add(element);
      }
    });

    for (int i = 0; i < 3; i++) {
      sortedCallLogs.add(temp[i]);
    }
    print("Temp list is $temp");
    print("Sorted call logs is $sortedCallLogs");
    for (int i = 0; i < sortedCallLogs.length; i++) {
      if (sortedCallLogs[i].number == callLogs[0].number) {
        break;
      }
      if (i == sortedCallLogs.length - 1) {
        sortedCallLogs.add(callLogs[0]);
      }
    }

    sortedCallLogs.shuffle();
    sortedCallLogs.shuffle();
    return sortedCallLogs;
  }

  Future<List> getCallLogsForSimTwo() async {
    bool permissionGranted = await Permission.phone.status.isGranted;
    if (!permissionGranted) {
      await Permission.phone.request();
    }

    /// get call logs
    Iterable<CallLogEntry> entries = await CallLog.get();

    /// get first3 call records from call logs from sim 1
    entries.forEach((element) {
      if (element.phoneAccountId == "3" ||
          element.phoneAccountId == "4" ||
          element.simDisplayName == "SIM2" ||
          element.simDisplayName == "sim2") {
        callLogsTwo.add(element);
      }
    });

    var temp = [];

    /// get first3 unique call records from call logs from sim 1
    callLogsTwo.forEach((element) {
      if (!cardNumsTwo.contains(element.number)) {
        cardNumsTwo.add(element.number);
        temp.add(element);
      }
    });

    for (int i = 0; i < 3; i++) {
      sortedCallLogsTwo.add(temp[i]);
    }
    for (int i = 0; i < sortedCallLogsTwo.length; i++) {
      if (sortedCallLogsTwo[i].number == callLogsTwo[0].number) {
        break;
      }
      if (i == sortedCallLogsTwo.length - 1) {
        sortedCallLogsTwo.add(callLogsTwo[0]);
      }
    }
    sortedCallLogsTwo.shuffle();
    sortedCallLogsTwo.shuffle();
    return sortedCallLogsTwo;
  }
}
