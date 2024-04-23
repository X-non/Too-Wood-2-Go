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
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CircleAvatar(
                  radius: 20,
                  //  backgroundImage: AssetImage(item.icon),
                ),
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    'Nice! Du har köpt från',
                    style: EWTextStyles.headline,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5, left: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hämta ut inom 10 minuter',
                style: EWTextStyles.body,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _onpressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: EWColors.lightgreen,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Jag har hämtat ut mina varor',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Atkinson',
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
