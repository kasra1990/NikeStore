import 'package:dio/dio.dart';
import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/features/root/auth/register/domain/entities/response_entity.dart';

abstract class PassRecoveryRepository {
  Future<DataState<ResponseEntity>> sendDigitCode(String email);
  Future<DataState<ResponseEntity>> sendOTPVerification(
      String id, String verifyCode);
  Future<DataState<ResponseEntity>> changePassword(String email, String pass);
}
