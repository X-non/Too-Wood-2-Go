import 'package:eatwise/backend/network.dart';
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
  void _incrementCounter(ProductNotifier notifier) async {
    bool success = await addToCart(widget.product.id, 1);
    if (success) {
      setState(() {
        widget.product.inCart++;
        notifier.toggleProduct(widget.product);
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'Finns inte fler av denna vara.',
              style: EWTextStyles.headline,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Okej',
                  style: EWTextStyles.body,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _decrementCounter(ProductNotifier notifier) async {
    if (widget.product.inCart > 0) {
      bool success = await removeFromCart(widget.product.id, 1);
      if (success) {
        setState(() {
          widget.product.inCart--;
          notifier.toggleProduct(widget.product);
        });
      }
    }
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
                    maxRadius: 50,
                    child: ClipPath(
                        clipper:
                            const ShapeBorderClipper(shape: CircleBorder()),
                        child: Image.network(
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                            widget.product.img)),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.product.name,
                        style: EWTextStyles.headline,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("${widget.product.priceOld} kr",
                          overflow: TextOverflow.ellipsis,
                          style: EWTextStyles.body.copyWith(
                              color: EWColors.darkgreen,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 2.0)),
                      Text(
                        "${widget.product.priceNew} kr",
                        overflow: TextOverflow.ellipsis,
                        style: EWTextStyles.body,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.product.inCart == 0
                      ? TextButton(
                          onPressed: () => {
                            _incrementCounter(productNotifier),
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
                                _decrementCounter(productNotifier),
                              },
                            ),
                            Text(widget.product.inCart.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              iconSize: 35,
                              color: EWColors.darkgreen,
                              onPressed: () => {
                                _incrementCounter(productNotifier),
                              },
                            ),
                            widget.product.inCart > 0
                                ? IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    iconSize: 35,
                                    color: EWColors.darkgreen,
                                    onPressed: () => {
                                          removeFromCart(widget.product.id,
                                              widget.product.inCart),
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
