import 'package:eatwise/backend/network.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:flutter/material.dart';

class FavoriteItemsNotifier extends ChangeNotifier {
  final List<CompanyItem> _favoriteItems = [];

  List<CompanyItem> get favoriteItems => _favoriteItems;

  void toggleFavorite(CompanyItem item) {
    if (_favoriteItems.contains(item)) {
      _favoriteItems.remove(item);
    } else {
      _favoriteItems.add(item);
    }
    notifyListeners();
  }

  bool isFavorite(CompanyItem item) {
    return _favoriteItems.contains(item);
  }

  Future<bool> updateList() async {
    try {
      _favoriteItems.clear();
      _favoriteItems.addAll(await fetchFavorite());
      return true;
    } catch (e) {
      return false;
    }
  }
}
