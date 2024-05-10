import 'package:eatwise/models/category_notifier.dart';
import 'package:eatwise/models/product.dart';
import 'package:eatwise/widgets/ew_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          padding: (index == items.length - 1)
              ? const EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 130)
              : const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: EWProductWidget(
            product: item,
          ),
        );
      },
    );
  }
}
