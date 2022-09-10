import 'dart:convert';
import 'package:nike_flutter/features/root/auth/password_recovery/data/dataSources/pass_recovery_remote_data_source.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/data/model/response_data_model.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/domain/repositories/pass_recovery_repository.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/strings.dart';
import '../../../register/domain/entities/response_entity.dart';

class PassRecoveryRepositoryImpl extends PassRecoveryRepository {
  final PassRecoveryRemoteDataSource dataSource;

  PassRecoveryRepositoryImpl(this.dataSource);
  @override
  Future<DataState<ResponseEntity>> changePassword(
      String email, String pass) async {
    try {
      final response = await dataSource.changePassword(email, pass);
      if (response.statusCode == 200) {
        ResponseEntity responseEntity =
            ResponseDataModel.fromJson(jsonDecode(response.data));
        return DataSuccess(responseEntity);
      } else {
        return DataFaild(serverError);
      }
    } catch (e) {
      return DataFaild(netError);
    }
  }

  @override
  Future<DataState<ResponseEntity>> sendDigitCode(String email) async {
    try {
      final response = await await dataSource.sendDigitCode(email);
      if (response.statusCode == 200) {
        ResponseEntity responseEntity =
            ResponseDataModel.fromJson(jsonDecode(response.data));
        return DataSuccess(responseEntity);
      } else {
        return DataFaild(serverError);
      }
    } catch (e) {
      return DataFaild(netError);
    }
  }

  @override
  Future<DataState<ResponseEntity>> sendOTPVerification(
      String id, String verifyCode) async {
    try {
      final response = await dataSource.sendOTPVerification(id, verifyCode);
      if (response.statusCode == 200) {
        ResponseEntity responseEntity =
            ResponseDataModel.fromJson(jsonDecode(response.data));
        return DataSuccess(responseEntity);
      } else {
        return DataFaild(serverError);
      }
    } catch (e) {
      return DataFaild(netError);
    }
  }
}
