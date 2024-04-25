import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EWLoginBar extends StatelessWidget {
  EWLoginBar({super.key, required this.name, required this.controllerUser});

  final String name;

  final TextEditingController controllerUser;
  


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TextField(
            controller: controllerUser,
            cursorColor: EWColors.primary,
            style: EWTextStyles.body,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: EWColors.primary)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: EWColors.primary)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: EWColors.primary)),
              hintText: name,
              contentPadding: const EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        )
      ],
    );

    ///TODO: det kommer behövas någon form av action när man trycker enter.
    //Vad händer när man sökt?
  }
}
