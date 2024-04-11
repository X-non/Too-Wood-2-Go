import 'package:eatwise/constants/EW_styles.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Favorites Page',
      style: EWTextStyles.largeTitle.copyWith(color: EWColors.darkgreen),
    ));
  }
}
