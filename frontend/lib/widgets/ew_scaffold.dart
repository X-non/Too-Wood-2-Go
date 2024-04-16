import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:flutter/material.dart';

class EWScaffold extends StatelessWidget {
  const EWScaffold({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              EWColors.beige,
              EWColors.beige,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: Text(
              '',
              style: EWTextStyles.headline.copyWith(color: EWColors.darkgreen),
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: body,
        ));
  }
}
