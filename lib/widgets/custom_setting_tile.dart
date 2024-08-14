import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSettingTile extends StatelessWidget {
  CustomSettingTile(
      {Key? key,
      required this.title,
      required this.assetName,
      required this.toDoFunction})
      : super(key: key);
  String title;
  String assetName;
  VoidCallback toDoFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toDoFunction,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1,
        surfaceTintColor: Colors.white,
        child: ListTile(
          leading: SvgPicture.asset(
            assetName,
            height: 20,
            width: 20,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
