import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';

class CategoryNotifier extends ChangeNotifier {
  final List<ProductItem> allItems = [];
  final List<ProductItem> _categoryItems = [];

  List<ProductItem> get categoryitems => _categoryItems;

  void createList(List<ProductItem> list, String current) {
    _categoryItems.clear();
    if (current == "") {
      allItems.clear();
      for (ProductItem product in list) {
        allItems.add(product);
        _categoryItems.add(product);
      }
    } else if (current == "Allt") {
      for (ProductItem product in allItems) {
        _categoryItems.add(product);
      }
    } else {
      for (ProductItem product in allItems) {
        if (product.category == current) {
          _categoryItems.add(product);
        }
      }
    }
    notifyListeners();
  }
}
