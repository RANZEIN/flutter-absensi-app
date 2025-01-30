import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_absensi_app/data/models/response/auth_response_model.dart';
import 'package:flutter_absensi_app/core/constants/variables.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String username, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }));

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to login');
    }
  }
}
