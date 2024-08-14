import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/theme_helper.dart';

class PhoneDialer extends StatefulWidget {
  @override
  _PhoneDialerState createState() => _PhoneDialerState();
}

class _PhoneDialerState extends State<PhoneDialer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 98.0),
          child: DialPad(
            enableDtmf: true,
            backspaceButtonIconColor: Colors.red,
            outputMask: "0000000000",
            // change icon size

            makeCall: (number) async {
              bool? res = await FlutterPhoneDirectCaller.callNumber(number);
            },
          ),
        ),
      ),
    );
  }
}
