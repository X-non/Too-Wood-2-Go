import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/login_notifier.dart';
import 'package:eatwise/pages/home_page.dart';
import 'package:eatwise/pages/register.dart';
import 'package:eatwise/widgets/ew_login_bar.dart';
import 'package:eatwise/widgets/ew_password_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(builder: (context, loginNotifier, _) {
      return SizedBox(
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
                    loginNotifier.toggleLogin();
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(EWColors.lightgreen),
                  ),
                  child: const Text(
                    "Logga in",
                    style: EWTextStyles.body,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Register())),
                  child: Text(
                    "Registrera dig",
                    style: EWTextStyles.body.copyWith(color: EWColors.primary),
                  ),
                ),
              ],
            ),
            const Expanded(child: Column()),
          ],
        ),
      );
    });
  }
}
