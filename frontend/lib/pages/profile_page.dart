import 'package:eatwise/widgets/ew_profile_list.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20), // Adjust padding as needed
          child: EWprofileList(), // Instantiate and add the SearchBar widget
        ),
      ],
    ));
  }
}
