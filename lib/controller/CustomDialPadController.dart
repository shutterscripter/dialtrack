import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';

class CustomDialPadController extends GetxController {
  final DirectCaller directCaller = DirectCaller();
  final textField = TextEditingController();
  RxBool simOneFlag = false.obs;
  RxBool simTwoFlag = false.obs;
  RxString simOneName = "".obs;
  RxString simTwoNameTemp = "".obs;
  RxString simOneNameTemp = "".obs;
  RxString simTwoName = "".obs;

  List<SimInfo>? simInfo;

  bool isSupported = true;

  @override
  void onInit() {
    super.onInit();
    getSimInfo();
  }

  @override
  void onClose() {
    textField.dispose();
    super.onClose();
  }

  onNumberTapped(number) {
    textField.text += number;
    update();
  }

  onCancelText() {
    if (textField.text.isNotEmpty) {
      var newValue = textField.text.substring(0, textField.text.length - 1);

      textField.text = newValue;
      update();
    }
  }

  dialCall(String number, {sim}) {
    directCaller.makePhoneCall(number, simSlot: sim);
  }

  Future<void> getSimInfo() async {
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

    if (simInfo!.length == 1) {
      simOneName.value = 'SIM 1';
      simOneNameTemp = simCardInfo[0].displayName.obs;
      simOneFlag.value = true;
      simTwoFlag.value = false;
    } else if (simInfo!.length == 2) {
      simOneName.value = 'SIM 1';
      simOneNameTemp = simCardInfo[0].displayName.obs;
      simTwoNameTemp = simCardInfo[1].displayName.obs;
      simTwoName.value = 'SIM 2';
      simOneFlag.value = true;
      simTwoFlag.value = true;
    } else {
      simOneFlag.value = false;
      simTwoFlag.value = false;
    }
  }
}
