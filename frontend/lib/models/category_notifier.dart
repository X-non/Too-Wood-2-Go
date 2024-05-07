import 'package:eatwise/backend/network.dart';
import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';

class CategoryNotifier extends ChangeNotifier {
  final List<ProductItem> allItems = [];
  final List<ProductItem> _categoryItems = [];
  final List<ProductItem> _allIems = [];

  List<ProductItem> get categoryItems => _categoryItems;

  void updateCategories(String current) {
    _categoryItems.clear();
    if (current == "Allt") {
      _categoryItems.addAll(allItems);
    } else {
      for (ProductItem product in allItems) {
        if (product.category == current) {
          _categoryItems.add(product);
        }
      }
    }
    notifyListeners();
  }


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

  Future<void> updateAds(String CompanyId) async {
    List<ProductItem> products = await getAds(CompanyId);
    if (products.isEmpty) {
      allItems.clear();
    } else {
      allItems.clear();
      allItems.addAll(products);
    }
    notifyListeners();
  }

  void clearCache() {
    allItems.clear();
    _categoryItems.clear();
  }
}
