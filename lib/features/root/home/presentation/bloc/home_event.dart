part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// start Home
class HomeStarted extends HomeEvent {}

///no intenet
class HomeNoInternetConnection extends HomeEvent {}
