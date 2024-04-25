import 'package:dio/dio.dart';

final dio = Dio();

void fetchDadJoke() async {
  Response response;
  response = await dio.get(
    'https://icanhazdadjoke.com/',
    //queryParameters: {'id': 12, 'name': 'dio'},
  );
  print(response.data.toString());
}
