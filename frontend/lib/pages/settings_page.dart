import 'package:flutter/material.dart';
import 'package:eatwise/constants/EW_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  //const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inställningar'),
        centerTitle: true,
      ),
    );
  }
}
