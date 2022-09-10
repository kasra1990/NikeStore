part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

///change shoes size
class ProductSetShoesSize extends ProductEvent {
  final String shoesSize;

  const ProductSetShoesSize(this.shoesSize);
  @override
  List<Object?> get props => [shoesSize];
}

/// add product to user cart
class ProductAddToCart extends ProductEvent {
  final String productId;

  const ProductAddToCart(this.productId);
  @override
  List<Object?> get props => [productId];
}
