import 'package:eatwise/constants/EW_styles.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Map Page',
      style: EWTextStyles.largeTitle,
    ));
  }
}
