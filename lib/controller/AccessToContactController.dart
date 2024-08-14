import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/CustomDialPadController.dart';
import 'package:mithilesh_s_application1/presentation/BottomNavigationbar/BottomNavigationWrapper.dart';
import 'package:mithilesh_s_application1/presentation/contact_sim/ConnectSimTwo.dart';
import 'package:mithilesh_s_application1/presentation/contact_sim/connect_sim.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller class for managing access to contacts.
class AccessToContactController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList allContactInStr = [].obs;
  RxList contacts = [].obs;
  RxList<ContactFirebase> uploadContacts = <ContactFirebase>[].obs;
  RxList<ContactFirebase> firebaseContacts = <ContactFirebase>[].obs;
  RxList callQueue = [].obs;
  RxInt index = 0.obs;
  RxList<ContactFirebase> selectedFirebaseContacts = <ContactFirebase>[].obs;
  CustomDialPadController customDialPadController =
      Get.put(CustomDialPadController());
  RxBool isLoaded = false.obs;

  bool simVerificationFlag = false;
  bool simOneVerified = false;
  bool simTwoVerified = false;
  bool simOnePresent = false;
  bool simTwoPresent = false;

  /// Called when the controller is initialized.
  @override
  void onInit() async {
    super.onInit();
    getContactsFromFirebase().then((value) {
      firebaseContacts.value = value;
    });
    getSimFlags();
  }

  /// Checks for contact permission and retrieves contacts if permission is granted.
  checkPermissionAndGetContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }

    /// go to google login screen

    Get.toNamed('/googleAuth');

    // Get.toNamed('/connectSim');
    // print("simOneVerified $simOneVerified");
    // if (simOneVerified == false) {
    //   Get.to(ConnectSim());
    // } else if (simTwoPresent == true && simTwoVerified == false) {
    //   Get.to(ConnectSimTwo());
    // } else {
    //   Get.offAll(BottomNavigationWrapper());
    // }
  }


  /// Retrieves contacts from Firebase and returns them as a list.
  Future<List<ContactFirebase>> getContactsFromFirebase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    final CollectionReference contactsCollection =
        firestore.collection('contacts');

    List<ContactFirebase> contacts = [];

    QuerySnapshot querySnapshot =
        await contactsCollection.doc(uid).collection('contacts').get();
    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        if (data['number'] != null) {
          contacts.add(ContactFirebase(
            name: data['name'] ?? 'Unknown',
            number: data['number'] ?? 'Unknown',
          ));
        }
      }
    }
    isLoaded.value = true;
    return contacts;
  }

  /// Toggles the selection of a contact.
  void toggleContactSelection(ContactFirebase contact) {
    if (selectedFirebaseContacts.contains(contact)) {
      selectedFirebaseContacts.remove(contact);
      callQueue.remove(contact.number);
      update();
    } else {
      selectedFirebaseContacts.add(contact);
      callQueue.add(contact.number);
      update();
    }
    update();
    print('selectedContacts: ${callQueue.length}');
  }

  /// this function is used to get the sim flags
  void getSimFlags() async {
    PermissionStatus status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
      if (!status.isGranted) {
        return;
      }
    }
    await customDialPadController.getSimInfo();
    simOnePresent = await customDialPadController.simOneFlag.value;
    simTwoPresent = await customDialPadController.simTwoFlag.value;
    print("simOnePresent $simOnePresent");
    print("simTwoPresent $simTwoPresent");
  }
}

/// Class representing a contact with a name and a number.
class ContactFirebase {
  String? name;
  String? number;

  ContactFirebase({required this.name, required this.number});
}
