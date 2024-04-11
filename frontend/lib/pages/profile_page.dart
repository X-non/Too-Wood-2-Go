import 'package:eatwise/constants/EW_styles.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:flutter/material.dart';
import 'package:eatwise/widgets/profileList.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), // Adjust padding as needed
          child: EWprofileList(), // Instantiate and add the SearchBar widget
        ),
      ],
    );
  }
}
