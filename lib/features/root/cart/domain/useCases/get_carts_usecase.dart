import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/features/root/cart/domain/entities/cart_entity.dart';
import 'package:nike_flutter/features/root/cart/domain/repositories/cart_repository.dart';

class GetCartsUseCase {
  final CartRepository _repository;

  GetCartsUseCase(this._repository);
  Future<DataState<CartsEntity>> call() {
    return _repository.getCarts();
  }
}
