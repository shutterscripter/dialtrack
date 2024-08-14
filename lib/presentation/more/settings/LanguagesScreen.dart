import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: Text("Languages"),
          
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              title: Text("English"),
              trailing: Icon(Icons.check),
            ),
            Divider(),
            ListTile(
              title: Text("Hindi"),
              trailing: Icon(Icons.check),
            ),
            Divider(),
            ListTile(
              title: Text("Marathi"),
              trailing: Icon(Icons.check),
            ),
            Divider(),
            ListTile(
              title: Text("pyyccknn(Russian)"),
              trailing: Icon(Icons.check),
            ),
          ],
        ));
  }
}
