part of 'pass_recovery_bloc.dart';

abstract class PassRecoveryEvent extends Equatable {
  const PassRecoveryEvent();

  @override
  List<Object?> get props => [];
}

class SendEmailEvent extends PassRecoveryEvent {
  final String email;
  const SendEmailEvent(this.email);
  @override
  List<Object?> get props => [email];
}

class SendVerification extends PassRecoveryEvent {
  final String id;
  final String verifyCode;
  const SendVerification(this.id, this.verifyCode);
  @override
  List<Object?> get props => [id, verifyCode];
}

class SendNewPass extends PassRecoveryEvent {
  final String email;
  final String pass;
  const SendNewPass(this.email, this.pass);
  @override
  List<Object?> get props => [email, pass];
}
