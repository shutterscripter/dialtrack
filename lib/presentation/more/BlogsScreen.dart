import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/widgets/BlogCard.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: Text("Blogs"),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlogCard(
              imagePath: ImageConstant.blog01,
              date: "18 Aug 2023",
              title: "The Future of Call Monitoring: Revolutionizing communication and Customer Experience",
            ),
            BlogCard(
              imagePath: ImageConstant.blog02,
              date: "04 Aug 2023",
              title: "Future Trends in Sales Productivity",
            ),
            BlogCard(
              imagePath: ImageConstant.blog03,
              date: "28 Jul 2023",
              title: "Boosting Sales Productivity in Telecalling",
            ),
            BlogCard(
              imagePath: ImageConstant.blog04,
              date: "21 Jul 2023",
              title: "Choosing the right call monitoring system in India",
            ),
            BlogCard(
              imagePath: ImageConstant.blog05,
              date: "14 Jul 2023",
              title: "What are the Benefits of Call Monitoring ?",
            ),
            BlogCard(
              imagePath: ImageConstant.blog06,
              date: "16 Jun 2023",
              title: "The Importance of Marketing Analytics: How Callyzer Can Help You Analyze your Data",
            ),
            BlogCard(
              imagePath: ImageConstant.blog07,
              date: "09 Jun 2023",
              title: "How to train your telecalling team on a low",
            ),
          ],
        ),
      ),
    );
  }
}
