import 'package:eatwise/backend/network.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:flutter/material.dart';

class CompanyNotifier extends ChangeNotifier {
  final List<CompanyItem> _companyItems = [];

  List<CompanyItem> get companyItem => _companyItems;

  Future<bool> fetch() async {
    try {
      _companyItems.clear();
      _companyItems.addAll(await fetchCompanies());
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
