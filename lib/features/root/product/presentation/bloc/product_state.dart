part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

// Loading
class ProductLoading extends ProductState {}

/// product added successfully
class ProductAddedSuccess extends ProductState {
  final MessageModel model;

  const ProductAddedSuccess(this.model);
  @override
  List<Object?> get props => [model];
}

class ProductChangShoesSize extends ProductState {
  final String productSize;

  const ProductChangShoesSize(this.productSize);
  @override
  List<Object?> get props => [productSize];
}

/// user not login
class ProductUserNotLogin extends ProductState {}

/// manage error
class ProductError extends ProductState {
  final String error;

  const ProductError({required this.error});
  @override
  List<Object?> get props => [error];
}
