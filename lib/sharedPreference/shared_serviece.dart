import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:treatmentapp/models/loginModel/login_model.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_details") != null ? true : false;
  }

  static Future<void> setLoginDetails(LoginResponseModel? model) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonData = model != null ? jsonEncode(model.toJson()) : null;
    await prefs.setString("login_details", jsonData!);
  }

  static Future<void> logout() async {
    await setLoginDetails(null);
  }
}
