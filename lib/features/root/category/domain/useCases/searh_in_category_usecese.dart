import 'package:nike_flutter/features/root/category/domain/repositories/category_repository.dart';

import '../../../../../core/resources/data_state.dart';
import '../entities/category_entity.dart';

class SearchInCategoryUseCase {
  final CategoryRepository repository;

  SearchInCategoryUseCase(this.repository);

  DataState<CategoryEntity> call({required String query}) {
    if (query.isNotEmpty) {
      final result = repository
          .getCategoriesList()!
          .categories!
          .where((item) => item.name!.toLowerCase().contains(query))
          .toList();
      return DataSuccess(CategoryEntity(categories: result));
    } else {
      return DataSuccess(CategoryEntity(
          categories: repository.getCategoriesList()!.categories!));
    }
  }
}
