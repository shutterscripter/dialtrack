import 'package:call_log/call_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';

class CallPageController extends GetxController {
  /// new way to get sim card names

  List<SimInfo>? simInfo;
  bool isSupported = true;

  /// new way to get sim card names

  List simCardNames = [];
  RxBool simOneFlag = false.obs;
  RxBool simTwoFlag = false.obs;
  RxBool simAllFlag = true.obs;
  RxBool simAllOnFlag = true.obs;
  RxBool simOneOnFlag = false.obs;
  RxBool simTwoOnFlag = false.obs;

  int indexOfElement = 0;
  String dateOfElement = "";
  RxString selectedCallType = "All Calls".obs;
  Map<String, List<CallLogEntry>> groupedLogs = {};
  RxList callLogs = [].obs;
  RxList callLogsSimOne = [].obs;
  RxList searchedCallLogs = [].obs;
  RxList allCallsLogs = [].obs;
  RxList incomingCallsLogs = [].obs;
  RxList outgoingCallsLogs = [].obs;
  RxList missedCallsLogs = [].obs;
  RxList rejectedCallsLogs = [].obs;
  RxInt selectedIndex = 0.obs;

  getIndexOfElement(value) {
    indexOfElement = value;
    update();
  }

  getDateOfElement(value) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(value);

    String dmy = date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();

    if (dmy ==
        DateTime.now().day.toString() +
            "/" +
            DateTime.now().month.toString() +
            "/" +
            DateTime.now().year.toString()) {
      dateOfElement = "Today";
    } else if (dmy ==
        DateTime.now().subtract(Duration(days: 1)).day.toString() +
            "/" +
            DateTime.now().subtract(Duration(days: 1)).month.toString() +
            "/" +
            DateTime.now().subtract(Duration(days: 1)).year.toString()) {
      dateOfElement = "Yesterday";
    } else {
      dateOfElement = dmy;
    }

