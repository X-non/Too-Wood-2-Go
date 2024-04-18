import 'package:eatwise/constants/EW_styles.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/pages/payment.dart';
import 'package:flutter/material.dart';

class EWshoppingCartButton extends StatelessWidget {
  const EWshoppingCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                        'Totalt: 1000 kr',
                        style:
                            EWTextStyles.headline.copyWith(color: Colors.white),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Payment())),
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: EWColors.darkgreen,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Betala',
                                style: EWTextStyles.headline
                                    .copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
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
  }
}
