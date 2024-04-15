import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/pages/corporate.dart';
import 'package:eatwise/widgets/ew_company_container.dart';
import 'package:eatwise/widgets/ew_company_container_small.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:eatwise/widgets/ew_search_bar.dart';
import 'package:flutter/material.dart';

const List<String> companyNames = [
  'UNO',
  'Gateau',
  'Bröd och Salt',
  'Espresso House',
  'ICA',
  'Güntherska',
  'Landings',
  'Centralbageriet',
  'Forsa',
  'Leijon bageri',
];

const List<String> companyDescription = [
  'Bröd och annat',
  'Torra bullar',
  'Gott gott gott',
  'Espresso House',
  'ICA',
  'Güntherska',
  'Landings',
  'Centralbageriet',
  'Forsa',
  'Leijon bageri',
];

final List<CompanyItem> items = List<CompanyItem>.generate(
    10,
    (index) => CompanyItem(
        img: 'assets/image/Gateau1.jpg',
        favorite: false,
        subtitle: companyDescription[index],
        title: companyNames[index]));

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return EWScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Vad är du sugen på?",
                      style: EWTextStyles.titleBold
                          .copyWith(color: EWColors.darkgreen),
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        "Dina favoriter",
                        style: EWTextStyles.headline
                            .copyWith(color: EWColors.darkgreen),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: index == 0
                            ? const EdgeInsets.only(
                                left: 16, right: 16, top: 4, bottom: 4)
                            : const EdgeInsets.only(
                                right: 16, top: 4, bottom: 4),
                        child: CompanyContainerSmall(item: item),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Vertical ListView
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        "Butiker i din närhet",
                        style: EWTextStyles.headline
                            .copyWith(color: EWColors.darkgreen),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 2.0),
                      child: TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CorporatePage())),
                        child: CompanyContainer(
                          item: item,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
