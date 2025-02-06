import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_absensi_app/core/constants/variables.dart';
import 'package:flutter_absensi_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_absensi_app/data/models/request/checkinout_request_model.dart';
import 'package:flutter_absensi_app/data/models/response/checkinout_response_model.dart';
import 'package:flutter_absensi_app/data/models/response/company_response_modal.dart';
import 'package:http/http.dart' as http;

class AttendanceRemoteDataSource {
  Future<Either<String, CompanyResponseModel>> getCompanyProfile() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/company');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return Right(CompanyResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get company profile');
    }
  }

  Future<Either<String, bool>> isCheckedin() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/attendance/is-checkedin');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode('$response.body');
      return Right(responseData['checkedin'] as bool);
    } else {
      return const Left('Failed to check checked in status');
    }
  }

  Future<Either<String, CheckInOutResponseModel>> checkin(
      CheckInOutRequestModel data) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/attendance/checkin');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: data.toJson(),
    );
    if (response.statusCode == 200) {
      return Right(CheckInOutResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to check in');
    }
  }

  Future<Either<String, CheckInOutResponseModel>> checkout(
      CheckInOutRequestModel data) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/attendance/checkin');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: data.toJson(),
    );
    if (response.statusCode == 200) {
      return Right(CheckInOutResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to check in');
    }
  }
}
