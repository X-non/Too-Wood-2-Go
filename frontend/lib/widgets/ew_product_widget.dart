import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';

class EWProductWidget extends StatelessWidget {
  const EWProductWidget({super.key, required this.product});

  final ProductItem product;
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
    return Material(
        color: Colors.transparent,
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
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(product.img),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: EWTextStyles.headline
                        .copyWith(color: EWColors.darkgreen),
                  ),
                  Text(product.oldPrice,
                      style: EWTextStyles.body.copyWith(
                          color: EWColors.darkgreen,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          decorationThickness: 2.0)),
                  const Text(
                    product.newPrice,
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
        ));
  }
}
