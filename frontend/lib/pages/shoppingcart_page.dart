import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/product.dart';
import 'package:eatwise/models/product_notifier.dart';
import 'package:eatwise/pages/payment.dart';
import 'package:eatwise/widgets/ew_product_list.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:eatwise/widgets/ew_shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Ta bort ---------
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

final List<ProductItem> items = List<ProductItem>.generate(
    3,
    (index) => ProductItem(
        img: 'assets/image/Gateau1.jpg',
        name: productName[index],
        priceOld: oldPrice[index],
        priceNew: newPrice[index],
        amount: 0));

// -------------

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key, required this.companyName});

  final String companyName;

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<ProductNotifier>(context);
    if (productItem.productItems.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        Navigator.pop(context);
      });
      return const SizedBox.shrink();
    }
    return EWScaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.shopping_basket_outlined,
                      size: 50,
                      color: EWColors.darkgreen,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      "Kundkorg",
                      style: EWTextStyles.titleBold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: Text(
                          widget.companyName,
                          style: EWTextStyles.title
                              .copyWith(color: EWColors.darkbrown),
                        ),
                      ),
                    ],
                  ),
                  EWProductList(items: productItem.productItems),
                ],
              ),
            ],
          ),
        ),
        productItem.productItems.isEmpty
            ? const SizedBox()
            : Column(
                children: [
                  const Spacer(),
                  const Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                        child: EWdeleteCart(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: EWshoppingCartButton(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Payment())),
                      buttonText: 'Betala',
                    ),
                  ),
                ],
              )
      ]),
    );
  }
}

class EWdeleteCart extends StatelessWidget {
  const EWdeleteCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductNotifier>(builder: (context, productNotifier, _) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Är du säker?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Avbryt"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      productNotifier.removeAll();
                    },
                    child: const Text("Ta Bort"),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          height: 40,
          width: 185,
          decoration: BoxDecoration(
            color: EWColors.primary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: EWColors.lightgreen,
            ),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
              ),
              Text(
                'Ta bort din order',
                style: EWTextStyles.body.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      );
    });
  }
}
