import 'package:eatwise/backend/network.dart';
import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  final List<ProductItem> _productItems = [];

  List<ProductItem> get productItems => _productItems;

  void toggleProduct(ProductItem item) {
    if (item.amount == 0) {
      removeProduct(item);
    } else if (item.amount != 0 && !productItems.contains(item)) {
      _productItems.add(item);
      addToCart(item.id, 1);
    } else if (item.amount != 0 && productItems.contains(item)) {
      addToCart(item.id, 1);
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
    productItems.remove(item);
    removeFromCart(item, item.amount);
    notifyListeners();
  }

  void removeAll() {
    for (ProductItem item in productItems) {
      item.amount = 0;
      removeFromCart(item, item.amount);
    }
    productItems.clear();
    notifyListeners();
  }

  void clearCache() {
    _productItems.clear();
  }
}
