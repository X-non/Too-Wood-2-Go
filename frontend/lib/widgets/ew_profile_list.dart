import 'package:eatwise/constants/EW_styles.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/models/login_notifier.dart';
import 'package:eatwise/pages/settings_page.dart';
import 'package:eatwise/services/ew_tuple.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EWprofileList extends StatelessWidget {
  const EWprofileList({super.key});

  @override
  Widget build(BuildContext context) {
    List<EWtuple> tiles = [
      EWtuple('Inställningar', SettingsPage(), Icons.settings),
      EWtuple('Logga ut', const LogOut(), Icons.logout),
    ];

    return ListView.builder(
      itemCount: tiles.length,
      physics: const NeverScrollableScrollPhysics(),
      itemExtent: 100.0,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: EWColors.lightgreen,
            ),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.only(left: 30, top: 20.0, right: 20),
            onTap: () {
              if (tiles[index].label == 'Logga ut') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const LogOut();
                  },
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => tiles[index].nextPage,
                  ),
                );
              }
            },
            title: Text(
              tiles[index].label,
              style: EWTextStyles.headline,
            ),
            leading: Icon(
              tiles[index].ewIcon,
              color: EWColors.darkgreen,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: EWColors.darkgreen,
            ),
          ),
        );
      },
    );
  }
}

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: const Text(
        'Vill du logga ut?',
        style: EWTextStyles.headline,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Ja, logga ut mig');
            Provider.of<LoginNotifier>(context, listen: false).toggleLogin();
          },
          child: const Text(
            'Ja, logga ut mig',
            style: EWTextStyles.body,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Avbryt'),
          child: const Text(
            'Avbryt',
            style: EWTextStyles.body,
          ),
        ),
      ],
    );
  }
}