    update();
  }

  ///function to update the index of the selected call type
  void updateIndex(RxString callType) {
    selectedCallType = callType;

    if (callType.value == 'All Calls') {
      selectedIndex = 0.obs;
    } else if (callType.value == 'Incoming') {
      selectedIndex = 1.obs;
    } else if (callType.value == 'Outgoing') {
      selectedIndex = 2.obs;
    } else if (callType.value == 'Missed') {
      selectedIndex = 3.obs;
    } else if (callType.value == 'Rejected') {
      selectedIndex = 4.obs;
    }
  }

  ///function to get call logs from the device and store it in the callLogs list
  getCallLogs() async {
    ///checking whether phone permission is granted or not
    bool permissionGranted = await Permission.phone.status.isGranted;
    if (!permissionGranted) {
      await Permission.phone.request();
    }

    Iterable<CallLogEntry> entries = await CallLog.get();
    int i = 0;
    for (CallLogEntry entry in entries) {
      if (i >= 3) break;
      String simSlot = '';
      if (entry.phoneAccountId!.contains("2") ||
          entry.phoneAccountId!.contains("1")) {
        simSlot = 'SIM 1';
      } else if (entry.phoneAccountId!.contains("4") ||
          entry.phoneAccountId!.contains("3")) {
        simSlot = 'SIM 2';
      }
      i++;
      // print(
      //     'contact name is ${entry.name} + ${entry.phoneAccountId} + $simSlot');
    }
    callLogs = entries.toList().obs;
    searchedCallLogs = entries.toList().obs;
    getFilteredCalls();
    await getSimNamesNew();

    /** map */
    for (CallLogEntry entry in entries) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp!);
      String dateKey = "${date.day}/${date.month}/${date.year}";
      if (groupedLogs[dateKey] == null) {
        groupedLogs[dateKey] = [];
      }
      groupedLogs[dateKey]?.add(entry);
    }
    update();

    ///calling storeDataToFireStore() when user is logged in
    ///TODO: Implement API to store data to Database
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      // print("Uploading data");
      storeDataToFireStore();
    }
  }

  /// function to get Sim one contactc
  getSimOneContacts() {
    searchedCallLogs = callLogs
        .where((element) =>
            element.phoneAccountId.contains("2") ||
            element.phoneAccountId.contains("1"))
        .toList()
        .obs;
    getFilteredCalls();
    update();
  }

  /// function to get Sim two contacts
  getSimTwoContacts() {
    searchedCallLogs = callLogs
        .where((element) =>
            element.phoneAccountId.contains("4") ||
            element.phoneAccountId.contains("3"))
        .toList()
        .obs;
    getFilteredCalls();
    update();
  }

  /// function to get all contacts
  Future<void> getSimNamesNew() async {
    /// new way to get sim card names
    final simCardInfoPlugin = SimCardInfo();
    List<SimInfo>? simCardInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      simCardInfo = await simCardInfoPlugin.getSimInfo() ?? [];
    } on PlatformException {
      simCardInfo = [];

      isSupported = false;
    }
    simInfo = simCardInfo;
    SimInfo simOne = simInfo![0];

    //
    // simCardNames = simInfo!.map((e) => e.displayName).toList();
    // simOneOnFlag.value = true;
    // simTwoOnFlag.value = true;

    if (simInfo!.length == 1) {
      String simOneName = simOne.displayName;
      simCardNames.add(simOneName); //adding sim one name into list of sim names
      simOneOnFlag.value = true;
      simTwoOnFlag.value = false;
    } else if (simInfo!.length == 2) {
      simOneOnFlag.value = true;
      simTwoOnFlag.value = true;
      //check if sim name present in list and then add
      String simOneName = simOne.displayName;

      if (!simCardNames.contains(simOneName)) {
        simCardNames
            .add(simOneName); //adding sim one name into list of sim names
      }
      SimInfo simTwo = simInfo![1];
      String simTwoName = simTwo.displayName;

      if (!simCardNames.contains(simTwoName)) {
        simCardNames
            .add(simTwoName); //adding sim two name into list of sim names
      }
      // print("sim one name :${simOneName}");
      // print("sim one name :${simTwoName}");
    } else {
      simOneOnFlag.value = false;
      simTwoOnFlag.value = false;
    }
  }

  /// search util for searching contacts
  getSearchedCallLogs(String query) async {
    await getCallLogs();
    if (query.isEmpty) {
      searchedCallLogs.value = callLogs;
      update();
      return;
    }

    searchedCallLogs.value = callLogs.where((element) {
      return (element.name ?? "").toLowerCase().contains(query.toLowerCase());
    }).toList();
    update();
  }

  getSearchedIncomingCallLogs(String query) async {
    await getCallLogs();
    if (query.isNotEmpty) {
      incomingCallsLogs.value = incomingCallsLogs.where((element) {
        return (element.name ?? "").toLowerCase().contains(query.toLowerCase());
      }).toList();
      update();
    }
  }

  getSearchedOutgoingCallLogs(String query) async {
    await getCallLogs();
    if (query.isNotEmpty) {
      outgoingCallsLogs.value = outgoingCallsLogs.where((element) {
        return (element.name ?? "").toLowerCase().contains(query.toLowerCase());
      }).toList();
      update();
    }
  }

  getSearchedMissedCallLogs(String query) async {
    await getCallLogs();
    if (query.isNotEmpty) {
      missedCallsLogs.value = missedCallsLogs.where((element) {
        return (element.name ?? "").toLowerCase().contains(query.toLowerCase());
      }).toList();
      update();
    }
  }

  getSearchedRejectedCallLogs(String query) async {
    await getCallLogs();
    if (query.isNotEmpty) {
      rejectedCallsLogs.value = rejectedCallsLogs.where((element) {
        return (element.name ?? "").toLowerCase().contains(query.toLowerCase());
      }).toList();
      update();
    }
  }

  getFilteredCalls() {
    allCallsLogs = callLogs;
    incomingCallsLogs = searchedCallLogs
        .where((element) => element.callType == CallType.incoming)
        .toList()
        .obs;
    outgoingCallsLogs = searchedCallLogs
        .where((element) => element.callType == CallType.outgoing)
        .toList()
        .obs;
    missedCallsLogs = searchedCallLogs
        .where((element) => element.callType == CallType.missed)
        .toList()
        .obs;
    rejectedCallsLogs = searchedCallLogs
        .where((element) => element.callType == CallType.rejected)
        .toList()
        .obs;
  }

  filterCallLogs() {
    if (selectedCallType.value == 'All Calls') {
      return callLogs;
    } else if (selectedCallType.value == 'Incoming') {
      return callLogs
          .where((element) => element.callType == CallType.incoming)
          .toList();
    } else if (selectedCallType.value == 'Outgoing') {
      return callLogs
          .where((element) => element.callType == CallType.outgoing)
          .toList();
    } else if (selectedCallType.value == 'Missed') {
      return callLogs
          .where((element) => element.callType == CallType.missed)
          .toList();
    } else if (selectedCallType.value == 'Rejected') {
      return callLogs
          .where((element) => element.callType == CallType.rejected)
          .toList();
    }
  }

  storeDataToFireStore() async {
    ///getting call logs for today only
    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);
    DateTime endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
    List todayCallLogs = callLogs
        .where((element) =>
            element.timestamp! >= startOfToday.millisecondsSinceEpoch &&
            element.timestamp! <= endOfToday.millisecondsSinceEpoch)
        .toList();

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final CollectionReference callLogsCollection =
        FirebaseFirestore.instance.collection('callLogs');
    for (var i = 0; i < todayCallLogs.length; i++) {
      CallLogEntry entry = todayCallLogs[i];
      String sim = entry.simDisplayName!;
      String name = entry.name ?? 'Unknown';
      String number = entry.number!;
      String formattedNumber = entry.formattedNumber ?? '';
      CallType callType = entry.callType!;
      int duration = entry.duration!;
      int timestamp = entry.timestamp!;
      int cachedNumberType = entry.cachedNumberType!;
      String cachedNumberLabel = entry.cachedNumberLabel ?? '';
      String cachedMatchedNumber = entry.cachedMatchedNumber!;
      String simDisplayName = entry.simDisplayName!;
      String phoneAccountId = entry.phoneAccountId!;

      await callLogsCollection.doc(uid).collection('logs').add({
        'sim': sim,
        'name': name,
        'number': number,
        'formattedNumber': formattedNumber,
        'callType': callType.toString(),
        'duration': duration,
        'timestamp': timestamp,
        'cachedNumberType': cachedNumberType,
        'cachedNumberLabel': cachedNumberLabel,
        'cachedMatchedNumber': cachedMatchedNumber,
        'simDisplayName': simDisplayName,
        'phoneAccountId': phoneAccountId,
      });
    }
  }
}

class CallEn {
  CallEn({
    this.name,
    this.number,
    this.formattedNumber,
    this.callType,
    this.duration,
    this.timestamp,
    this.cachedNumberType,
    this.cachedNumberLabel,
    this.simDisplayName,
    this.phoneAccountId,
  });

  String? name;
  String? number;
  String? formattedNumber;
  CallType? callType;
  int? duration;
  int? timestamp;
  int? cachedNumberType;
  String? cachedNumberLabel;
  String? cachedMatchedNumber;
  String? simDisplayName;
  String? phoneAccountId;
}
