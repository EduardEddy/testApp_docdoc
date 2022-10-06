import 'package:dio/dio.dart';

class HttpClient {
  final url = 'http://192.168.10.14:3002/api';

  get(String path) async {
    return await Dio().get('$url$path');
  }

  postData(String path, dynamic data) async {
    return await Dio().post('$url$path', data: data);
  }
}
