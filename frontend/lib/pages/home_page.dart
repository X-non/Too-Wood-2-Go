import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/favorite_notifier.dart';
import 'package:eatwise/widgets/ew_company_container_small.dart';
import 'package:eatwise/widgets/ew_company_list.dart';
import 'package:eatwise/widgets/ew_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<CompanyItem> items = CompanyItem.mockdata();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteItemsNotifier = Provider.of<FavoriteItemsNotifier>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            children: [
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Vad är du sugen på?",
                    style: EWTextStyles.titleBold,
                  ),
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
          Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      "Dina favoriter",
                      style: EWTextStyles.headline,
                    ),
                  ),
                ],
              ),
              favoriteItemsNotifier.favoriteItems.isEmpty
                  ? const Text('Inga favoriter')
                  : SizedBox(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: favoriteItemsNotifier.favoriteItems.length,
                        itemBuilder: (context, index) {
                          final item =
                              favoriteItemsNotifier.favoriteItems[index];
                          return Padding(
                            padding: index == 0
                                ? const EdgeInsets.only(
                                    left: 16, right: 16, top: 4, bottom: 4)
                                : const EdgeInsets.only(
                                    right: 16, top: 4, bottom: 4),
                            child: EWCompanyContainerSmall(item: item),
                          );
                        },
                      ),
                    ),
            ],
          ),

          // Vertical ListView
          Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      "Butiker i din närhet",
                      style: EWTextStyles.headline,
                    ),
                  ),
                ],
              ),
              EWCompanyList(
                items: items,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
