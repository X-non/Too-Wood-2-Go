import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  final List<ProductItem> _productItems = [];

  List<ProductItem> get productItems => _productItems;

  void toggleProduct(ProductItem item) {
    if (item.amount == 0) {
      _productItems.remove(item);
    } else if (item.amount == 1 && !productItems.contains(item)) {
      _productItems.add(item);
    }
    notifyListeners();
  }

  double calculateCost() {
    double totalCost = 0.0;
    for (var product in productItems) {
      String cleanedPriceNew =
          product.priceNew.replaceAll(RegExp(r'[^\d.]'), '');
      double price = double.parse(cleanedPriceNew);
      totalCost += price * product.amount;
    }
    return totalCost;
  }

  void removeProduct(ProductItem item) {
    item.amount = 0;
    _productItems.remove(item);
    notifyListeners();
  }

  void removeAll() {
    productItems.clear();
    notifyListeners();
  }
}
