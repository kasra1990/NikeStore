import 'package:nike_flutter/features/root/category/domain/entities/category_entity.dart';
import '../../../../../core/api/models/product_model.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({List<ProductModel>? categories})
      : super(categories: categories);

  static CategoryModel parseJsonArray(List<dynamic> jsonArray) =>
      CategoryModel(categories: ProductModel.parseJsonArray(jsonArray));
}
