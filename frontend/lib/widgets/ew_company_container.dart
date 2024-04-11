import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:flutter/material.dart';

class CompanyContainer extends StatelessWidget {
  const CompanyContainer({
    super.key,
    required this.item,
  });

  final CompanyItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: EWColors.lightgreen,
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Image.asset(
              width: double.infinity,
              height: 75,
              fit: BoxFit.fitWidth,
              item.img,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      item.title,
                      style: EWTextStyles.headline
                          .copyWith(color: EWColors.darkgreen),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      item.subtitle,
                      style:
                          EWTextStyles.icon.copyWith(color: EWColors.darkgreen),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
