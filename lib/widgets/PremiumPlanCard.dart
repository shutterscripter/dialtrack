import 'package:flutter/material.dart';
import 'package:mithilesh_s_application1/core/app_export.dart';

class PremiumPlanCard extends StatefulWidget {
  PremiumPlanCard(
      {Key? key,
      required this.savePercent,
      required this.price,
      required this.totalMonths,
      required this.isSelected,
      required this.onTap,
      required this.pricePerMonth})
      : super(key: key);
  final String savePercent;
  final String price;
  final String pricePerMonth;
  final String totalMonths;
  bool isSelected = false;
  VoidCallback onTap;

  @override
  State<PremiumPlanCard> createState() => _PremiumPlanCardState();
}

class _PremiumPlanCardState extends State<PremiumPlanCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      //border radius and color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: widget.isSelected ? PrimaryColors().purple : Colors.grey[200]!,
          width: 2,
        ),
      ),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            decoration: BoxDecoration(
              color:
                  widget.isSelected ? PrimaryColors().purple : Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //create checkbox
                Row(
                  children: [
                    Checkbox(
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => BorderSide(
                            width: 2.0, color: PrimaryColors().purple),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      checkColor: widget.isSelected
                          ? Colors.white
                          : PrimaryColors().purple,
                      value: widget.isSelected,
                      onChanged: (value) {
                        widget.onTap();
                      },
                    ),
                    Text(
                      "${widget.totalMonths} Months",
                      style: TextStyle(
                        fontSize: 18,
                        color: widget.isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    "Save ${widget.savePercent}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.price,
                  style: TextStyle(
                    fontSize: 24,
                    color: widget.isSelected
                        ? PrimaryColors().purple
                        : Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.pricePerMonth,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.isSelected
                        ? PrimaryColors().purple
                        : Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
