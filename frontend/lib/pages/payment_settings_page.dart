import 'package:flutter/material.dart';

class PaymentSettingsPage extends StatelessWidget {
  const PaymentSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Betalningsmedel'),
        centerTitle: true,
      ),
    );
  }
}
