import 'package:flutter/material.dart';

class LogOutPage extends StatelessWidget {
  const LogOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vill du logga ut?'),
        centerTitle: true,
      ),
    );
  }
}
