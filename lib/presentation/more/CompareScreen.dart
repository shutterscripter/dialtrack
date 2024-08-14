import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/widgets/custom_elevated_button.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text("Compare"),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle_outlined,
                  size: 50,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Add contact  to compare calls and duration (You can add max 5 contacts)",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                text: "Add Contact",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
