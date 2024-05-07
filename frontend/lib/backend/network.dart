import 'dart:convert';
import 'package:eatwise/constants/ew_token.dart';
import 'package:eatwise/constants/ew_urls.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/product.dart';
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

Future<List<ProductItem>> getAds(String CompanyId) async {
  var url = "${EWApiUrls.apiAds}$CompanyId/";
  var token = EWToken.token;

  http.Response request = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Authorization": "Token $token"
  });

  if (request.statusCode == 200) {
    var result = json.decode(request.body) as List;

    List<ProductItem> ads =
        result.map<ProductItem>((e) => ProductItem.fromJson(e)).toList();

    return ads;
  } else {
    return List.empty();
  }
}

Future<List<CompanyItem>> fetchFavorite() async {
  var url = EWApiUrls.apiFavorite;
  var token = EWToken.token;

  http.Response request = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Authorization": "Token $token"
  });
  if (request.statusCode == 200) {
    var result = json.decode(request.body) as List;
    List<CompanyItem> favorites =
        result.map<CompanyItem>((e) => CompanyItem.fromJson(e)).toList();
    return favorites;
  } else {
    return List.empty();
  }
}

Future<void> setFavorite(String storeId, bool favorite) async {
  Map<String, dynamic> jsonData = {
    'store_id': storeId,
    'set_favorite': favorite
  };
  var url = EWApiUrls.apiFavorite;
  var token = EWToken.token;

  String object = jsonEncode(jsonData);

  await http.put(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token $token"
      },
      body: object);
}

Future<List<CompanyItem>> fetchCompanies() async {
  var url = EWApiUrls.apiStores;
  var token = EWToken.token;

  http.Response request = await http.get(Uri.parse(url), headers: {
    "Content-Type": "application/json",
    "Authorization": "Token $token"
  });
  if (request.statusCode == 200) {
    var result = json.decode(request.body) as List;
    List<CompanyItem> companies =
        result.map<CompanyItem>((e) => CompanyItem.fromJson(e)).toList();
    return companies;
  } else {
    return List.empty();
  }
}
