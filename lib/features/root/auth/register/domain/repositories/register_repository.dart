import 'package:nike_flutter/features/root/auth/register/domain/entities/auth_data_entity.dart';

import '../../../../../../core/resources/data_state.dart';

abstract class RegisterRepository {
  Future<DataState<AuthDataEntity>> singIn(
      {required String email, required String password});
  Future<DataState<AuthDataEntity>> singUp(
      {required String email, required String password});
}
