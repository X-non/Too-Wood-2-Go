import 'package:eatwise/pages/log_out_page.dart';
import 'package:eatwise/pages/payment_settings_page.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:eatwise/pages/settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:eatwise/services/ew_tuple.dart';

class EWprofileList extends StatelessWidget {
  const EWprofileList({super.key});

  @override
  Widget build(BuildContext context) {
    List<EWtuple> tiles = [
      EWtuple('Inställningar', const SettingsPage(), Icons.settings),
      EWtuple(
          'Betalningsmedel', const PaymentSettingsPage(), Icons.credit_card),
      EWtuple('Logga ut', const LogOutPage(), Icons.logout),
    ];

    return ListView.builder(
      itemCount: tiles.length,
      physics: const NeverScrollableScrollPhysics(),
      itemExtent: 100.0,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          contentPadding: const EdgeInsets.only(left: 32, top: 19.0, right: 20),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => tiles[index].nextPage)),
          title: Text(tiles[index].label),
          leading: Icon(tiles[index].ewIcon),
          trailing: const Icon(Icons.arrow_forward_ios),
        ));
      },
    );
  }
}
