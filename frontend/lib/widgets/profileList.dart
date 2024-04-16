import 'package:eatwise/pages/log_out_page.dart';
import 'package:eatwise/pages/payment_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:eatwise/pages/settings_page.dart';
import 'package:flutter/widgets.dart';

class EWprofileList extends StatelessWidget {
  const EWprofileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
            style:
                const ButtonStyle(alignment: Alignment.centerLeft), // WTF????
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SettingsPage())),
            child: const Text('Inställningar')),
        OutlinedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const PaymentSettingsPage())),
            child: const Text('Betalningsmedel')),
        OutlinedButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const LogOutPage())),
            child: const Text('Logga ut')),
      ],
    );
  }
}
