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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: EWLoginBar(
                      name: 'Email',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: EWLoginBar(name: 'Användarnamn'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: EWPasswordBar(),
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
