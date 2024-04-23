import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/category_notifier.dart';
import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EWCategoriSearchbar extends StatefulWidget {
  const EWCategoriSearchbar({super.key});

  @override
  State<EWCategoriSearchbar> createState() => EWCategoriSearchbarState();
}

class EWCategoriSearchbarState extends State<EWCategoriSearchbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String current = "";

  final List<String> _categories = [
    'Allt',
    'Konditori',
    'Sallad',
    'Bröd',
    'MackorDDDDDDDDDD',
    'Annat'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(_updateTabStyling); // Listen for tab changes
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
                    padding:
                        EdgeInsets.only(left: index == 0 ? 8 : 4, right: 4),
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
                            style: EWTextStyles.body,
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
