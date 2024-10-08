import 'package:eatwise/backend/network.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/pickup_notifier.dart';
import 'package:eatwise/models/product_notifier.dart';
import 'package:eatwise/widgets/ew_product_list.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:eatwise/widgets/ew_shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key, required this.company});

  final CompanyItem company;

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  static bool betala = false;

  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<ProductNotifier>(context);

    if (productItem.productItems.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.popUntil(context, (route) => route.isFirst);
        if (betala) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Hurra!",
                  style: EWTextStyles.headline,
                ),
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                content: const Text(
                  "Du hittar din bekräftelse på hemskärmen.",
                  style: EWTextStyles.body,
                ),
                actions: [
                  Center(
                      child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                color: EWColors.primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    'Okej!',
                                    style: EWTextStyles.headline
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  )),
                ],
              );
            },
          );
          betala = false;
        }
      });
      return const SizedBox.shrink(); // Return an empty widget
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
                          widget.company.title,
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
                      onTap: () {
                        Provider.of<PickUpNotifier>(context, listen: false)
                            .addPickUp(widget.company);
                        Provider.of<ProductNotifier>(context, listen: false)
                            .clearCache();
                        checkoutCart();
                        betala = true;
                      },
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
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                title: const Text(
                  "Är du säker?",
                  style: EWTextStyles.headline,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Avbryt",
                      style: EWTextStyles.body,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      productNotifier.removeAll();
                    },
                    child: const Text(
                      "Ja, ta bort",
                      style: EWTextStyles.body,
                    ),
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
                  Icons.remove_shopping_cart,
                  color: Colors.white,
                ),
              ),
              Text(
                'Rensa kundvagn',
                style: EWTextStyles.body.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      );
    });
  }
}
