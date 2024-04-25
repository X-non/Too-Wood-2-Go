import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:flutter/material.dart';

class EWconfirmOrder extends StatefulWidget {
  const EWconfirmOrder({super.key, required this.item});

  final CompanyItem item;

  @override
  State<EWconfirmOrder> createState() => EWconfirmOrderState();
}

class EWconfirmOrderState extends State<EWconfirmOrder> {
  void _onpressed() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: EWColors.lightgreen,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(widget.item.icon),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Nice! Du har köpt från',
                      style: EWTextStyles.headline,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35, right: 35, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hämta ut inom 10 minuter',
                  style: EWTextStyles.body,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: InkWell(
                onTap: _onpressed,
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
                                'Jag har hämtat ut mina varor',
                                style: EWTextStyles.headline
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )
            // ElevatedButton(
            //   onPressed: _onpressed,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: EWColors.primary,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //   ),
            //   child: Text('Jag har hämtat ut mina varor',
            //       style: EWTextStyles.headline.copyWith(color: Colors.white)),
            // ),
          ],
        ),
      ),
    );
  }
}
