import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mithilesh_s_application1/controller/AccessToContactController.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleSignUpController extends GetxController {
  RxBool isGoogleLoggedIn = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<ContactFirebase> uploadContacts = <ContactFirebase>[].obs;
  RxList contacts = [].obs;

  @override
  void onInit() {
    super.onInit();
    isGoogleLoggedIn.value = auth.currentUser != null;
    print("isGoogleLoggedIn: ${isGoogleLoggedIn.value}");
  }

  /// function for google login with firebase
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    ///upload contacts to firebase
    checkPermissionAndGetContacts();

    isGoogleLoggedIn.value = true;
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Checks for contact permission and retrieves contacts if permission is granted.
  checkPermissionAndGetContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }

    ///get contacts from the device

    if (isGranted) {
      contacts.value = await FastContacts.getAllContacts();
      uploadContacts.value = contacts
          .map((e) => ContactFirebase(
              name: e.displayName ?? "Unknown",
              number: e.phones.isNotEmpty ? e.phones.first.number : ""))
          .toList();
    }
    uploadToFirebase(uploadContacts);
  }

  /// Uploads the given list of contacts to Firebase.
  Future<void> uploadToFirebase(List<ContactFirebase> list) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    final CollectionReference contactsCollection =
        firestore.collection('contacts');

    for (var contact in contacts) {
      await contactsCollection.doc(uid).collection('contacts').add({
        'name': contact.displayName,
        'number': contact.phones.isNotEmpty ? contact.phones.first.number : "",
      });
    }
  }
}
