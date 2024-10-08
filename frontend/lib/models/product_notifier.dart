import 'package:eatwise/backend/network.dart';
import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  final List<ProductItem> _productItems = [];

  List<ProductItem> get productItems => _productItems;

  void toggleProduct(ProductItem item) {
    if (item.inCart == 0) {
      removeProduct(item);
    } else if (item.inCart != 0 && !productItems.contains(item)) {
      _productItems.add(item);
    }
    notifyListeners();
  }

  double calculateCost() {
    double totalCost = 0.0;
    for (var product in _productItems) {
      // String cleanedPriceNew =
      //     product.priceNew.replaceAll(RegExp(r'[^\d.]'), '');
      //   double price = double.parse(cleanedPriceNew);
      totalCost += product.priceNew * product.inCart;
    }
    return totalCost;
  }

  void removeProduct(ProductItem item) {
    item.inCart = 0;
    productItems.remove(item);
    notifyListeners();
  }

  void removeAll() {
    clearCart();
    for (ProductItem item in _productItems) {
      item.inCart = 0;
    }
    productItems.clear();
    notifyListeners();
  }

  void clearCache() {
    _productItems.clear();
    notifyListeners();
  }
}
