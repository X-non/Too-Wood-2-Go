import 'package:eatwise/pages/log_out_page.dart';
import 'package:eatwise/pages/payment_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:eatwise/pages/settings_page.dart';


class EWprofileList extends StatelessWidget {
  const EWprofileList ({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        OutlinedButton(onPressed:() => Navigator.push(
          context, 
          MaterialPageRoute(builder: (BuildContext context) => SettingsPage())),
          child: const Text('Inställningar')),
       OutlinedButton(onPressed:() => Navigator.push(
          context, 
          MaterialPageRoute(builder: (BuildContext context) => PaymentSettingsPage())) ,
          child: const Text('Betalningsmedel')),
        OutlinedButton(onPressed:() => Navigator.push(
          context, 
          MaterialPageRoute(builder: (BuildContext context) => LogOutPage())) ,
          child: const Text('Logga ut')),
      ],  
    );
  }
}