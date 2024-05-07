import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/product.dart';
import 'package:eatwise/models/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EWProductWidget extends StatefulWidget {
  final ProductItem product;
  const EWProductWidget({super.key, required this.product});

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<EWProductWidget> {
  void _incrementCounter() {
    setState(() {
      widget.product.amount++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (widget.product.amount > 0) {
        widget.product.amount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductNotifier>(builder: (context, productNotifier, _) {
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
                  child: widget.product.amount == 0
                      ? TextButton(
                          onPressed: () => {
                            _incrementCounter(),
                            productNotifier.toggleProduct(widget.product),
                          }, // icon of the button
                          style: TextButton.styleFrom(
                            // styling the button
                            foregroundColor: EWColors.primary,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15),
                            backgroundColor: EWColors.primary, // Button color
                            // Splash color
                          ),
                          child: const Icon(
                            Icons.shopping_basket,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      : Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              iconSize: 35,
                              color: EWColors.darkgreen,
                              onPressed: () => {
                                _decrementCounter(),
                                productNotifier.toggleProduct(widget.product),
                              },
                            ),
                            Text(widget.product.amount.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              iconSize: 35,
                              color: EWColors.darkgreen,
                              onPressed: () => {
                                _incrementCounter(),
                                productNotifier.toggleProduct(widget.product),
                              },
                            ),
                            widget.product.amount > 0
                                ? IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    iconSize: 35,
                                    color: EWColors.darkgreen,
                                    onPressed: () => {
                                          productNotifier
                                              .removeProduct(widget.product),
                                        })
                                : const SizedBox()
                          ],
                        ),
                ),
              ],
            ),
          ));
    });
  }
}
