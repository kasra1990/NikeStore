import 'dart:convert';
import 'package:nike_flutter/core/local/shared_pref.dart';
import 'package:nike_flutter/features/root/category/data/dataSources/category_remote_data_source.dart';
import 'package:nike_flutter/features/root/category/data/model/category_model.dart';
import 'package:nike_flutter/features/root/category/domain/entities/category_entity.dart';
import 'package:nike_flutter/features/root/category/domain/repositories/category_repository.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/utils/strings.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _dataSource;
  final NikeSharedPref sharedPref;
  late CategoryEntity? _categoryEntity;
  CategoryRepositoryImpl(this._dataSource, this.sharedPref);
  @override
  Future<DataState<CategoryEntity>> gatCategory(String category) async {
    final user = await sharedPref.getUser();
    final userId = user.userId;
    try {
      final response = await _dataSource.gatCategory(userId!, category);
      if (response.statusCode == 200) {
        _categoryEntity =
            CategoryModel.parseJsonArray(jsonDecode(response.data));
        return DataSuccess(_categoryEntity);
      } else {
        return DataFaild(serverError);
      }
    } catch (e) {
      return DataFaild(netError);
    }
  }

  @override
  CategoryEntity? getCategoriesList() {
    return _categoryEntity;
  }
}
