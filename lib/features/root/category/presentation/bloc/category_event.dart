part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

/// Request a list of products
class CategoryStarted extends CategoryEvent {
  final String category;

  const CategoryStarted({required this.category});
  @override
  List<Object?> get props => [category];
}

/// search in list
class CategorySearchQuery extends CategoryEvent {
  final String searchQuery;
  const CategorySearchQuery(this.searchQuery);
  @override
  List<Object?> get props => [searchQuery];
}
