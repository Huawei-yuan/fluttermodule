import 'package:http/http.dart' as client;
import 'package:dio/dio.dart';

void testHttp() {
  var apiUrl = 'https://www.wanandroid.com/friend/json';

  client.get(Uri.parse(apiUrl)).then((response) {
    print("addFile statusCode = ${response.statusCode}");
    print("addFile body = ${response.body}");
  });
}

final dio = Dio();

void testDio() async {
  final response = await dio.get('https://www.wanandroid.com/friend/json');
  print("testDio response = $response");
}