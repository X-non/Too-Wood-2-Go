import 'package:eatwise/constants/ew_styles.dart';
import 'package:flutter/material.dart';

class CategoriSerchbar extends StatefulWidget {
  const CategoriSerchbar({super.key});

  @override
  State<CategoriSerchbar> createState() => CategoriSerchbarState();
}

class CategoriSerchbarState extends State<CategoriSerchbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _categories = [
    'Konditori',
    'Sallad',
    'Bröd',
    'Mackor',
    'Annat'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(_updateTabStyling); // Listen for tab changes
  }

  void _updateTabStyling() {
    setState(() {});
  }

  static const Color lightgreen = Color(0XFFADB191);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            //Måste komma överens
            width: 1000,
            height: 45,
            child: Theme(
              data: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
                  surfaceVariant: Colors.transparent,
                ),
              ),
              child: TabBar(
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
                    child: Container(
                      height: 45,
                      width: 120,
                      decoration: BoxDecoration(
                        color:
                            _tabController.index == index ? lightgreen : null,
                        borderRadius: BorderRadius.circular(20),
                        border: _tabController.index == index
                            ? Border.all(
                                color: const Color.fromRGBO(173, 175, 145, 69),
                              )
                            : null,
                      ),
                        child: Center(
                          child: Text(
                          _categories[index],
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
