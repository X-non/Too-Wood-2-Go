import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/pickup_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EWconfirmOrder extends StatefulWidget {
  const EWconfirmOrder({super.key, required this.item});

  final CompanyItem item;

  @override
  State<EWconfirmOrder> createState() => EWconfirmOrderState();
}

class EWconfirmOrderState extends State<EWconfirmOrder> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(widget.item.icon),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Nice! Du har köpt från ${widget.item.title}',
                      style: EWTextStyles.headline,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hämta ut inom 10 minuter',
                    style: EWTextStyles.body,
                  ),
                ),
              ),
              InkWell(
                onTap: () => () => {
                      Provider.of<PickUpNotifier>(context, listen: false)
                          .removePickUp(widget.item),
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
                                'Jag har hämtat ut mina varor',
                                style: EWTextStyles.headline
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
