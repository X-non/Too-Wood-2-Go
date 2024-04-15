import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';

class Item {
  final String img;
  final String title;
  final String subtitle;
  final bool favorite;

  Item(
      {required this.img,
      required this.favorite,
      required this.subtitle,
      required this.title});
}

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

final List<Item> items = List<Item>.generate(
    10,
    (index) => Item(
        img: 'assets/image/Gateau1.jpg',
        favorite: false,
        subtitle: companyDescription[index],
        title: companyNames[index]));

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return EWScaffold(
        body: ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromRGBO(173, 175, 145, 69),
                  )),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Image.asset(
                        width: double.infinity,
                        height: 75,
                        fit: BoxFit.fitWidth,
                        item.img),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              item.title,
                              style: EWTextStyles.titleBold,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              item.subtitle,
                              style: EWTextStyles.icon,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    ));
  }
}
