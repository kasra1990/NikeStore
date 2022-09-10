import 'package:nike_flutter/core/api/api_serivce.dart';

abstract class CategoryRemoteDataSource {
  Future<dynamic> gatCategory(String userId, String category);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiService apiService;

  CategoryRemoteDataSourceImpl(this.apiService);
  @override
  Future<dynamic> gatCategory(String userId, String category) async =>
      apiService.getCategory(userId, category);
}
