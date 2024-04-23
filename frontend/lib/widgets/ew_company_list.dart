import 'package:eatwise/models/category_notifier.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/pages/corporate.dart';
import 'package:eatwise/widgets/ew_company_container.dart';
import 'package:flutter/material.dart';
import 'package:eatwise/models/product.dart';
import 'package:provider/provider.dart';

class EWCompanyList extends StatelessWidget {
  const EWCompanyList({super.key, required this.items});

  final List<CompanyItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: EWCompanyContainer(
            navToBusiness: () => {
              Provider.of<CategoryNotifier>(context, listen: false)
                  .createList(productItems, ""),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CorporatePage(
                            item: item,
                          )))
            },
            item: item,
          ),
        );
      },
    );
  }
}
