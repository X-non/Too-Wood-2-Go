import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:flutter/material.dart';

class EWProductWidget extends StatelessWidget {
  const EWProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: EWColors.lightgreen,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Namn',
                  style: EWTextStyles.headline,
                ),
                Text('Gammalt pris',
                    style: EWTextStyles.body.copyWith(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        decorationThickness: 2.0)),
                const Text(
                  'Nytt pris',
                  style: EWTextStyles.body,
                ),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    iconSize: 35,
                    color: EWColors.darkgreen,
                    onPressed: null,
                  ),
                  Text('0'),
                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 35,
                    color: EWColors.darkgreen,
                    onPressed: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
