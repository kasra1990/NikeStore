import '../../../../../../core/resources/data_state.dart';
import '../entities/auth_data_entity.dart';
import '../entities/user_auth.dart';
import '../repositories/register_repository.dart';

class SignUpUseCase {
  final RegisterRepository _repository;

  SignUpUseCase(this._repository);

  Future<DataState<AuthDataEntity>> call({required UserAuth userAuth}) {
    return _repository.singUp(
        email: userAuth.email, password: userAuth.password);
  }
}
