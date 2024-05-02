import 'package:eatwise/backend/maps.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_notifier.dart';
import 'package:eatwise/widgets/ew_company_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final companyNotfier = Provider.of<CompanyNotifier>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.map_outlined,
                size: 50,
                color: EWColors.darkgreen,
              ),
            ),
            SizedBox(
              child: Text(
                "Karta",
                style: EWTextStyles.titleBold,
              ),
            ),
          ],
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const EWMap(),
                  ),
                ))),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "Butiker i din närhet",
                style: EWTextStyles.headline,
              ),
            ),
          ],
        ),
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: EWCompanyList(items: companyNotfier.companyItem),
        ))
      ],
    );
  }
}
