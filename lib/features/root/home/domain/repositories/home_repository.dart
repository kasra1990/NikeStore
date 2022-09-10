import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/features/root/home/domain/entities/home_data_entity.dart';

abstract class HomeRepository {
  Future<DataState<HomeDataEntity>> getHomeData();
}
