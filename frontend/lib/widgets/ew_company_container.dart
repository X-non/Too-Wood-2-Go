import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/favorite_notifier.dart';
import 'package:eatwise/pages/corporate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EWCompanyContainer extends StatefulWidget {
  const EWCompanyContainer({
    super.key,
    required this.navToBusiness,
    required this.item,
  });

  final CompanyItem item;
  final void Function()? navToBusiness;

  @override
  _EWCompanyContainerState createState() => _EWCompanyContainerState();
}

class _EWCompanyContainerState extends State<EWCompanyContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteItemsNotifier>(
        builder: (context, favoriteItemsNotifier, _) {
      return Stack(children: <Widget>[
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: widget.navToBusiness,
          child: Ink(
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
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Image.asset(
                    width: double.infinity,
                    height: 75,
                    fit: BoxFit.fitWidth,
                    widget.item.img,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.item.title,
                            style: EWTextStyles.headline,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.item.description,
                            style: EWTextStyles.icon,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 45,
          left: 275,
          child: TextButton(
            onPressed: () {
              favoriteItemsNotifier.toggleFavorite(widget.item);
              setState(() {
                // Toggle the favorite status
                widget.item.favorite = !widget.item.favorite;
              });
            }, // icon of the button
            style: TextButton.styleFrom(
              // styling the button
              foregroundColor: EWColors.primary,
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
    });
  }
}
