import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/widgets/ew_login_bar.dart';
import 'package:eatwise/widgets/ew_password_bar.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _mailController = TextEditingController();
    final TextEditingController _passController = TextEditingController();
    final TextEditingController _userPassController = TextEditingController();

    return EWScaffold(
      body: SizedBox(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(children: [
              Icon(Icons.person, color: EWColors.darkgreen),
              SizedBox(width: 10),
              Text(
                "Registrera dig",
                style: EWTextStyles.titleBold,
              ),
            ]),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Eatwise',
                    style: EWTextStyles.titleBold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: EWLoginBar(
                      name: 'Email',
                      controllerUser: _mailController,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: EWLoginBar(
                      name: 'Användarnamn',
                      controllerUser: _userPassController,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: EWPasswordBar(
                      controllerPassword: _passController,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(EWColors.lightgreen),
                  ),
                  child: const Text(
                    "Registrera dig",
                    style: EWTextStyles.body,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: Column()),
        ],
      )),
    );
  }
}
