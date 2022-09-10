import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/features/root/auth/register/domain/entities/auth_data_entity.dart';
import 'package:nike_flutter/features/root/auth/register/domain/repositories/register_repository.dart';

import '../entities/user_auth.dart';

class SignInUseCase {
  final RegisterRepository _repository;

  SignInUseCase(this._repository);

  Future<DataState<AuthDataEntity>> call({required UserAuth userAuth}) {
    return _repository.singIn(
        email: userAuth.email, password: userAuth.password);
  }
}
