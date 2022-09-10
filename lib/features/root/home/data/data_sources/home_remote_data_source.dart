import 'package:nike_flutter/core/api/api_serivce.dart';

abstract class HomeRemoteDataSource {
  Future<dynamic> getHomeData();
}

class HomeDataRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;
  HomeDataRemoteDataSourceImpl(this.apiService);

  @override
  Future<dynamic> getHomeData() async => await apiService.getHomeData();
}
