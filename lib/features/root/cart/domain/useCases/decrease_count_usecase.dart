import 'package:nike_flutter/features/root/cart/domain/repositories/cart_repository.dart';

import '../../../../../core/resources/data_state.dart';
import '../entities/cart_entity.dart';

class DecreaseCountUseCase {
  final CartRepository _repository;

  DecreaseCountUseCase(this._repository);
  Future<DataState> call(
      {required CartEntity cartEntity,
      required CartsEntity cartsEntity}) async {
    // create instance of DataState
    late DataState dataState;

    /// get and increase count of cart
    String count = (int.parse(cartEntity.count!) - 1).toString();

    /// send request for increase count of cart
    var result = await _repository.changeCount(cartEntity.cartId!, count);

    /// check state
    if (result is DataSuccess) {
      /// get index of cart in list of carts
      final index = cartsEntity.carts
          .indexWhere((element) => element.cartId == cartEntity.cartId);

      /// set count number to the cart in list of carts
      cartsEntity.carts[index].count = count;
      dataState = DataSuccess(cartsEntity);
    } else if (result is DataFaild) {
      dataState = DataFaild(result.error!);
    }
    return dataState;
  }
}
