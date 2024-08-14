import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/AutoCallDialerScreen.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/GetContactsFromFirebase.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/PageNavigator.dart';

class AutoCallDialerMain extends StatefulWidget {
  const AutoCallDialerMain({Key? key}) : super(key: key);

  @override
  State<AutoCallDialerMain> createState() => _AutoCallDialerMainState();
}

class _AutoCallDialerMainState extends State<AutoCallDialerMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: Text('Auto Call Dialer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'To automate calls, Please choose from where you wish to pick contacts:',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.v),
            ElevatedButton(
              onPressed: () => Get.to(AutoCallDialerScreen()),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                  left: 40.0,
                  right: 40.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.contact_phone_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20.h),
                    Text(
                      'From Contacts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.v),
            ElevatedButton(
              onPressed: () {
                // Get.to(GetContactsFromFirebase());
                Get.to(PageNavigator());
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                  left: 40.0,
                  right: 40.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20.v),
                    Text(
                      'From Firebase',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
