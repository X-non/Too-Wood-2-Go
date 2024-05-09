import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/account.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<String> settingLabels = [
    'Användarnamn',
    'E-post',
    'Telefonnummer',
    'Lösenord'
  ];

  AccountItem value = AccountItem.mockdata();

  void updateAccountValue(int index, String newValue) {
    setState(() {
      switch (index) {
        case 0:
          value.username = newValue;
          break;
        case 1:
          value.email = newValue;
          break;
        case 2:
          value.phonenumber = newValue;
          break;
        case 3:
          value.password = newValue;
          break;
        default:
          break;
      }
    });
  }

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
                  onUpdate: (newValue) => updateAccountValue(index, newValue),
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
    required this.onUpdate,
  });

  final String settingLabel;
  final String settingValue;
  final ValueChanged<String> onUpdate;

  bool get isPassword => settingLabel.toLowerCase() == 'lösenord';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: InkWell(
        onTap: () async {
          final textResult = await showTextInputDialog(
            context: context,
            textFields: [
              DialogTextField(
                hintText: settingLabel,
                obscureText: isPassword,
              ),
            ],
            title: 'Ändra ${settingLabel.toLowerCase()}:',
          );
          if (textResult != null && textResult.isNotEmpty) {
            onUpdate(textResult.first);
          }
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
                isPassword ? '●●●●●●' : settingValue,
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
