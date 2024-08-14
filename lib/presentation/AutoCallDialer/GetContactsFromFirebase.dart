import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/controller/AccessToContactController.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/AutoCallDialerKeyboard.dart';
import 'package:mithilesh_s_application1/presentation/AutoCallDialer/MakeCallsActivity.dart';
import 'package:mithilesh_s_application1/theme/theme_helper.dart';

class GetContactsFromFirebase extends StatefulWidget {
  const GetContactsFromFirebase({Key? key}) : super(key: key);

  @override
  State<GetContactsFromFirebase> createState() =>
      _GetContactsFromFirebaseState();
}

class _GetContactsFromFirebaseState extends State<GetContactsFromFirebase> {
  AccessToContactController accessToContactController =
      Get.put(AccessToContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => accessToContactController.isLoaded.value
            ? ListView.builder(
                itemCount: accessToContactController.firebaseContacts.length,
                itemBuilder: (context, index) {
                  accessToContactController.index.value = index;
                  return Card(
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
                          checkColor: accessToContactController
                                  .selectedFirebaseContacts
                                  .contains(accessToContactController
                                      .firebaseContacts[index])
                              ? Colors.white
                              : PrimaryColors().purple,
                          value: accessToContactController
                              .selectedFirebaseContacts
                              .contains(accessToContactController
                                  .firebaseContacts[index]),
                          onChanged: (value) {
                            accessToContactController.toggleContactSelection(
                                accessToContactController
                                    .firebaseContacts[index]);
                          },
                        ),
                      ),
                      title: Text(
                          accessToContactController
                                  .firebaseContacts[index].name ??
                              'Unknown',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        accessToContactController
                                .firebaseContacts[index].number ??
                            'Unknown',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButton: SpeedDial(
        elevation: 0,
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: PrimaryColors().purple,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            elevation: 0,
            shape: CircleBorder(),
            backgroundColor: PrimaryColors().purple,
            child: Icon(
              Icons.call_rounded,
              color: Colors.white,
            ),
            label: 'Call First 10 Contacts',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              List<String> temp = [];
              for (int i = 1;
                  i < accessToContactController.firebaseContacts.length;
                  i++) {
                if(accessToContactController.firebaseContacts[i].number != ""){
                  temp.add(accessToContactController.firebaseContacts[i].number.toString());
                }
              }
              Get.to(MakeCallsActivity(
                  temp: temp.length > 10 ? temp.sublist(0, 10) : temp));

              ///remove contact from list
              // int count =
              //     controller.data.length > 10 ? 10 : controller.data.length;
              // for (int i = 1; i < count; i++) {
              //   controller.data.removeAt(i);
              // }
            },
          ),
          SpeedDialChild(
            elevation: 0,
            shape: CircleBorder(),
            backgroundColor: PrimaryColors().purple,
            child: Icon(
              Icons.call_rounded,
              color: Colors.white,
            ),
            label: 'Call First 50 Contacts',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              List<String> temp = [];
              for (int i = 1;
              i < accessToContactController.firebaseContacts.length;
              i++) {
                if(accessToContactController.firebaseContacts[i].number != ""){
                  temp.add(accessToContactController.firebaseContacts[i].number.toString());
                }
              }
              Get.to(MakeCallsActivity(
                  temp: temp.length > 50 ? temp.sublist(0, 50) : temp));


              ///remove contact from list
              // int count =
              //     controller.data.length > 50 ? 50 : controller.data.length;
              // for (int i = 1; i < count; i++) {
              //   controller.data.removeAt(i);
              // }
            },
          ),
          SpeedDialChild(
            elevation: 0,
            shape: CircleBorder(),
            backgroundColor: PrimaryColors().purple,
            child: Icon(
              Icons.call_rounded,
              color: Colors.white,
            ),
            label: 'Call First 100 Contacts',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              List<String> temp = [];
              for (int i = 1;
              i < accessToContactController.firebaseContacts.length;
              i++) {
                if(accessToContactController.firebaseContacts[i].number != ""){
                  temp.add(accessToContactController.firebaseContacts[i].number.toString());
                }
              }
              Get.to(MakeCallsActivity(
                  temp: temp.length > 100 ? temp.sublist(0, 100) : temp));


              ///remove contact from list
              // int count =
              //     controller.data.length > 100 ? 100 : controller.data.length;
              // for (int i = 1; i < count; i++) {
              //   controller.data.removeAt(i);
              // }
            },
          ),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: PrimaryColors().purple,
        onPressed: () {
          // Navigate to the MakeCallsActivity screen with the call queue
          Get.to(
            MakeCallsActivity(temp: accessToContactController.callQueue),
          );
        },
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
      ),*/
    );
  }
}
