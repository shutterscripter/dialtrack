import 'package:flutter/material.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/theme/theme_helper.dart';
import 'package:mithilesh_s_application1/widgets/PremiumPlanCard.dart';
import 'package:mithilesh_s_application1/widgets/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumPage02 extends StatefulWidget {
  const PremiumPage02({Key? key}) : super(key: key);

  @override
  State<PremiumPage02> createState() => _PremiumPage02State();
}

class _PremiumPage02State extends State<PremiumPage02> {
  int selectedPlan = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            PremiumPlanCard(
              savePercent: "20",
              price: "₹ 180",
              isSelected: selectedPlan == 1,
              onTap: () {
                setState(() {
                  selectedPlan = 1;
                });
              },
              totalMonths: "3",
              pricePerMonth: "₹ 60/months",
            ),
            SizedBox(
              height: 20.h,
            ),
            PremiumPlanCard(
              savePercent: "0",
              price: "₹ 75",
              totalMonths: "1",
              isSelected: selectedPlan == 2,
              onTap: () {
                setState(() {
                  selectedPlan = 2;
                });
              },
              pricePerMonth: "₹ 75/months",
            ),
            SizedBox(height: 30),
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
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 20),
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
            ),
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
