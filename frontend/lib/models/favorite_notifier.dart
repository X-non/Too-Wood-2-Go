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

  void updateList(List<CompanyItem> favoriteItems) {
    _favoriteItems.clear();
    _favoriteItems.addAll(favoriteItems);
  }
}
