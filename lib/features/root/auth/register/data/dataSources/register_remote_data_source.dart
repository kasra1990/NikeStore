import 'package:nike_flutter/core/api/api_serivce.dart';

abstract class RegisterRemoteDataSource {
  Future<dynamic> singIn(String email, String password);
  Future<dynamic> singUp(String email, String password);
}

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  final ApiService apiService;

  RegisterRemoteDataSourceImpl(this.apiService);
  @override
  Future<dynamic> singIn(String email, String password) async =>
      apiService.signIn(email, password);

  @override
  Future<dynamic> singUp(String email, String password) async =>
      apiService.signUp(email, password);
}
