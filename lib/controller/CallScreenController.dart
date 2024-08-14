import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/core/utils/image_constant.dart';

/// controller specific for
class CallScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: myTabs.length, vsync: this);
    super.onInit();
  }

  final List<Tab> myTabs = [
    Tab(
      text: "All Calls",
      icon: SvgPicture.asset(
        ImageConstant.allCalls,
        height: 25,
        width: 24,
      ),
    ),
    Tab(
      text: "Incoming",
      icon: SvgPicture.asset(
        ImageConstant.incomingCalls,
        height: 25,
        width: 24,
      ),
    ),
    Tab(
      text: "Outgoing",
      icon: SvgPicture.asset(
        ImageConstant.outgoingCalls,
        height: 25,
        width: 24,
      ),
    ),
    Tab(
      text: "Missed",
      icon: SvgPicture.asset(
        ImageConstant.missedCalls,
        height: 25,
        width: 24,
      ),
    ),
    Tab(
      text: "Rejected",
      icon: SvgPicture.asset(
        ImageConstant.rejectedCalls,
        height: 25,
        width: 24,
      ),
    ),
  ];

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
