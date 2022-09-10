part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class SignIn extends RegisterEvent {
  final UserAuth userAuth;
  const SignIn(this.userAuth);
  @override
  List<Object?> get props => [userAuth];
}

class PasswordVisibility extends RegisterEvent {
  final bool visibilityState;

  const PasswordVisibility(this.visibilityState);

  @override
  List<Object?> get props => [visibilityState];
}

class RepeatPasswordVisibility extends RegisterEvent {
  final bool visibilityState;

  const RepeatPasswordVisibility(this.visibilityState);

  @override
  List<Object?> get props => [visibilityState];
}

class SignUp extends RegisterEvent {
  final UserAuth userAuth;
  const SignUp(this.userAuth);
  @override
  List<Object?> get props => [userAuth];
}
