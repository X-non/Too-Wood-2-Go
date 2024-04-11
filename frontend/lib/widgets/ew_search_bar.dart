import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:flutter/material.dart';

class EWSearchBar extends StatelessWidget {
  const EWSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TextField(
            cursorColor: EWColors.primary,
            style: EWTextStyles.body,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: EWColors.primary)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: EWColors.primary)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: EWColors.primary)),
              hintText: 'Sök',
              contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              prefixIcon: const Icon(Icons.search),
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
