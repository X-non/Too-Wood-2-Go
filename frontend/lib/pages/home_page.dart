import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/constants/ew_token.dart';
import 'package:eatwise/models/category_notifier.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/favorite_notifier.dart';
import 'package:eatwise/models/pickup_notifier.dart';
import 'package:eatwise/models/product.dart';
import 'package:eatwise/pages/corporate.dart';
import 'package:eatwise/widgets/ew_company_container_small.dart';
import 'package:eatwise/widgets/ew_company_list.dart';
import 'package:eatwise/widgets/ew_confirm_order.dart';
import 'package:eatwise/widgets/ew_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<CompanyItem> items = CompanyItem.mockdata();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteItemsNotifier = Provider.of<FavoriteItemsNotifier>(context);

    final pickupNotifier = Provider.of<PickUpNotifier>(context);
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SizedBox(
              child: EWSearchBar(corporationNames: items),
            ),
          ),
          pickupNotifier.pickItems.isEmpty
              ? Container()
              : Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: pickupNotifier.pickItems.length,
                        itemBuilder: (context, index) {
                          final currentItem = pickupNotifier.pickItems[index];
                          return EWconfirmOrder(item: currentItem);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pickupNotifier.pickItems.length,
                          (index) => Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: const BoxDecoration(
                              color: EWColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
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
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'Du har inte några favoriter',
                        style: EWTextStyles.body,
                      ),
                    )
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
                            child: EWCompanyContainerSmall(
                              item: item,
                              navToBusiness: () => {
                                Provider.of<CategoryNotifier>(context,
                                        listen: false)
                                    .createList(productItems, ""),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CorporatePage(
                                              item: item,
                                            )))
                              },
                            ),
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
