import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/CallScreenController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/controller/CallPageController.dart';
import 'package:mithilesh_s_application1/widgets/CustomCallPage.dart';

class CallsScreen extends StatefulWidget {
  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  final CallScreenController tabController = Get.put(CallScreenController());
  CallPageController callPageController = Get.put(CallPageController());

  @override
  void initState() {
    callPageController.getCallLogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColors().lightWhite,
      appBar: AppBar(
        backgroundColor: PrimaryColors().lightWhite,
        elevation: 0,
        title: Text(
          "Call History",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          Container(
            child: Obx(
              () => callPageController.simAllOnFlag.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          callPageController.simAllFlag.value = true;
                          callPageController.simTwoFlag.value = false;
                          callPageController.simOneFlag.value = false;

                          callPageController.getCallLogs();
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
                          callPageController.simOneFlag.value = true;
                          callPageController.simAllFlag.value = false;
                          callPageController.simTwoFlag.value = false;

                          callPageController.getSimOneContacts();
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
                          callPageController.simTwoFlag.value = true;
                          callPageController.simOneFlag.value = false;
                          callPageController.simAllFlag.value = false;

                          callPageController.getSimTwoContacts();
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.v),
          child: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelPadding: EdgeInsets.only(left: 0, right: 0),
            controller: tabController.tabController,
            tabs: tabController.myTabs,
          ),
        ),
      ),
      body: FutureBuilder(
        future: callPageController.getCallLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TabBarView(
              controller: tabController.tabController,
              children: [
                CustomCallPage(title: "All Calls"),
                CustomCallPage(title: "Incoming"),
                CustomCallPage(title: "Outgoing"),
                CustomCallPage(title: "Missed"),
                CustomCallPage(title: "Rejected"),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: PrimaryColors().purple,
              ),
            );
          }
        },
      ),
    );
  }
}
