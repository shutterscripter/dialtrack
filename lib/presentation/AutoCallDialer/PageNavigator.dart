import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/GoogleSignUpController.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/GetContactsFromFirebase.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/ShowDataCSV.dart';
import 'package:mithilesh_s_application1/widgets/LoginoBottomSheet.dart';

class PageNavigator extends StatefulWidget {
  @override
  _PageNavigatorState createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator>
    with SingleTickerProviderStateMixin {
  GoogleSignUpController _googleSignUpController =
      Get.put(GoogleSignUpController());
  TabController? _tabController;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Call Dialer'),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.purple,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Caller Data'),
            Tab(text: 'DB Contacts'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          /// getting data from csv file
          ShowDataCSV(),

          ///getting data from firebase

          Obx(
            () => _googleSignUpController.isGoogleLoggedIn.value
                ? GetContactsFromFirebase()
                : Center(child: LoginBottomSheet()),
          ),
        ],
      ),
    );
  }
}
