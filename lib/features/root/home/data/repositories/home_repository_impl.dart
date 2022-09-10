import 'dart:convert';
import 'package:nike_flutter/core/utils/strings.dart';
import 'package:nike_flutter/features/root/home/data/data_sources/home_remote_data_source.dart';
import 'package:nike_flutter/features/root/home/domain/repositories/home_repository.dart';
import '../../../../../core/resources/data_state.dart';
import '../../domain/entities/home_data_entity.dart';
import '../model/home_data_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<DataState<HomeDataEntity>> getHomeData() async {
    try {
      final response = await _remoteDataSource.getHomeData();
      if (response.statusCode == 200) {
        HomeDataEntity homeDataEntity =
            HomeDataModel.fromJson(jsonDecode(response.data));
        return DataSuccess(homeDataEntity);
      } else {
        return DataFaild(serverError);
      }
    } catch (e) {
      return DataFaild(netError);
    }
  }
}
