import 'package:eatwise/backend/maps.dart';
import 'package:eatwise/constants/EW_styles.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eatwise/pages/home_page.dart';


class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  EWScaffold(
      body: Column(children: [   
      Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(children: [
              const Icon(Icons.map, color: EWColors.darkgreen),
              const SizedBox(width: 10),
              Text(
                "Karta",
                style:
                    EWTextStyles.titleBold.copyWith(color: EWColors.darkgreen),
              ),],
            ), 
          ),
         Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8), 
            child:  Container(
                          decoration: BoxDecoration(borderRadius:  BorderRadius.circular(10), ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10), 
              child: const EWMap(),), 
            )
          )),
          SizedBox(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        "Butiker i din närhet",
                        style: EWTextStyles.headline
                            .copyWith(color: EWColors.darkgreen),
                    ),
                  ),
                ),
          const Expanded(child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
          ))

      ], )
      );             
  }
}
