import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:treatmentapp/models/loginModel/login_model.dart';
import 'package:treatmentapp/models/patientModel/patient_model.dart';

import '../constants/widgets.dart';

class APIService {
  Future<LoginResponseModel> login(
      String userName, String password, BuildContext context) async {
    try {
      String url = "https://flutter-amr.noviindus.in/api/Login";

      Map<String, String> commonHeaders = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final Map<String, dynamic> body = {
        "username": userName,
        "password": password
      };
      final response =
          await http.post(Uri.parse(url), headers: commonHeaders, body: body);
      var result = json.decode(response.body);

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('failed');
      }
    } catch (error) {
      throw Exception('$error');
    }
  }

  

}














