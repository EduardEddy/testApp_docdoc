import 'package:chat_test/src/service/http_client.dart';
import 'package:chat_test/src/widgets/snack_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserCtrl {
  final url = 'http://192.168.10.14:3002/api';
  final snack = SnackWidget();

  get(BuildContext context, {String id = ''}) async {
    try {
      final response = await HttpClient().get('/users/$id');
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 422) {
          for (var error in e.response!.data['errors']) {
            snack.snack(context, error['msg'], Colors.black);
          }
        }
        if (e.response!.statusCode == 401) {
          snack.snack(context, e.response!.data['message'], Colors.black);
        }
      }
      return null;
    }
  }

  Future post(BuildContext context, dynamic data) async {
    try {
      final response = await HttpClient().postData('/users', data);
      snack.snack(context, 'Ya puedes inicial sesion', Colors.green);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 422) {
          for (var error in e.response!.data['errors']) {
            snack.snack(context, error['msg'], Colors.black);
          }
        }
        if (e.response!.statusCode == 401) {
          snack.snack(context, e.response!.data['message'], Colors.black);
        }
      }
      return null;
    }
  }
}
