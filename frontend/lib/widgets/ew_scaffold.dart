import 'package:eatwise/constants/ew_colors.dart';
import 'package:flutter/material.dart';

class EWScaffold extends StatelessWidget {
  const EWScaffold({
    super.key,
    this.navBar,
    this.appBar,
    required this.body,
  });

  final Widget body;
  final Widget? navBar;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
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
              bottomNavigationBar: navBar,
              appBar: appBar ??
                  AppBar(
                    surfaceTintColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    //automaticallyImplyLeading: false,
                  ),
              backgroundColor: Colors.transparent,
              body: body,
            )));
  }
}
