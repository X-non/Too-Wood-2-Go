import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/pages/register.dart';
import 'package:eatwise/widgets/ew_login_bar.dart';
import 'package:eatwise/widgets/ew_password_bar.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                "Logga in",
                style: EWTextStyles.titleBold,
              ),
            ]),
          ),
          const Expanded(child: Column()),
          Column(
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
                    name: 'Användarnamn',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: EWPasswordBar(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('hej');
                },
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(EWColors.lightgreen),
                ),
                child: const Text("Logga in"),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Register())),
                child: const Text("Registrera dig"),
              ),
            ],
          ),
          const Expanded(child: Column()),
        ],
      )),
    );
  }
}
