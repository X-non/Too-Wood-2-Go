import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/product.dart';
import 'package:flutter/material.dart';

class EWProductWidget extends StatefulWidget {
  final ProductItem product;
  const EWProductWidget({super.key, required this.product});

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<EWProductWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(widget.product.img),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.product.name,
                    style: EWTextStyles.headline,
                  ),
                  Text(widget.product.priceOld,
                      style: EWTextStyles.body.copyWith(
                          color: EWColors.darkgreen,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          decorationThickness: 2.0)),
                  Text(
                    widget.product.priceNew,
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
