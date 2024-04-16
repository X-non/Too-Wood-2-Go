import 'package:eatwise/constants/EW_styles.dart';
import 'package:eatwise/models/favorite_notifier.dart';
import 'package:eatwise/widgets/ew_company_list.dart';
import 'package:eatwise/widgets/ew_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final List<CompanyItem> allItems = CompanyItem.mockdata();
// final List<CompanyItem> favoriteItems = CompanyItem.getFavorites(allItems);

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final favoriteItemsNotifier = Provider.of<FavoriteItemsNotifier>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.favorite_border_outlined,
                  size: 50,
                ),
              ),
              SizedBox(
                child: Text(
                  "Favoriter",
                  style: EWTextStyles.titleBold,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SizedBox(
              child: EWSearchBar(),
            ),
          ),
          favoriteItemsNotifier.favoriteItems.isEmpty
              ? const Text('Inga favoriter')
              : EWCompanyList(
                  items: favoriteItemsNotifier.favoriteItems,
                ),
        ],
      ),
    );
  }
}
