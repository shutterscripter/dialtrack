import 'package:fast_contacts/fast_contacts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// This class is a controller for the AutoCallDialer feature.
// It extends GetxController from the GetX package, which provides state management capabilities.
class AutoCallDialerController extends GetxController {

  // Observable list of contacts fetched from the device.
  RxList<Contact> contacts = <Contact>[].obs;

  // Observable list of contacts selected by the user for auto-dialing.
  RxList<Contact> selectedContacts = <Contact>[].obs;

  // Observable boolean to toggle contact selection.
  RxBool toggleContact = false.obs;

  // Observable integer to keep track of the current index in the contacts list.
  RxInt index = 0.obs;

  // List to hold the queue of calls.
  List callQueue = [];

  // This method is called when the controller is initialized.
  @override
  void onInit() {
    super.onInit();
    // Fetching contacts from the device and sorting them by display name.
    getContacts().then((value) {
      contacts.value = value;
    });
    contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
  }

  // This method fetches all contacts from the device.
  // It first checks if the contacts permission is granted, if not it requests for it.
  // If the permission is granted, it returns all contacts, otherwise it returns an empty list.
  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      return FastContacts.getAllContacts();
    }
    return [];
  }

  // This method toggles the selection of a contact.
  // If the contact is already selected, it removes it from the selectedContacts list and the callQueue.
  // If the contact is not selected, it adds it to the selectedContacts list and the callQueue.
  void toggleContactSelection(Contact contact) {
    if (selectedContacts.contains(contact)) {
      selectedContacts.remove(contact);
      callQueue.remove(contact.phones[0].number);
      update();
    } else {
      selectedContacts.add(contact);
      callQueue.add(contact.phones[0].number);
      update();
    }
    update();
    print('selectedContacts: ${callQueue.length}');
  }
}
