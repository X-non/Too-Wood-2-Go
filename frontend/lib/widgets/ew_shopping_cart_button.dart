import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/models/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EWshoppingCartButton extends StatelessWidget {
  const EWshoppingCartButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  final void Function()? onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductNotifier>(builder: (context, productNotifier, _) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
              height: 75,
              decoration: BoxDecoration(
                color: EWColors.primary,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: EWColors.lightgreen,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Totalt: ${productNotifier.calculateCost()} kr',
                          style: EWTextStyles.headline
                              .copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: onTap,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: EWColors.darkgreen,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    buttonText,
                                    style: EWTextStyles.headline
                                        .copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )));
    });
  }
}
