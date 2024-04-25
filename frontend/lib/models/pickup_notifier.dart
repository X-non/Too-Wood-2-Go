import 'package:eatwise/models/company_item.dart';
import 'package:flutter/material.dart';

class PickUpNotifier extends ChangeNotifier {
  final List<CompanyItem> _pickupItems = [];

  List<CompanyItem> get pickItems => _pickupItems;

  void togglePickUp(CompanyItem item) {
    if (_pickupItems.contains(item)) {
      _pickupItems.remove(item);
    } else {
      _pickupItems.add(item);
    }
    notifyListeners();
  }
}
