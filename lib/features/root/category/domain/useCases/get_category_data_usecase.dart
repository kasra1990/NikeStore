import 'package:nike_flutter/features/root/category/domain/entities/category_entity.dart';
import 'package:nike_flutter/features/root/category/domain/repositories/category_repository.dart';
import '../../../../../core/resources/data_state.dart';

class GetCategoryDataUseCase {
  final CategoryRepository repository;

  GetCategoryDataUseCase(this.repository);

  Future<DataState<CategoryEntity>> call(String category) =>
      repository.gatCategory(category);
}
