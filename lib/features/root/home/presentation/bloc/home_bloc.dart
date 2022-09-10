import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/network/network_info.dart';
import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/core/utils/strings.dart';
import 'package:nike_flutter/features/root/home/data/model/home_data_model.dart';
import 'package:nike_flutter/features/root/home/domain/use_cases/get_home_data_usecase.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NetworkInfo _networkInfo;
  final GetHomeDataUseCase _useCase;
  HomeBloc(this._useCase, this._networkInfo) : super(HomeLoading()) {
    debugPrint("HomeBloc: Started");
    on<HomeStarted>(_start);
  }

  void _start(HomeStarted event, Emitter<HomeState> emit) async {
    debugPrint("HomeBloc: _start");
    emit(HomeLoading());
    var netState = await _networkInfo.isConnected;
    if (netState) {
      DataState dataState = await _useCase.call();
      debugPrint("HomeBloc --> dataState: $dataState");
      if (dataState is DataSuccess) {
        emit(HomeSuccess(homeDataModel: dataState.data));
      }
      if (dataState is DataFaild) {
        emit(const HomeError(error: netError));
      }
    } else {
      emit(const HomeError(error: noConnection));
    }
  }
}
