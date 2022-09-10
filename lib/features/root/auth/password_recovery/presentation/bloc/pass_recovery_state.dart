part of 'pass_recovery_bloc.dart';

abstract class PassRecoveryState extends Equatable {
  const PassRecoveryState();

  @override
  List<Object?> get props => [];
}

class PassRecoveryInitial extends PassRecoveryState {}

class PassRecoveryLoading extends PassRecoveryState {}

class EmailValidation extends PassRecoveryState {
  final ResponseEntity model;
  const EmailValidation(this.model);
  @override
  List<Object?> get props => [model];
}

class ChangePassResult extends PassRecoveryState {
  final ResponseEntity model;
  const ChangePassResult(this.model);
  @override
  List<Object?> get props => [model];
}

class PassRecoveryError extends PassRecoveryState {
  final String error;
  const PassRecoveryError(this.error);
  @override
  List<Object?> get props => [error];
}
