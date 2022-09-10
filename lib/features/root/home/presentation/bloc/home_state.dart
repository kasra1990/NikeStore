part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// loading
class HomeLoading extends HomeState {}

/// for when get success
class HomeSuccess extends HomeState {
  final HomeDataModel homeDataModel;
  const HomeSuccess({required this.homeDataModel});
  @override
  List<Object?> get props => [homeDataModel];
}

/// for get back error
class HomeError extends HomeState {
  final String error;
  const HomeError({required this.error});
  @override
  List<Object?> get props => [error];
}
