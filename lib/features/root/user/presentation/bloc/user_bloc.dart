import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/local/shared_pref.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final NikeSharedPref _sharedPref;
  UserBloc(this._sharedPref) : super(UserInitial()) {
    on<UserLoginEvent>(_checkLoginState);
  }

  /// check user login
  void _checkLoginState(UserLoginEvent event, Emitter<UserState> emit) async {
    final userData = await _sharedPref.getUser();
    final userEmail = userData.email;
    if (userEmail!.isEmpty) {
      emit(const UserLoginState(userEmail: "Guest User", isLogin: false));
    } else if (userEmail.isNotEmpty) {
      emit(UserLoginState(isLogin: true, userEmail: userEmail));
    }
  }
}
