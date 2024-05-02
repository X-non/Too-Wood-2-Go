import 'dart:convert';
import 'package:eatwise/constants/ew_token.dart';
import 'package:eatwise/constants/ew_urls.dart';
import 'package:eatwise/models/login_notifier.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/widgets/ew_login_bar.dart';
import 'package:eatwise/widgets/ew_password_bar.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _mailController = TextEditingController();
    final TextEditingController _passController = TextEditingController();
    final TextEditingController _userController = TextEditingController();

    return Consumer<LoginNotifier>(builder: (context, loginNotifier, _) {
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
                      String username = _userController.text;
                      String password = _passController.text;
                      String mail = _mailController.text;
                      _userController.text = '';
                      _passController.text = '';
                      _mailController.text = '';

                      Map<String, dynamic> jsonData = {
                        'username': username,
                        'password': password,
                        'email': mail,
                      };

                      String object = jsonEncode(jsonData);
                      var url = EWApiUrls.apiRegisterUser;

                      http.Response request = await http.post(Uri.parse(url),
                          headers: {"Content-Type": "application/json"},
                          body: object);

                      if (request.statusCode == 200) {
                        Map<String, dynamic> response =
                            jsonDecode(request.body);
                        String token = response["token"];
                        EWToken.token = token;
                        loginNotifier.toggleLogin();
                        Navigator.pop(context);
                      } else {
                        Map<String, dynamic> response =
                            jsonDecode(request.body);
                        String errorMessage = response["context"];

                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                errorMessage,
                                style: EWTextStyles.body,
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text(
                                    "OK",
                                    style: EWTextStyles.body,
                                  ),
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
    });
  }
}
