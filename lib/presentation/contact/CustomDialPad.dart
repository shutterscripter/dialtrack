import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/CustomDialPadController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';

class CustomDialPad extends StatefulWidget {
  const CustomDialPad({Key? key}) : super(key: key);

  @override
  State<CustomDialPad> createState() => _CustomDialPadState();
}

class _CustomDialPadState extends State<CustomDialPad> {
  CustomDialPadController controller = Get.put(CustomDialPadController());

  Widget inputField() {
    return Container(
      decoration: BoxDecoration(
        color: PrimaryColors().lightWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      alignment: Alignment.bottomCenter,
      child: GetBuilder<CustomDialPadController>(
        builder: (controller) {
          return TextFormField(
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            controller: controller.textField,
            decoration: const InputDecoration(border: InputBorder.none),
          );
        },
      ),
    );
  }

  Widget gridView() {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        children: [
          keyField("1", ""),
          keyField("2", "A B C"),
          keyField("3", "D E F"),
          keyField("4", "G H I"),
          keyField("5", "J K L"),
          keyField("6", "M N O"),
          keyField("7", "P Q R S"),
          keyField("8", "T U V"),
          keyField("9", "W X Y Z"),
          starField(),
          keyField("0", "+"),
          hashField(),
          blankField(),
          dialField(),
          backSpace()
        ],
      ),
    );
  }

  Widget starField() {
    return InkWell(
      onTap: () => controller.onNumberTapped("*"),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(60)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "*",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget hashField() {
    return InkWell(
      onTap: () => controller.onNumberTapped("#"),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(60)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "#",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget backSpace() {
    return GetBuilder<CustomDialPadController>(
      builder: (controller) {
        if (controller.textField.text.isNotEmpty) {
          return InkWell(
            onTap: () => controller.onCancelText(),
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(60)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.backspace_outlined,
                    size: 30,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(height: 0);
        }
      },
    );
  }

  Widget dialField() {
    return InkWell(
      onTap: () {

        _makingPhoneCall(controller.textField.text);
        controller.textField.clear();
      },
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.green[500], borderRadius: BorderRadius.circular(60)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone,
              size: 40,
              color: PrimaryColors().lightWhite,
            )
          ],
        ),
      ),
    );
  }

  Widget blankField() {
    return InkWell(
      child: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: PrimaryColors().lightWhite,
            borderRadius: BorderRadius.circular(60)),
      ),
    );
  }

  Widget keyField(numb, dsc) {
    return InkWell(
      onTap: () => controller.onNumberTapped(numb),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(60)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              numb,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Text(
              dsc,
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
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
              controller.simOneFlag.value
                  ? ListTile(
                      leading: Image.asset(
                        ImageConstant.simCardOneActive,
                        height: 25.v,
                      ),
                      title: Text(controller.simOneName.value),
                      onTap: () {
                        Get.back();
                        controller.dialCall(number, sim: 1);
                      },
                    )
                  : Container(height: 0),
              controller.simTwoFlag.value
                  ? ListTile(
                      leading: Image.asset(
                        ImageConstant.simCardTwoActive,
                        height: 25.v,
                      ),
                      title: Text(controller.simTwoName.value),
                      onTap: () {
                        Get.back();
                        controller.dialCall(number, sim: 2);
                      },
                    )
                  : Container(height: 0),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputField(),
            gridView(),
          ],
        ),
      ),
    );
  }
}
