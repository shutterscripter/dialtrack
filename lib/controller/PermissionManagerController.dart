import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManagerController extends GetxController {
  /// Check for call history permission
    Future<bool> checkCallHistoryPermission() {
    return  Permission.contacts.status.isGranted;
  }

  /// check  for contact permission
  Future<bool> checkContactPermission() async {
    return await Permission.contacts.status.isGranted;
  }
}
