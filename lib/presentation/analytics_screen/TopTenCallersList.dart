import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/AnalysisController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';

class TopTenCallList extends StatelessWidget {
  const TopTenCallList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnalysisController analysisController = Get.put(AnalysisController());
    var arguments = Get.arguments;
    return Scaffold(
      backgroundColor: PrimaryColors().lightWhite,
      appBar: AppBar(
        backgroundColor: PrimaryColors().lightWhite,
        title: Text(arguments),
      ),
      body: analysisController.longCallHashMap.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.do_not_disturb_alt_rounded,
                    size: 70,
                    color: PrimaryColors().purple,
                  ),
                  Text("No Data Found"),
                ],
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(20),
              itemCount: analysisController.longCallHashMap.length > 10
                  ? 10
                  : analysisController.longCallHashMap.length,
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 1,
                  color: Colors.grey,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    analysisController.longCallHashMap.values
                        .elementAt(index)
                        .name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    analysisController.longCallHashMap.values
                        .elementAt(index)
                        .number
                        .toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Text(
                    "${analysisController.longCallHashMap.values.elementAt(index).duration ~/ 60} min ${analysisController.longCallHashMap.values.elementAt(index).duration % 60} sec",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
