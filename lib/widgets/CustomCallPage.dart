import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/CallPageController.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/theme/custom_text_style.dart';
import 'package:mithilesh_s_application1/theme/theme_helper.dart';
import 'package:mithilesh_s_application1/widgets/CustomCallList.dart';

class CustomCallPage extends StatefulWidget {
  CustomCallPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CustomCallPage> createState() => _CustomCallPageState();
}

class _CustomCallPageState extends State<CustomCallPage> {
  TextEditingController searchController = TextEditingController();
  CallPageController callPageController = Get.put(CallPageController());

  @override
  void initState() {
    super.initState();
    callPageController.getFilteredCalls();
    searchController.addListener(() {});
  }

  getTitle() {
    if (widget.title == 'All Calls') {
      return 0;
    } else if (widget.title == 'Incoming') {
      return 1;
    } else if (widget.title == 'Outgoing') {
      return 2;
    } else if (widget.title == 'Missed') {
      return 3;
    } else if (widget.title == 'Rejected') {
      return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///search bar
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 5,
          ),
          child: TextField(
            onChanged: (value) => widget.title == 'Incoming'
                ? callPageController.getSearchedIncomingCallLogs(value)
                : widget.title == 'Outgoing'
                    ? callPageController.getSearchedOutgoingCallLogs(value)
                    : widget.title == 'Missed'
                        ? callPageController.getSearchedMissedCallLogs(value)
                        : widget.title == 'Rejected'
                            ? callPageController
                                .getSearchedRejectedCallLogs(value)
                            : callPageController.getSearchedCallLogs(value),
            textCapitalization: TextCapitalization.sentences,
            cursorColor: PrimaryColors().purple,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: PrimaryColors().purple,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: PrimaryColors().purple,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: PrimaryColors().purple,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Search",
              prefixIcon: Icon(
                Icons.search,
                color: PrimaryColors().purple,
              ),
            ),
          ),
        ),

        /// intro

        Padding(
          padding: EdgeInsets.only(
            left: 20.h,
            top: 7.v,
          ),
          child: GetBuilder<CallPageController>(
            builder: (value) => Text(
              callPageController.dateOfElement,
              style: CustomTextStyles.titleSmallSemiBold,
            ),
          ),
        ),

        /// call logs
        GetBuilder<CallPageController>(
          builder: (value) => CustomCallList(
              callLogs: getTitle() == 0
                  ? callPageController.searchedCallLogs
                  : getTitle() == 1
                      ? callPageController.incomingCallsLogs
                      : getTitle() == 2
                          ? callPageController.outgoingCallsLogs
                          : getTitle() == 3
                              ? callPageController.missedCallsLogs
                              : callPageController.rejectedCallsLogs),
        ),
      ],
    );
  }
}
