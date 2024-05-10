import 'package:delayed_widget/delayed_widget.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/category_notifier.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/favorite_notifier.dart';
import 'package:eatwise/models/product_notifier.dart';
import 'package:eatwise/pages/shoppingcart_page.dart';
import 'package:eatwise/widgets/ew_category_searchbar.dart';
import 'package:eatwise/widgets/ew_product_list.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:eatwise/widgets/ew_shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CorporatePage extends StatefulWidget {
  const CorporatePage({super.key, required this.item});

  final CompanyItem item;

  @override
  State<CorporatePage> createState() => _CorporatePageState();
}

class _CorporatePageState extends State<CorporatePage> {
  bool _showExitConfirmation = false;

  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<ProductNotifier>(context);
    final categoryItem = Provider.of<CategoryNotifier>(context);

    return PopScope(
        canPop: productItem.productItems.isEmpty ? true : false,
        onPopInvoked: (didPop) async {
          setState(() {
            _showExitConfirmation = true;
          });
        },
        child: EWScaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          body: Stack(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.item.title,
                        style: EWTextStyles.titleBold,
                      ),
                    ),
                  ),
                  EWCompanyProfile(widget: widget),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: EWCategorySearchbar(company: widget.item),
                  ),
                  categoryItem.allItems.isEmpty
                      ? DelayedWidget(
                          delayDuration: const Duration(milliseconds: 200),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: EWColors.beige,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Center(
                                  child: Text(
                                    "${widget.item.title} saknar för närvarande produkter till försäljning.",
                                    style: EWTextStyles.body,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : EWProductList(items: categoryItem.categoryItems),
                ],
              ),
            ),
            productItem.productItems.isEmpty
                ? const SizedBox()
                : Column(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: EWshoppingCartButton(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ShoppingCartPage(
                                        company: widget.item,
                                      ))),
                          buttonText: 'Gå till kundkorg',
                        ),
                      ),
                    ],
                  ),
            _showExitConfirmation
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: AlertDialog(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        title: const Text(
                          'Är du säker?',
                          style: EWTextStyles.headline,
                        ),
                        content: const Text(
                          'Om du lämnar sidan kommer din kundkorg att raderas',
                          style: EWTextStyles.body,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _showExitConfirmation = false;
                              });
                            },
                            child: const Text(
                              'Avbryt',
                              style: EWTextStyles.body,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _showExitConfirmation = false;
                              });
                              Navigator.pop(context);
                              productItem.removeAll();
                            },
                            child: const Text(
                              'Ja',
                              style: EWTextStyles.body,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ]),
        ));
  }
}

class EWCompanyProfile extends StatefulWidget {
  const EWCompanyProfile({
    super.key,
    required this.widget,
  });

  final CorporatePage widget;

  @override
  State<EWCompanyProfile> createState() => _EWCompanyProfileState();
}

class _EWCompanyProfileState extends State<EWCompanyProfile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteItemsNotifier>(
        builder: (context, favoriteItemsNotifier, _) {
      return SizedBox(
        height: 250,
        child: Stack(
          children: [
            Column(
              children: [
                const Spacer(),
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.widget.item.address,
                              style: EWTextStyles.body,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              Text(
                                'Öppet: ${widget.widget.item.openHours}',
                                style: EWTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                  widget.widget.item.img,
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 40,
              child: TextButton(
                onPressed: () {
                  favoriteItemsNotifier.toggleFavorite(widget.widget.item);
                  setState(() {
                    // Toggle the favorite status
                    widget.widget.item.favorite = !widget.widget.item.favorite;
                  });
                }, // icon of the button
                style: TextButton.styleFrom(
                  // styling the button
                  foregroundColor: EWColors.primary,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.white, // Button color
                  // Splash color
                ),
                child: Icon(
                  widget.widget.item.favorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: EWColors.darkgreen,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
