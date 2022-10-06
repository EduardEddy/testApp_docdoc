import 'package:chat_test/src/service/http_client.dart';
import 'package:chat_test/src/widgets/snack_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCtrl {
  final snack = SnackWidget();

  Future login(BuildContext context, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await HttpClient().postData('/login', data);
      await prefs.setInt('id', response.data['data']['id']);
      await prefs.setString('nombre', response.data['data']['nombre']);
      await prefs.setString('correo', response.data['data']['correo']);
      await prefs.setInt('edad', response.data['data']['edad']);
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
