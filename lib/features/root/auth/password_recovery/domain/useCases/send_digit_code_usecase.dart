import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/domain/repositories/pass_recovery_repository.dart';
import 'package:nike_flutter/features/root/auth/register/domain/entities/response_entity.dart';

class SendDigitCodeUseCase {
  final PassRecoveryRepository _repository;

  SendDigitCodeUseCase(this._repository);

  Future<DataState<ResponseEntity>> call({required String email}) {
    return _repository.sendDigitCode(email);
  }
}
