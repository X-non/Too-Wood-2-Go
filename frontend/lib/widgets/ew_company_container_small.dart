import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:flutter/material.dart';

class EWCompanyContainerSmall extends StatelessWidget {
  const EWCompanyContainerSmall({
    super.key,
    required this.navToBusiness,
    required this.item,
  });

  final CompanyItem item;
  final void Function()? navToBusiness;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navToBusiness,
      child: Container(
        width: 200,
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
                height: 100,
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
                        style: EWTextStyles.headline,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        item.description,
                        style: EWTextStyles.icon,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
