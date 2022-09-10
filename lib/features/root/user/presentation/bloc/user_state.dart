part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoginState extends UserState {
  final String userEmail;
  final bool isLogin;

  const UserLoginState({required this.userEmail, required this.isLogin});
  @override
  List<Object> get props => [userEmail, isLogin];
}
