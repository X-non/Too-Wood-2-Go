import 'package:eatwise/constants/EW_styles.dart';
import 'package:flutter/material.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Cart Page', style: EWTextStyles.largeTitle));
  }
}
