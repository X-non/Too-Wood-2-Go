import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/pages/corporate.dart';
import 'package:eatwise/widgets/ew_company_container_small.dart';
import 'package:flutter/material.dart';

class EwCompanyListSmall extends StatelessWidget {
  const EwCompanyListSmall({
    super.key,
    required this.items,
  });

  final List<CompanyItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: index == 0
                ? const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4)
                : const EdgeInsets.only(right: 16, top: 4, bottom: 4),
            child: EWCompanyContainerSmall(
              item: item,
              navToBusiness: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CorporatePage(
                              item: item,
                            )))
              },
            ),
          );
        },
      ),
    );
  }
}
