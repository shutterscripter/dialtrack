import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';
import 'package:mithilesh_s_application1/widgets/PremiumPlanCard.dart';
import 'package:mithilesh_s_application1/widgets/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumPage01 extends StatefulWidget {
  const PremiumPage01({Key? key}) : super(key: key);

  @override
  State<PremiumPage01> createState() => _PremiumPage01State();
}

class _PremiumPage01State extends State<PremiumPage01> {
  int selectedPlan = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Here is what you will unlock",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                Text("Ad-Free Experience.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                Expanded(
                  child: Text("Auto Back Up Your Call Logs in Google Drive.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                Expanded(
                  child: Text(
                      "You can now receive quick technical support through Whatsapp.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),

            SizedBox(height: 20),

            ///choose your plan
            Text(
              "Choose a Plan",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 10),
            PremiumPlanCard(
              totalMonths: "12",
              price: "₹ 399",
              isSelected: selectedPlan == 1,
              onTap: () {
                setState(() {
                  selectedPlan = 1;
                });
              },
              pricePerMonth: "₹ 33.25/months",
              savePercent: "55",
            ),
            SizedBox(height: 10),
            PremiumPlanCard(
              totalMonths: "3",
              price: "₹ 180",
              onTap: () {
                setState(() {
                  selectedPlan = 2;
                });
              },
              isSelected: selectedPlan == 2,
              pricePerMonth: "₹ 60/months",
              savePercent: "20",
            ),
            SizedBox(height: 10),
            PremiumPlanCard(
              totalMonths: "1",
              price: "₹ 75",
              onTap: () {
                setState(() {
                  selectedPlan = 3;
                });
              },
              isSelected: selectedPlan == 3,
              pricePerMonth: "₹ 75/months",
              savePercent: "0",
            ),
            SizedBox(height: 10),
            CustomElevatedButton(
              text: "Subscribe",
              onTap: () {},
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "7 days free trial for new subscribers only,",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                //open link in browser "https://codezaza.com/dialtrack-privacy-policy/"
                final Uri _url = Uri.parse(
                    'https://codezaza.com/dialtrack-terms-of-services/');
                await launchUrl(_url);
              },
              child: Center(
                child: Text(
                  "Terms and Conditions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: PrimaryColors().purple,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              selected: true,
              selectedTileColor: Colors.grey.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              leading: Icon(Icons.info_outline, color: Colors.grey),
              title: Text(
                "You can cancel your subscription anytime through the play store",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
