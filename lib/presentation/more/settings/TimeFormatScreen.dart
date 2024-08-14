import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeFormatScreen extends StatelessWidget {
  const TimeFormatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text("Time Format"),
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
              title: Text("12 Hours"),
              trailing: Icon(Icons.check),
            ),
            Divider(),
            ListTile(
              title: Text("24 Hours"),
              trailing: Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }
}
