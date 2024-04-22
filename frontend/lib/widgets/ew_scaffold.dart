import 'package:flutter/material.dart';

class EWScaffold extends StatelessWidget {
  const EWScaffold({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent, body: body);
  }
}
