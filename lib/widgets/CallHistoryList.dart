import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/CallPageController.dart';

class CallHistoryList extends StatelessWidget {
  Map<String, List<CallLogEntry>> groupedLogs = {};

  CallHistoryList({Key? key, required this.groupedLogs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get the list in groupedLogs and display it in listview
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('title'),
          subtitle: Text('subtitle'),
        );
      },
    );
  }
}
