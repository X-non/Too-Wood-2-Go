import 'package:eatwise/widgets/ew_profile_list.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 23.0),
        child: Column(
          children: [
            Expanded(
              child: EWprofileList(),
            ),
          ],
        ));
  }
}
