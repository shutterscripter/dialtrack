import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactController extends GetxController {
  RxList contacts = [].obs;
  RxList filteredContacts = [].obs;
  RxBool visible = true.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getContacts().then((value) {
      contacts.value = value;
      filteredContacts.value = value;
      sortContactsInAscendingOrder();
    });
  }

  @override
  onClose() {
    scrollController.dispose();
    super.onClose();
  }

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

  sortContactsInAscendingOrder() {
    contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
    filteredContacts.sort((a, b) => a.displayName.compareTo(b.displayName));
  }

  /// Filter contacts by name
  filterContacts(String query) {
    if (query.isEmpty) {
      filteredContacts.value = contacts;
      return;
    }
    filteredContacts.value = contacts.where((contact) {
      return contact.displayName.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
