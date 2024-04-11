import 'package:eatwise/constants/EW_styles.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:flutter/material.dart';

class Item {
  final String img;
  final String product;
  final String priceOld;
  final String priceNew;

  Item(
      {required this.img,
      required this.product,
      required this.priceOld,
      required this.priceNew});
}

const List<String> productName = [
  'Bulle',
  'Banan',
  'Mjölk',
];

const List<String> oldPrice = [
  '15 kr',
  '10 kr',
  '10 kr',
];

const List<String> newPrice = [
  '10 kr',
  '5 kr',
  '7 kr',
];

final List<Item> items = List<Item>.generate(
    3,
    (index) => Item(
        img: 'assets/image/Gateau1.jpg',
        product: productName[index],
        priceOld: oldPrice[index],
        priceNew: newPrice[index]));

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EWScaffold(
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromRGBO(173, 175, 145, 69),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                            radius: 50, backgroundImage: AssetImage(item.img)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.product,
                            style: EWTextStyles.headline,
                          ),
                          Text(item.priceOld,
                              style: EWTextStyles.body.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  decorationThickness: 2.0)),
                          Text(
                            item.priceNew,
                            style: EWTextStyles.body,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              iconSize: 35,
                              color: EWColors.darkgreen,
                              onPressed: _decrementCounter,
                            ),
                            Text('$_counter'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              iconSize: 35,
                              color: EWColors.darkgreen,
                              onPressed: _incrementCounter,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
