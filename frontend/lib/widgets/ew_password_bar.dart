import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:flutter/material.dart';

class EWPasswordBar extends StatelessWidget {
  EWPasswordBar({super.key, required this.controllerPassword});

  TextEditingController controllerPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TextField(
            controller: controllerPassword,
            obscureText: true,
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
              hintText: 'Lösenord',
              contentPadding: const EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
              suffixIcon: const IconButton(
                icon: Icon(Icons.remove_red_eye),
                iconSize: 30,
                color: EWColors.darkgreen,
                onPressed: null,
              ),
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
