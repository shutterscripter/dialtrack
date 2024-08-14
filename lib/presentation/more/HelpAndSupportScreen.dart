import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text("Help & Support"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text("Contact Us"),
              onTap: () {},
              leading: Icon(
                Icons.email,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("WhatsApp Us "),
              subtitle: Text(
                "(For premium customer)",
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {},
              leading: Icon(
                Icons.question_answer,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("FAQs"),
              onTap: () {},
              leading: Icon(
                Icons.question_answer,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
