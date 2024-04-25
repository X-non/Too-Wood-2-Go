import 'dart:convert';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/constants/ew_token.dart';
import 'package:eatwise/constants/ew_urls.dart';
import 'package:eatwise/models/login_notifier.dart';
import 'package:eatwise/pages/home_page.dart';
import 'package:eatwise/pages/register.dart';
import 'package:eatwise/widgets/ew_login_bar.dart';
import 'package:eatwise/widgets/ew_password_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _userController = TextEditingController();
    final TextEditingController _passController = TextEditingController();

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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: EWLoginBar(
                      name: 'Användarnamn',
                      controllerUser: _userController,
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
                  onPressed: () async {
                    String Username = _userController.text;
                    String password = _passController.text;
                    _userController.text = '';
                    _passController.text = '';

                    Map<String, dynamic> jsonData = {
                      'username': Username,
                      'password': password
                    };

                    String object = jsonEncode(jsonData);
                    var url = EWApiUrls.apiLogin;

                    http.Response request = await http.post(Uri.parse(url),
                        headers: {"Content-Type": "application/json"},
                        body: object);

                    if (request.statusCode == 200) {
                      Map<String, dynamic> response = jsonDecode(request.body);
                      String token = response["token"];
                      EWToken.token = token;

                      loginNotifier.toggleLogin();
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                                "Felaktigt användarnamn eller lösenord"),
                            actions: [
                              ElevatedButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
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
