import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/ContactController.dart';
import 'package:mithilesh_s_application1/controller/CustomDialPadController.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/presentation/contact/CustomDialPad.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late final Contact contact;
  TextEditingController searchController = TextEditingController();
  ContactController contactController = Get.put(ContactController());
  CustomDialPadController dialPadController =
      Get.put(CustomDialPadController());

  @override
  void initState() {
    super.initState();
    contactController.scrollController.addListener(
      () {
        if (contactController.scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (contactController.visible.value) {
            contactController.visible.value = false;
          }
        } else {
          if (contactController.scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
            if (!contactController.visible.value) {
              contactController.visible.value = true;
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: Text("Contacts"),
          actions: [
            IconButton(
              onPressed: () {
                Get.snackbar("More features coming soon", "Stay tuned",
                    snackStyle: SnackStyle.GROUNDED);
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              /// search widget
              TextField(
                cursorColor: PrimaryColors().purple,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) => contactController.filterContacts(value),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    fontSize: 16.v,
                    color: Colors.grey,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: PrimaryColors().purple,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.v),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    controller: contactController.scrollController,
                    itemCount: contactController.filteredContacts.length,
                    itemBuilder: (context, index) {
                      Contact contact =
                          contactController.filteredContacts[index];
                      return Card(
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: PrimaryColors().lightWhite,
                        surfaceTintColor: PrimaryColors().lightWhite,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10.v,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.deepPurple,
                                    radius: 25,
                                    child: CircleAvatar(
                                      radius: 22.v,
                                      backgroundColor:
                                          PrimaryColors().whiteA700,
                                      child: Text(
                                        contact.displayName.isNotEmpty
                                            ? contact.displayName[0]
                                            : 'U',
                                        style: TextStyle(
                                          color: PrimaryColors().black900,
                                          fontSize: 20.v,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.v),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contact.displayName,
                                        style: TextStyle(
                                          fontSize: 16.v,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.v,
                                      ),
                                      Text(
                                        contact.phones.length > 0
                                            ? contact.phones.first.number
                                            : "",
                                        style: TextStyle(
                                          fontSize: 14.v,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 70.h,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        ///copy contact onto clipboard
                                        FlutterClipboard.copy(
                                                contact.phones.length > 0
                                                    ? contact
                                                        .phones.first.number
                                                    : "")
                                            .then(
                                          (value) => Get.snackbar(
                                            "Copied",
                                            "Contact copied to clipboard",
                                            snackPosition: SnackPosition.BOTTOM,
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.copy_rounded,
                                        color: Colors.grey,
                                        size: 25.v,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.v,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        /// Message the contact
                                        String url =
                                            "sms:${contact.phones.length > 0 ? contact.phones.first.number : ""}";
                                        await canLaunch(url)
                                            ? await launch(url)
                                            : throw 'Could not launch $url';
                                      },
                                      child: Icon(
                                        Icons.message,
                                        color: Colors.blue,
                                        size: 25.v,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.v,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        ///launch the whatsapp using intent
                                        String url =
                                            "https://wa.me/${contact.phones.length > 0 ? contact.phones.first.number : ""}";
                                        await canLaunch(url)
                                            ? await launch(url)
                                            : throw 'Could not launch $url';
                                      },
                                      child: Image.asset(
                                        ImageConstant.imgWhatsapp1,
                                        height: 25.v,
                                        width: 25.v,
                                      ),
                                    ),
                                    SizedBox(width: 10.v),
                                    InkWell(
                                      onTap: () async {
                                        ///call the number
                                        var number =
                                            '${contact.phones.length > 0 ? contact.phones.first.number : ""}';
                                        //clear
                                        _makingPhoneCall(number);
                                      },
                                      child: Icon(
                                        Icons.call_rounded,
                                        color: Colors.green,
                                        size: 25.v,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Obx(
          () => Visibility(
            visible: contactController.visible.value,
            child: FloatingActionButton(
              mouseCursor: MouseCursor.defer,
              onPressed: () {
                //bottom sheet using getx to display the dialer
                Get.bottomSheet(

                  Container(
                    color: PrimaryColors().lightWhite,
                    height: Get.height * 0.9,
                    child: CustomDialPad(),
                  ),
                  ignoreSafeArea: false,
                  isScrollControlled: true,
                  backgroundColor: PrimaryColors().lightWhite,
                  enableDrag: true,
                );
              },
              backgroundColor: PrimaryColors().purple,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Icon(
                  Icons.dialpad,
                  color: PrimaryColors().lightWhite,
                  size: 30.v,
                ),
              ), //Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  _makingPhoneCall(number) async {
    //make a pop up to get the sim card choice from user
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: PrimaryColors().lightWhite,
          elevation: 2,
          title: Text("Choose SIM"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              dialPadController.simOneFlag.value
                  ? ListTile(
                      leading: Image.asset(
                        ImageConstant.simCardOneActive,
                        height: 25.v,
                      ),
                      title: Text(dialPadController.simOneName.value),
                      onTap: () {
                        dialPadController.dialCall(number, sim: 1);
                      },
                    )
                  : Container(height: 0),
              dialPadController.simTwoFlag.value
                  ? ListTile(
                      leading: Image.asset(
                        ImageConstant.simCardTwoActive,
                        height: 25.v,
                      ),
                      title: Text(dialPadController.simTwoName.value),
                      onTap: () {
                        Get.back();
                        dialPadController.dialCall(number, sim: 2);
                      },
                    )
                  : Container(height: 0),
            ],
          ),
        );
      },
    );
  }
}
