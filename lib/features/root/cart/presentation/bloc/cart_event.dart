part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartStarted extends CartEvent {}

class CartAuth extends CartEvent {}

class CartDeleteProducts extends CartEvent {
  final String cartId;
  const CartDeleteProducts(this.cartId);
  @override
  List<Object?> get props => [cartId];
}

class CartIncreaseCount extends CartEvent {
  final CartEntity cart;

  const CartIncreaseCount(this.cart);
  @override
  List<Object?> get props => [cart];
}

class CartDecreaseCount extends CartEvent {
  final CartEntity cart;

  const CartDecreaseCount(this.cart);
  @override
  List<Object?> get props => [cart];
}

class CartCheckOut extends CartEvent {
  final String userId;

  const CartCheckOut(this.userId);
  @override
  List<Object?> get props => [userId];
}
