import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/category_notifier.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/pages/corporate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EWSearchBar extends StatelessWidget {
  final List<CompanyItem> corporationNames;

  EWSearchBar({required this.corporationNames, super.key});

  final ButtonStyle evelvatedButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: EWColors.lightgreen)));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.search, color: Colors.black),
      onPressed: () {
        showSearch(
            context: context, delegate: CustomShowDelegate(corporationNames));
      },
      style: evelvatedButtonStyle,
      label: const Text(
        'Sök',
        style: EWTextStyles.body,
      ),
    );
  }
}

class CustomShowDelegate extends SearchDelegate {
  List<CompanyItem> companyItems;
  List<String> itemTitles = [];

  CustomShowDelegate(this.companyItems) {
    getNames();
  }

  void getNames() {
    for (var favoriteItem in companyItems) {
      itemTitles.add(favoriteItem.title);
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];

    for (var name in itemTitles) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(name);
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var name in itemTitles) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(name);
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            onTap: () {
              Provider.of<CategoryNotifier>(context, listen: false);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CorporatePage(
                            item: companyItems.firstWhere(
                                (element) => element.title == result),
                          )));
            },
            title: Text(result),
          );
        });
  }
}
