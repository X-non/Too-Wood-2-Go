import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';

class CategoryNotifier extends ChangeNotifier {
  List<ProductItem> _categoryItems = item;

  List<ProductItem> get categoryItems => _categoryItems;

  void categoryProduct(String current) {
    _categoryItems = [];
    if (current == 'Allt') {
      _categoryItems = item;
    } else {
      for (ProductItem product in item) {
        if (product.category == current) {
          _categoryItems.add(product);
        }
      }
    }
    notifyListeners();
  }
}
