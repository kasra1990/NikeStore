import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/features/root/home/domain/entities/home_data_entity.dart';
import 'package:nike_flutter/features/root/home/domain/repositories/home_repository.dart';

class GetHomeDataUseCase {
  final HomeRepository homeRepository;

  GetHomeDataUseCase(this.homeRepository);

  Future<DataState<HomeDataEntity>> call() => homeRepository.getHomeData();
}
