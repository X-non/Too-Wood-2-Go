import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/account.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final List<String> settingLabels = [
    'Användarnamn',
    'E-post',
    'Telefonnummer',
    'Lösenord'
  ];

  final AccountItem value = AccountItem.mockdata();

  @override
  Widget build(BuildContext context) {
    return EWScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Inställningar',
                  style: EWTextStyles.titleBold,
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: settingLabels.length,
              itemBuilder: (context, index) {
                return EWSettingButton(
                  settingLabel: settingLabels[index],
                  settingValue: [
                    value.username,
                    value.email,
                    value.phonenumber,
                    value.password
                  ][index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EWSettingButton extends StatelessWidget {
  const EWSettingButton({
    super.key,
    required this.settingLabel,
    required this.settingValue,
  });

  final String settingLabel;
  final String settingValue;

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
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Ändra $settingLabel:',
                        style: EWTextStyles.headline,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(),
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
                child: Text(
                  '$settingLabel: ',
                  style: EWTextStyles.body,
                ),
              ),
              const Spacer(),
              Text(
                settingValue,
                style: EWTextStyles.body,
              ),
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
