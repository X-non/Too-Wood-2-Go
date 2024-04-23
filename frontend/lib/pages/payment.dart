import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return const EWScaffold(
        body: Center(
      child: Text(
        'Pay up',
        style: EWTextStyles.largeTitle,
      ),
    ));
  }
}
