import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/AutoCallDialerController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/MakeCallsActivity.dart';

class AutoCallDialerScreen extends StatefulWidget {
  // Constructor for AutoCallDialerScreen.
  const AutoCallDialerScreen({Key? key}) : super(key: key);

  // Creates the mutable state for this widget at a given location in the tree.
  @override
  State<AutoCallDialerScreen> createState() => _AutoCallDialerScreenState();
}

// This is the private State class that goes with AutoCallDialerScreen.
class _AutoCallDialerScreenState extends State<AutoCallDialerScreen> {
  // Controller for the AutoCallDialer
  AutoCallDialerController autoCallDialerController =
      Get.put(AutoCallDialerController());

  // Function to build the widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Call Dialer'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Clear the selected contacts
              autoCallDialerController.selectedContacts.clear();
            },
            icon: Icon(
              Icons.clear_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: autoCallDialerController.contacts.length,
          itemBuilder: (context, index) {
            // Get the contact at the current index
            Contact contact = autoCallDialerController.contacts[index];
            autoCallDialerController.index.value = index;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Card(
                color: PrimaryColors().lightWhite,
                surfaceTintColor: Colors.transparent,
                elevation: 0.5,
                shadowColor: Colors.grey[200],
                child: ListTile(
                  leading: Obx(
                    () => Checkbox(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(
                            width: 2.0, color: PrimaryColors().purple),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      checkColor: autoCallDialerController.selectedContacts
                              .contains(contact)
                          ? Colors.white
                          : PrimaryColors().purple,
                      value: autoCallDialerController.selectedContacts
                          .contains(contact),
                      onChanged: (value) {
                        // Toggle the selection of the contact
                        autoCallDialerController
                            .toggleContactSelection(contact);
                      },
                    ),
                  ),
                  title: Text(
                    autoCallDialerController.contacts[index].displayName,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    autoCallDialerController.contacts[index].phones.length > 0
                        ? autoCallDialerController
                            .contacts[index].phones.first.number
                        : "",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: PrimaryColors().purple,
        onPressed: () {
          // Navigate to the MakeCallsActivity screen with the call queue
          Get.to(
            MakeCallsActivity(
              temp: autoCallDialerController.callQueue,
            ),
          );
        },
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
