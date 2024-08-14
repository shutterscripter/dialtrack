import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mithilesh_s_application1/controller/CustomDialPadController.dart';
import 'package:mithilesh_s_application1/controller/GoogleSignUpController.dart';
import 'package:mithilesh_s_application1/controller/PermissionManagerController.dart';
import 'package:mithilesh_s_application1/presentation/BottomNavigationbar/BottomNavigationWrapper.dart';
import 'package:mithilesh_s_application1/presentation/GoogleAuth/FirebaseAuthScreen.dart';
import 'package:mithilesh_s_application1/presentation/access_your_call_history/acess_your_call_histo.dart';
import 'package:mithilesh_s_application1/presentation/contact_sim/ConnectSimTwo.dart';
import 'package:mithilesh_s_application1/presentation/contact_sim/connect_sim.dart';
import 'package:mithilesh_s_application1/theme/theme_helper.dart';
import 'package:mithilesh_s_application1/routes/app_routes.dart';
import 'package:mithilesh_s_application1/widgets/LoginoBottomSheet.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('simVerify');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: appTheme.whiteA700,
      statusBarColor: appTheme.whiteA700));
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CustomDialPadController customDialPadController =
      Get.put(CustomDialPadController());
  PermissionManagerController _permissionManagerController =
      Get.put(PermissionManagerController());
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool simVerificationFlag = false;
  bool simOneVerified = false;
  bool simTwoVerified = false;
  bool simOnePresent = false;
  bool simTwoPresent = false;

  @override
  void initState() {
    super.initState();
    hiveWork();
    getSimFlags();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes().getPages,

      /// uncomment the following line if you want to enable mobile auth verification with firebase
      // home: currentUser == null
      //     ? SignUpPage()

      home: getHomeWidget(),
    );
  }

  /// this function is used to get the home widget based on the sim verification status

  Widget getHomeWidget() {
    return FutureBuilder<bool>(
      future: _permissionManagerController.checkCallHistoryPermission(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 50,
            width: 50,
            color: Colors.white,
            child: CircularProgressIndicator(),
          ); // Show a loading spinner while waiting
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show error message if something went wrong
        } else {
          if (snapshot.data == false) {
            return AccessYourCallHist();
          } else if (currentUser == null) {
            // } else if (simOneVerified == false) {
            //   return ConnectSim();
            // } else if (simTwoPresent == true && simTwoVerified == false) {
            //   return ConnectSimTwo();
            return FirebaseAuthScreen();
          } else {
            return BottomNavigationWrapper();
          }
        }
      },
    );
  }

  /// this function is used to get the sim verification status from hive
  Future<void> hiveWork() async {
    customDialPadController.getSimInfo();
    var _box = Hive.box('simVerify');
    simOneVerified = _box.get('simOneVerified') ?? false;
    simTwoVerified = _box.get('simTwoVerified') ?? false;

    print('simOneVerified $simOneVerified');
    print('simTwoVerified $simTwoVerified');
    if (simOneVerified == false || simTwoVerified == false) {
      simVerificationFlag = false;
    } else {
      simVerificationFlag = true;
    }
  }

  /// this function is used to get the sim flags
  void getSimFlags() async {
    // PermissionStatus status = await Permission.phone.status;
    // if (!status.isGranted) {
    //   status = await Permission.phone.request();
    //   if (!status.isGranted) {
    //     return;
    //   }
    // }
    await customDialPadController.getSimInfo();
    simOnePresent = await customDialPadController.simOneFlag.value;
    simTwoPresent = await customDialPadController.simTwoFlag.value;
    print("simOnePresent $simOnePresent");
    print("simTwoPresent $simTwoPresent");
  }
}
