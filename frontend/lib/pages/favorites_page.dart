import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/favorite_notifier.dart';
import 'package:eatwise/widgets/ew_company_list.dart';
import 'package:eatwise/widgets/ew_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int totalPrice = 100;

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
                  color: EWColors.darkgreen,
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
          favoriteItemsNotifier.favoriteItems.isEmpty
              ? const SizedBox()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: SizedBox(
                    child: EWSearchBar(
                        corporationNames: favoriteItemsNotifier.favoriteItems),
                  ),
                ),
          favoriteItemsNotifier.favoriteItems.isEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: EWColors.lightgreen,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Du har inte några favoriter',
                          style: EWTextStyles.titleBold
                              .copyWith(color: EWColors.primary),
                          textAlign: TextAlign.center,
                        ),
                      )),
                )
              : EWCompanyList(
                  items: favoriteItemsNotifier.favoriteItems,
                ),
        ],
      ),
    );
  }
}
