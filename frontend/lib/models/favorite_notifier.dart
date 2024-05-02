import 'package:eatwise/backend/network.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:flutter/material.dart';

class FavoriteItemsNotifier extends ChangeNotifier {
  final List<CompanyItem> _favoriteItems = [];

  List<CompanyItem> get favoriteItems => _favoriteItems;

  void toggleFavorite(CompanyItem item) {
    bool favorite = false;
    if (_favoriteItems.contains(item)) {
      _favoriteItems.remove(item);
    } else {
      favorite = true;
      _favoriteItems.add(item);
    }
    setFavorite(item.storeId, favorite);
    notifyListeners();
  }

  bool isFavorite(CompanyItem item) {
    return _favoriteItems.contains(item);
  }

  Future<bool> fetch() async {
    try {
      _favoriteItems.clear();
      _favoriteItems.addAll(await fetchFavorite());
      return true;
    } catch (e) {
      return false;
    }
  }

  void clearCache() {
    _favoriteItems.clear();
    notifyListeners();
  }
}
