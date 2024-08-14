import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This privacy notice pertains to OyeBusy Technology Pvt Ltd ("Company," "we," "us," or "our") and outlines the reasons and methods behind the collection, storage, and processing of your information when utilizing our services ("Services"). This includes instances such as downloading and using our mobile application (DialTrack) or any other application linking to this privacy notice, as well as engaging with us through sales, marketing, or events. If you have any questions or concerns, understanding this privacy notice is crucial to comprehend your privacy rights and choices. If you disagree with our policies and practices, kindly refrain from using our Services. For inquiries or concerns, reach out to us at support@oyebusy.co.in',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.v),
              Text(
                "SUMMARY OF KEY POINTS:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 5.v),
              Text(
                  'This summary provides essential details from our privacy notice. More information on each point can be accessed by clicking the corresponding link or using the table of contents.\n\nWhat personal information do we process? We process personal information based on your interaction with OyeBusy Technology Pvt Ltd and the Services, your choices, and the products/features you use.\n\nDo we process any sensitive personal information? No, we do not process sensitive personal information.\n\nDo we receive any information from third parties? We do not receive information from third parties\n\nHow do we process your information? Information is processed to provide, enhance, and administer our Services, communicate with you, ensure security and fraud prevention, and comply with the law. Additionally, we may process your information with your consent for other purposes, adhering to valid legal reasons.\n\nIn what situations and with which parties do we share personal information? Information may be shared in specific situations and with particular third parties.\n\nHow do we keep your information safe? Organizational and technical processes are in place for personal information protection. While we strive for a secure environment, we cannot guarantee absolute security against unauthorized access or data breaches.\n\nWhat are your rights? Depending on your geographical location, privacy laws may grant you certain rights concerning your personal information.\n\nHow do you exercise your rights? To exercise your rights, fill out our data subject request form at support@oyebusy.co.in, or contact us. Requests will be considered and addressed in compliance with applicable data protection laws.'),
              SizedBox(height: 10.v),
              Text(
                "TABLE OF CONTENT",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 5.v),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("Information You Share with US"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'Briefly: We gather personal information that you furnish to us.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'We collect personal information that you willingly provide when registering on the Services, expressing interest in obtaining details about us or our products and Services, participating in activities on the Services, or contacting us.'),
                            SizedBox(height: 5.v),
                            Text(
                                'Personal Information Supplied by You: The personal information we collect depends on the context of your interactions with us and the Services, your choices, and the products and features you use. This may include Only Phone Number'),
                            SizedBox(height: 10.v),
                            Text(
                                'Sensitive Information: We refrain from processing sensitive information.',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 5.v),
                            Text(
                                'Payment Data: In case of purchases, we may collect data necessary to process your payment, such as your payment instrument number and the associated security code. All payment data is securely stored by Google In-app Purchase. Refer to their privacy notice link(s) here: https://www.google.com/.'),
                            SizedBox(height: 10.v),
                            Text(
                                'Social Media Login Data: We might offer the option to register using your existing social media account details, like Facebook, Twitter, or other platforms. If you choose this method, we will collect information as described in the section titled "HOW DO WE HANDLE YOUR SOCIAL LOGINS?" below.'),
                            SizedBox(height: 10.v),
                            Text(
                                'Collection of User Information: \n\nUser-Provided Information:When using our application(s), you may provide various types of information, including:\nContact Person Information:\nName\nNumber\nEmail\nCountry\n\nCall Log Information:\nCall time, type, and duration\nForm number\nTo number and name')
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
                title: Text(
                  "1. WHAT INFORMATION DO WE COLLECT?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              ListTile(
                title: Text(
                  "2. HOW DO WE PROCESS YOUR INFORMATION?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE PROCESS YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                                'We undertake the processing of your personal information for diverse reasons, contingent on your engagement with our Services, which encompasses:'),
                            SizedBox(height: 10.v),
                            Text(
                                '1. Streamlining Account Creation and Authentication:'),
                            Text(
                                'Processing your information to facilitate the creation and authentication of accounts, ensuring a seamless process for users.'),
                            SizedBox(height: 10.v),
                            Text('User Account Management:'),
                            Text(
                                'Overseeing and managing user accounts, ensuring their continued functionality and accessibility.'),
                            SizedBox(height: 10.v),
                            Text('Preservation of Vital Interests:'),
                            Text(
                                'Processing your information when essential to preserve or protect an individual\'s vital interests, particularly in scenarios aimed at preventing harm.'),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE USE YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'In essence, our processing of your personal information is governed by a valid legal basis, ensuring compliance with applicable laws and safeguarding your rights. For individuals in the EU or UK, the General Data Protection Regulation (GDPR) and UK GDPR establish legal bases for processing, including consent, legal obligations, and protection of vital interests. Consent allows us to process your information for specific purposes, with the option for withdrawal at any time. Legal obligations may necessitate processing to cooperate with authorities or defend legal rights. Vital interests dictate processing to safeguard personal safety. In Canada, explicit or inferred consent is sought for specific purposes, with withdrawal options. Exceptions, permissible under the law, include instances related to individual interests, fraud prevention, business transactions, legal compliance, or information publicly available. Each processing scenario aligns with the relevant legal framework to ensure responsible and lawful data management.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
                title: Text(
                  "3. WHAT LEGAL BASES DO WE RELY ON TO PROCESS YOUR PERSONAL INFORMATION?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              ListTile(
                title: Text(
                  "4. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE USE YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'In summary, we reserve the right to share your personal information under specific circumstances outlined in this section and with designated third parties. Situations may arise where sharing is necessary, such as during business transfers involving mergers, asset sales, financing, or acquisitions. Additionally, we may share information with our affiliates, including our parent company, subsidiaries, joint venture partners, or other entities under our control or sharing common control. In such instances, we ensure that our affiliates adhere to the provisions of this privacy notice, maintaining the integrity of your privacy.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  "5. WHAT IS OUR STANCE ON THIRD-PARTY WEBSITES?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE USE YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Text(
                            ' We are not responsible for the safety of any information that you share with third parties that we may link to or who advertise on our Services, but are not affiliated with, our Services.\nThe Services may link to third-party websites, online services, or mobile applications and/or contain advertisements from third parties that are not affiliated with us and which may link to other websites, services, or applications. Accordingly, we do not make any guarantee regarding any such third parties, and we will not be liable for any loss or damage caused by the use of such third-party websites, services, or applications. The inclusion of a link towards a third-party website, service, or application does not imply an endorsement by us. We cannot guarantee the safety and privacy of data you provide to any third parties. Any data collected by third parties is not covered by this privacy notice. We are not responsible for the content or privacy and security practices and policies of any third parties, including other websites, services, or applications that may be linked to or from the Services. You should review the policies of such third parties and contact them directly to respond to your questions.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE USE YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'In brief, if you opt to register or log in to our Services through a social media account, we may gain access to specific details about you. The option to register and log in using third-party social media account details, such as Facebook or Twitter, is provided by our Services. In such instances, we receive certain profile information from your social media provider. This information may encompass your name, email address, friends list, profile picture, and other details you choose to share publicly on the social media platform. We assure you that we will utilize this received information solely for the purposes outlined in this privacy notice or as explicitly communicated to you within the relevant Services. It\'s essential to note that we do not control or bear responsibility for other uses of your personal information by your third-party social media provider. We recommend reviewing their privacy notice to comprehend how they collect, use, and share your personal information, as well as to manage your privacy preferences on their sites and apps.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
                title: Text(
                  "6. HOW DO WE HANDLE YOUR SOCIAL LOGINS?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              ListTile(
                title: Text(
                  "7. HOW LONG DO WE KEEP YOUR INFORMATION?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE USE YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'In summary, we retain your information only for the duration necessary to fulfill the purposes outlined in this privacy notice, unless extended by law. We commit to keeping your personal information for no longer than required by the specified purposes. If no ongoing legitimate business need requires the processing of your personal information, we will either delete or anonymize the data. In cases where deletion is not immediately feasible, such as with information stored in backup archives, we will securely store and isolate the data from further processing until deletion becomes feasible.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE USE YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'In summary, we are dedicated to safeguarding your personal information through a combination of organizational and technical security measures. We have implemented appropriate and reasonable measures designed to protect the security of processed personal information. However, despite our efforts, no electronic transmission or storage system can be guaranteed 100% secure. We cannot assure immunity against unauthorized access, collection, or modification of your information by hackers, cybercriminals, or other third parties. While we strive to protect your personal information to the best of our ability, the transmission of such information to and from our Services is undertaken at your own risk. It is advisable to access the Services within a secure environment for enhanced security.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
                title: Text(
                  "8. HOW DO WE KEEP YOUR INFORMATION SAFE?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE USE YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'In brief, we do not intentionally collect data from or target individuals under 18 years of age. Our Services are not designed for such users. By utilizing the Services, you affirm that you are at least 18 years old or that you are the parent or guardian of a minor using the Services and provide consent. If we discover that personal information has been unintentionally collected from users under 18, we will deactivate the account and take necessary steps to promptly erase such data from our records. If you are aware of any such data collected from children under 18, please contact us at support@oybusy.co.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
                title: Text(
                  "9. DO WE COLLECT INFORMATION FROM MINORS?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE USE YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'In summary, in specific regions like the European Economic Area (EEA), United Kingdom (UK), and Canada, you hold certain rights under relevant data protection laws, granting you increased access to and control over your personal information. These rights encompass the ability to request access, obtain a copy, rectify, erase, or restrict the processing of your personal information. Additionally, you may have the right to data portability and, under certain circumstances, object to the processing of your personal information. For any such requests or account termination, you can contact us using the details provided in the "HOW CAN YOU CONTACT US ABOUT THIS NOTICE?" section. Upon account termination, we will deactivate or delete your account and associated information from active databases, though some data may be retained for fraud prevention, troubleshooting, investigations, legal enforcement, or compliance with legal requirements.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
                title: Text(
                  "10. WHAT ARE YOUR PRIVACY RIGHTS?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE USE YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'Most web browsers and some mobile operating systems and mobile applications include a Do-Not-Track ("DNT") feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. At this stage no uniform technology standard for recognizing and implementing DNT signals has been finalized. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online. If a standard for online tracking is adopted that we must follow in the future, we will inform you about that practice in a revised version of this privacy notice.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
                title: Text(
                  "11. CONTROLS FOR DO-NOT-TRACK FEATURES",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),

              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("DO WE MAKE UPDATES TO THIS NOTICE?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'In summary, yes, we will revise this notice as needed to ensure compliance with relevant laws. Updates to this privacy notice will be denoted by a revised "Revised" date, with the new version becoming effective upon accessibility. In the event of substantial changes, we may notify you through prominent postings or direct notifications. We encourage you to regularly review this privacy notice to stay informed about how we safeguard your information.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
                title: Text(
                  "12. DO WE MAKE UPDATES TO THIS NOTICE?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              ListTile(
                title: Text(
                  "13. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text("HOW DO WE USE YOUR INFORMATION?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'If you have questions or comments about this notice, you may email us at support@oyebusy.co.in or by post to:\n\nOyeBusy Technologies Pvt Ltd,\nBachan singh Colony Street No 04,\nMuzaffarnagar, 251001,\nIndia'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  "14. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      title: Text(
                          "HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?"),
                      content: SingleChildScrollView(
                        child: Text(
                            'In accordance with the relevant laws of your country, you may have the right to request access, modification, or deletion of the personal information we collect from you. To initiate a request to review, update, or delete your personal information, please visit: support@oyebusy.co.'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(), child: Text("Close"))
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 30.v),
              Text(
                'This privacy policy was created using Termly\'s Privacy Policy generator & updated/modified by OyeBusy Technology Pvt Ltd.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.v),
            ],
          ),
        ),
      ),
    );
  }
}
