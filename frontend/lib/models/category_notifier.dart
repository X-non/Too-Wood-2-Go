import 'package:eatwise/backend/network.dart';
import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';

class CategoryNotifier extends ChangeNotifier {
  final List<ProductItem> allItems = [];
  final List<ProductItem> _categoryItems = [];
  final List<ProductItem> _allStoreItems = [];

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
      _allStoreItems.clear();
      for (ProductItem product in list) {
        _allStoreItems.add(product);
        _categoryItems.add(product);
      }
    } else if (current == "Allt") {
      for (ProductItem product in _allStoreItems) {
        _categoryItems.add(product);
      }
    } else {
      for (ProductItem product in _allStoreItems) {
        if (product.category == current) {
          _categoryItems.add(product);
        }
      }
    }
    notifyListeners();
  }

  Future<List<ProductItem>> updateAds(String CompanyId) async {
    List<ProductItem> products = await getAds(CompanyId);
    allItems.clear();
    allItems.addAll(products);
    createList(allItems, "");
    notifyListeners();
    return allItems; 
  }

  void clearCache() {
    allItems.clear();
    _categoryItems.clear();
  }
}
