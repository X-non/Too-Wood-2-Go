import 'package:eatwise/models/company_item.dart';
import 'package:flutter/material.dart';

class PickUpNotifier extends ChangeNotifier {
  final List<CompanyItem> _pickupItems = [];

  List<CompanyItem> get pickItems => _pickupItems;

  void addPickUp(CompanyItem item) {
    _pickupItems.add(item);
    notifyListeners();
  }

  void removePickUp(CompanyItem item) {
    _pickupItems.remove(item);
    notifyListeners();
  }

  void clearCache() {
    _pickupItems.clear();
  }
}
