import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/presentation/analytics_screen/CallerInfoScreen.dart';
import 'package:mithilesh_s_application1/presentation/analytics_screen/CallerModel.dart';

class AnalysisCard extends StatelessWidget {
  final String imagePath;
  final CallerModel callerModel;
  final String heading;

  AnalysisCard({
    Key? key,
    required this.imagePath,
    required this.heading,
    required this.callerModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (heading == 'Top 10 Call Duration') {
          Get.toNamed('/topTenCallers', arguments: heading);
        } else {
          Get.to(
            CallerInfoScreen(
              callerModel: callerModel,
              heading: heading,
            ),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        shadowColor: Colors.black,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        child: Container(
          width: 180.h,
          height: 120.h,
          padding: EdgeInsets.all(10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///heading and image
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: //svg
                        Image.asset(
                      imagePath,
                      height: 30.v,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      heading,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              ///call name
              heading == 'Top 10 Call Duration'
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Text(
                            callerModel.callerName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 2.v),
            ],
          ),
        ),
      ),
    );
  }
}
