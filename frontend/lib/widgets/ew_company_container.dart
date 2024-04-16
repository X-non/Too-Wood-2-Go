import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompanyContainer extends StatefulWidget {
  const CompanyContainer({
    super.key,
    required this.item,
  });

  final CompanyItem item;

  @override
  _CompanyContainerState createState() => _CompanyContainerState();
}

class _CompanyContainerState extends State<CompanyContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: EWColors.lightgreen,
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Image.asset(
                width: double.infinity,
                height: 75,
                fit: BoxFit.fitWidth,
                widget.item.img,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.item.title,
                        style: EWTextStyles.headline
                            .copyWith(color: EWColors.darkgreen),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.item.subtitle,
                        style: EWTextStyles.icon
                            .copyWith(color: EWColors.darkgreen),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 45,
        left: 275,
        child: TextButton(
          onPressed: () {
            setState(() {
              // Toggle the favorite status
              widget.item.favorite = !widget.item.favorite;
            });
          }, // icon of the button
          style: TextButton.styleFrom(
            // styling the button
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: Colors.white, // Button color
            // Splash color
          ),
          child: Icon(
              widget.item.favorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color: EWColors.darkgreen),
        ),
      ),
    ]);
  }
}
