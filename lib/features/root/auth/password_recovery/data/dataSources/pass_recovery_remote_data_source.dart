import 'package:nike_flutter/core/api/api_serivce.dart';

abstract class PassRecoveryRemoteDataSource {
  Future<dynamic> sendDigitCode(String email);
  Future<dynamic> sendOTPVerification(String id, String verifyCode);
  Future<dynamic> changePassword(String email, String pass);
}

class PassRecoveryRemoteDataSourceImpl extends PassRecoveryRemoteDataSource {
  final ApiService apiService;

  PassRecoveryRemoteDataSourceImpl(this.apiService);
  @override
  Future<dynamic> changePassword(String email, String pass) async =>
      await apiService.changePassword(email, pass);

  @override
  Future<dynamic> sendDigitCode(String email) async =>
      await apiService.sendDigitCode(email);

  @override
  Future<dynamic> sendOTPVerification(String id, String verifyCode) async =>
      await apiService.sendOTPVerification(id, verifyCode);
}
