import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/account.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';

final List<AccountItem> accountinfo = AccountItem.mockdata();

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  //const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EWScaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Inställningar',
                  style: EWTextStyles.titleBold,
                ),
              ),
            ),
            EWSettingbutton(
              settingtype: 'Användarnamn',
              accountinfo: 'Cissi123',
            ),
          ],
        ),
      ),
    );
  }
}

class EWSettingbutton extends StatelessWidget {
  const EWSettingbutton({
    super.key,
    required this.settingtype,
    required this.accountinfo,
  });

  final String settingtype;
  final String accountinfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: InkWell(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: EWColors.lightgreen,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('$settingtype: '),
              ),
              const Spacer(),
              Text(accountinfo),
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.chevron_right_sharp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
