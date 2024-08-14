import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSocialCard extends StatelessWidget {
  CustomSocialCard(
      {Key? key, required this.assetName, required this.toDoFunction})
      : super(key: key);

  String assetName;
  VoidCallback toDoFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toDoFunction,
      child: Container(
        height: 40,
        width: 50,
        child: Card(
          margin: EdgeInsets.only(left: 10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              assetName,
              height: 20,
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}
