import 'package:eatwise/models/product.dart';
import 'package:eatwise/widgets/ew_product_widget.dart';
import 'package:flutter/material.dart';

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
        priceNew: newPrice[index]));

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EWProductWidget(product: item),
            ),
          ]);
        });
  }
}
