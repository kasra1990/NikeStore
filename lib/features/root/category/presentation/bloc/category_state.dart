part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

/// Loading
class CategoryLoading extends CategoryState {}

/// get list of product successfully
class CategorySuccess extends CategoryState {
  final CategoryEntity entity;

  const CategorySuccess(this.entity);
  @override
  List<Object?> get props => [entity];
}

/// result of search in list
class CategorySearchResult extends CategoryState {
  final List<ProductModel>? products;

  const CategorySearchResult(this.products);
  @override
  List<Object?> get props => [products];
}

/// error
class CategoryError extends CategoryState {
  final String error;
  const CategoryError({required this.error});
  @override
  List<Object?> get props => [error];
}
