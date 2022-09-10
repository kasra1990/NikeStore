import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/core/utils/strings.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/data/model/response_data_model.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/domain/useCases/change_pass_usecase.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/domain/useCases/send_digit_code_usecase.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/domain/useCases/send_otp_code_usecase.dart';
import 'package:nike_flutter/features/root/auth/register/domain/entities/response_entity.dart';

import '../../../../../../core/network/network_info.dart';
part 'pass_recovery_event.dart';
part 'pass_recovery_state.dart';

class PassRecoveryBloc extends Bloc<PassRecoveryEvent, PassRecoveryState> {
  final SendDigitCodeUseCase _sendDigitCodeUseCase;
  final SendOtpCodeCodeUseCase _sendOtpCodeCodeUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final NetworkInfo _networkInfo;
  PassRecoveryBloc(this._sendDigitCodeUseCase, this._sendOtpCodeCodeUseCase,
      this._changePasswordUseCase, this._networkInfo)
      : super(PassRecoveryInitial()) {
    on<SendEmailEvent>(_sendDigitCode);
    on<SendVerification>(_sendOtpCode);
    on<SendNewPass>(_changePassword);
  }

  void _sendDigitCode(
      SendEmailEvent event, Emitter<PassRecoveryState> emit) async {
    emit(PassRecoveryLoading());
    var netState = await _networkInfo.isConnected;
    if (netState) {
      DataState dataState =
          await _sendDigitCodeUseCase.call(email: event.email);
      if (dataState is DataSuccess) {
        debugPrint("_sendDigitCode -> DataSuccess -> ${dataState.data}");
        emit(EmailValidation(dataState.data));
      }
      if (dataState is DataFaild) {
        debugPrint("_sendDigitCode -> DataFaild");
        emit(PassRecoveryError(dataState.error!));
      }
    } else {
      debugPrint("_sendDigitCode -> noConnection");
      emit(const PassRecoveryError(noConnection));
    }
  }

  void _sendOtpCode(
      SendVerification event, Emitter<PassRecoveryState> emit) async {
    emit(PassRecoveryLoading());
    var netState = await _networkInfo.isConnected;
    if (netState) {
      DataState dataState = await _sendOtpCodeCodeUseCase.call(
          id: event.id, verifyCode: event.verifyCode);
      if (dataState is DataSuccess) {
        emit(EmailValidation(dataState.data));
      }
      if (dataState is DataFaild) {
        emit(PassRecoveryError(dataState.error!));
      }
    } else {
      emit(const PassRecoveryError(noConnection));
    }
  }

  void _changePassword(
      SendNewPass event, Emitter<PassRecoveryState> emit) async {
    emit(PassRecoveryLoading());
    var netState = await _networkInfo.isConnected;
    if (netState) {
      DataState dataState = await _changePasswordUseCase.call(
          email: event.email, pass: event.pass);
      if (dataState is DataSuccess) {
        emit(ChangePassResult(dataState.data));
      }
      if (dataState is DataFaild) {
        emit(PassRecoveryError(dataState.error!));
      }
    } else {
      emit(const PassRecoveryError(noConnection));
    }
  }
}
