import 'dart:convert';

import 'package:flutter_absensi_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  static const String _authKey = 'auth_data';

  /// Save the auth data to local storage as JSON string.
  Future<void> saveAuthData(AuthResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_authKey, jsonEncode(data.toMap()));
  }

  /// Remove auth data from local storage.
  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_authKey);
  }

  /// Retrieve authentication data from local storage.
  Future<AuthResponseModel?> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString(_authKey);
    if (data != null) {
      return AuthResponseModel.fromJson(data);
    }
    return null;
  }

  /// Check if the user is authenticated (has auth data).
  Future<bool> isAuth() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey(_authKey);
  }
}
