part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartsEntity carts;
  final String totalPayment;
  const CartSuccess(this.carts, this.totalPayment);
  @override
  List<Object?> get props => [carts, totalPayment];
}

class CartDeleteSuccessfully extends CartState {}

class CartEmpty extends CartState {}

class CartNotAuthentication extends CartState {}

class CartMessage extends CartState {
  final String message;

  const CartMessage({required this.message});
  @override
  List<Object?> get props => [message];
}

class CartError extends CartState {
  final String error;
  const CartError({required this.error});
  @override
  List<Object?> get props => [error];
}
