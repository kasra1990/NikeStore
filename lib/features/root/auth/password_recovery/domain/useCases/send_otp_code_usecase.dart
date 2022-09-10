import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/domain/repositories/pass_recovery_repository.dart';
import 'package:nike_flutter/features/root/auth/register/domain/entities/response_entity.dart';

class SendOtpCodeCodeUseCase {
  final PassRecoveryRepository _repository;

  SendOtpCodeCodeUseCase(this._repository);

  Future<DataState<ResponseEntity>> call(
      {required String id, required String verifyCode}) {
    return _repository.sendOTPVerification(id, verifyCode);
  }
}
