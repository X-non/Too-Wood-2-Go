import 'package:eatwise/constants/EW_styles.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Profile Page', style: EWTextStyles.largeTitle));
  }
}
