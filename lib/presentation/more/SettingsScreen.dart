import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text("Settings"),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              title: Text("Premium Settings"),
              leading: Icon(
                Icons.star,
                color: Colors.black,
              ),
              onTap: () {},
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("SIM Number"),
              onTap: () {},
              leading: Icon(
                Icons.sim_card,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Language"),
              onTap: () => Get.toNamed('/languages'),
              leading: Icon(
                Icons.language,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Theme"),
              onTap: () => Get.toNamed('/theme'),
              leading: Icon(
                Icons.color_lens,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Time Format"),
              onTap: () => Get.toNamed('timeFormat'),
              leading: Icon(
                Icons.timer,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Set Default Screen"),
              onTap: () => Get.toNamed('/defaultScreen'),
              leading: Icon(
                Icons.screen_lock_portrait,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Missing Call Details "),
              onTap: () {},
              leading: Icon(
                Icons.phone_missed_outlined,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Remove as default dialer"),
              onTap: () {},
              leading: Icon(
                Icons.dialpad_rounded,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Backup / Export Call History"),
              onTap: () {},
              leading: Icon(
                Icons.backup,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Restore /Import Call History"),
              onTap: () {},
              leading: Icon(
                Icons.restore,
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
