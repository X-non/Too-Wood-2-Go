import 'package:eatwise/models/product.dart';
import 'package:eatwise/models/product_notifier.dart';
import 'package:eatwise/widgets/ew_product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List<String> productName = [
  'Bulle',
  'Banan',
  'Mjölk',
];

const List<String> oldPrice = [
  '15 kr',
  '10 kr',
  '10 kr',
];

const List<String> newPrice = [
  '10 kr',
  '5 kr',
  '7 kr',
];

final List<ProductItem> items = List<ProductItem>.generate(
    3,
    (index) => ProductItem(
        img: 'assets/image/Gateau1.jpg',
        name: productName[index],
        priceOld: oldPrice[index],
        priceNew: newPrice[index],
        amount: 0));

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<ProductNotifier>(context);
    return Column(children: [
      productItem.productItems.isEmpty
          ? const Text('Kundkorgen är tom')
          : EWProductList(items: productItem.productItems),
    ]);
  }
}
