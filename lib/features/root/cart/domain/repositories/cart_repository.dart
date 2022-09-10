import 'package:nike_flutter/core/resources/data_state.dart';
import 'package:nike_flutter/features/root/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<DataState<CartsEntity>> getCarts();

  Future<DataState> changeCount(String cartId, String count);

  Future<DataState> deleteProduct(String cartId);
}
