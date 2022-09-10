import 'dart:convert';
import 'package:nike_flutter/core/local/shared_pref.dart';
import 'package:nike_flutter/features/root/auth/register/data/dataSources/register_remote_data_source.dart';
import 'package:nike_flutter/features/root/auth/register/domain/repositories/register_repository.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../../../../../core/utils/strings.dart';
import '../../domain/entities/auth_data_entity.dart';
import '../model/auth_data_model.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterRemoteDataSource _remoteDataSource;
  final NikeSharedPref _sharedPref;

  RegisterRepositoryImpl(this._remoteDataSource, this._sharedPref);

  @override
  Future<DataState<AuthDataEntity>> singIn(
      {required String email, required String password}) async {
    try {
      final response = await _remoteDataSource.singIn(email, password);
      if (response.statusCode == 200) {
        AuthDataEntity dataEntity =
            AuthDataModel.fromJson(jsonDecode(response.data));
        if (dataEntity.email != null) {
          _sharedPref.saveUser(
              dataModel: UserDataModel(
                  userId: dataEntity.userId, email: email, password: password));
          return DataSuccess(dataEntity);
        } else {
          return DataFaild(dataEntity.message!);
        }
      } else {
        return DataFaild(serverError);
      }
    } catch (e) {
      return DataFaild(netError);
    }
  }

  @override
  Future<DataState<AuthDataEntity>> singUp(
      {required String email, required String password}) async {
    try {
      final response = await _remoteDataSource.singUp(email, password);
      if (response.statusCode == 200) {
        AuthDataEntity dataEntity =
            AuthDataModel.fromJson(jsonDecode(response.data));
        if (dataEntity.email != null) {
          return DataSuccess(dataEntity);
        } else {
          return DataFaild(dataEntity.message!);
        }
      } else {
        return DataFaild(serverError);
      }
    } catch (e) {
      return DataFaild(netError);
    }
  }
}
