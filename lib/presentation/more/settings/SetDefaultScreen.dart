import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetDefaultScreen extends StatelessWidget {
  const SetDefaultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text("Set Default App"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              title: Text("Call History"),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Analytics"),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
