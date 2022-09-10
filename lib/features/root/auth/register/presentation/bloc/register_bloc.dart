import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/utils/strings.dart';
import 'package:nike_flutter/features/root/auth/register/data/model/auth_data_model.dart';
import 'package:nike_flutter/features/root/auth/register/domain/entities/user_auth.dart';
import 'package:nike_flutter/features/root/auth/register/domain/useCases/sign_in_usecase.dart';
import 'package:nike_flutter/features/root/auth/register/domain/useCases/sign_up_usecase.dart';
import '../../../../../../core/network/network_info.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../domain/entities/auth_data_entity.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final NetworkInfo _networkInfo;
  RegisterBloc(this._signInUseCase, this._signUpUseCase, this._networkInfo)
      : super(RegisterInitialize()) {
    on<SignIn>(_singIn);
    on<SignUp>(_signUp);
    on<PasswordVisibility>(_changePasswordVisibility);
    on<RepeatPasswordVisibility>(_changeRepeatPasswordVisibility);
  }

  void _singIn(SignIn event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    var netState = await _networkInfo.isConnected;
    if (netState) {
      DataState dataState = await _signInUseCase.call(userAuth: event.userAuth);
      if (dataState is DataSuccess) {
        emit(SignInSuccess(dataState.data));
      }
      if (dataState is DataFaild) {
        emit(RegisterError(dataState.error!));
      }
    } else {
      emit(const RegisterError(noConnection));
    }
  }

  void _signUp(SignUp event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    var netState = await _networkInfo.isConnected;
    if (netState) {
      DataState dataState = await _signUpUseCase.call(userAuth: event.userAuth);
      if (dataState is DataSuccess) {
        emit(SignUpSuccess(dataState.data));
      }
      if (dataState is DataFaild) {
        emit(RegisterError(dataState.error!));
      }
    } else {
      emit(const RegisterError(noConnection));
    }
  }

  void _changePasswordVisibility(
      PasswordVisibility event, Emitter<RegisterState> emit) {
    emit(ChangePasswordVisibility(event.visibilityState));
  }

  void _changeRepeatPasswordVisibility(
      RepeatPasswordVisibility event, Emitter<RegisterState> emit) {
    emit(ChangeRepeatPasswordVisibility(event.visibilityState));
  }
}
