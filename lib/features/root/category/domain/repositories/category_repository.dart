import 'package:nike_flutter/core/resources/data_state.dart';
import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<DataState<CategoryEntity>> gatCategory(String category);
  CategoryEntity? getCategoriesList();
}
