import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/product.dart';
import 'package:eatwise/pages/corporate.dart';
import 'package:eatwise/widgets/ew_company_container.dart';
import 'package:eatwise/widgets/ew_product_widget.dart';
import 'package:flutter/material.dart';

class EWProductList extends StatelessWidget {
  const EWProductList({super.key, required this.items});

  final List<ProductItem> items;

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
          child: EWProductWidget(
            product: item,
          ),
        );
      },
    );
  }
}
