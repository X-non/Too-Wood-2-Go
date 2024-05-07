import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/category_notifier.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EWCategorySearchbar extends StatefulWidget {
  CompanyItem company;
  EWCategorySearchbar({super.key, required this.company});
  bool init = false;

  @override
  State<EWCategorySearchbar> createState() => EWCategorySearchbarState();
}

class EWCategorySearchbarState extends State<EWCategorySearchbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String current = "";

  List<String> _categories = [];

  iniateCategorier() => {
        print('heheh ${CategoryNotifier().allItems}'),
        for (ProductItem product in CategoryNotifier().allItems)
          {
            if (!_categories.contains(product.category))
              {
                _categories.add(product.category),
              }
          },
        _categories.sort(),
        if (_categories.isNotEmpty)
          {
            _categories.insert(0, "Allt"),
          }
      };

  Future<void> initCategories() async {
    List<ProductItem> allProducts =
        await Provider.of<CategoryNotifier>(context, listen: false)
            .updateAds(widget.company.storeId);
    for (ProductItem product in allProducts) {
      if (!_categories.contains(product.category)) {
        _categories.add(product.category);
      }
    }
    _categories.sort();
    if (_categories.isNotEmpty) {
      _categories.insert(0, "Allt");
    }
    if (!widget.init) {
      widget.init = true;
    }
  }

  @override
  void initState() {
    super.initState();
    initCategories();
  }

  void _updateTabStyling() {
    setState(() {
      current = _categories[_tabController.index];
      Provider.of<CategoryNotifier>(context, listen: false)
          .createList([], current);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FutureBuilder<void>(
      future: initCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error loading categories: ${snapshot.error}');
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Theme(
                  data: theme.copyWith(
                    colorScheme: theme.colorScheme.copyWith(
                      surfaceVariant: Colors.transparent,
                    ),
                  ),
                  child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.start,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    isScrollable: true,
                    controller: _tabController,
                    labelColor: Colors.black,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.transparent, width: 0),
                      ),
                    ),
                    tabs: List.generate(
                      _categories.length,
                      (index) => Tab(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 8 : 4, right: 4),
                          child: Container(
                            height: 45,
                            width: 100,
                            decoration: BoxDecoration(
                              color: _tabController.index == index
                                  ? EWColors.lightgreen
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: EWColors.lightgreen),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  _categories[index],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: _tabController.index == index
                                      ? EWTextStyles.body
                                          .copyWith(color: Colors.white)
                                      : EWTextStyles.body,
                                  selectionColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
