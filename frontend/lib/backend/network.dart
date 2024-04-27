import 'dart:convert';

import 'package:eatwise/constants/ew_token.dart';
import 'package:eatwise/constants/ew_urls.dart';
import 'package:http/http.dart' as http;

Future<bool> login(String username, String password) async {
  Map<String, dynamic> jsonData = {'username': username, 'password': password};

  String object = jsonEncode(jsonData);
  var url = EWApiUrls.apiLogin;

  http.Response request = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: object);

  if (request.statusCode == 200) {
    Map<String, dynamic> response = jsonDecode(request.body);
    String token = response["token"];
    EWToken.token = token;

    return true;
  } else {
    return false;
  }
}
