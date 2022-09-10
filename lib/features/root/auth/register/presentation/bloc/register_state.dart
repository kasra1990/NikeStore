part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitialize extends RegisterState {}

class RegisterLoading extends RegisterState {}

class ChangePasswordVisibility extends RegisterState {
  final bool visibilityState;

  const ChangePasswordVisibility(this.visibilityState);
  @override
  List<Object?> get props => [visibilityState];
}

class ChangeRepeatPasswordVisibility extends RegisterState {
  final bool visibilityState;

  const ChangeRepeatPasswordVisibility(this.visibilityState);
  @override
  List<Object?> get props => [visibilityState];
}

class SignInSuccess extends RegisterState {
  final AuthDataEntity authDataEntity;
  const SignInSuccess(this.authDataEntity);
  @override
  List<Object?> get props => [authDataEntity];
}

class SignUpSuccess extends RegisterState {
  final AuthDataModel authDataModel;
  const SignUpSuccess(this.authDataModel);
  @override
  List<Object?> get props => [authDataModel];
}

class RegisterError extends RegisterState {
  final String error;
  const RegisterError(this.error);
  @override
  List<Object?> get props => [error];
}
