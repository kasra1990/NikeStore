import 'package:nike_flutter/features/root/cart/domain/entities/cart_entity.dart';
import 'package:nike_flutter/features/root/cart/domain/repositories/cart_repository.dart';

import '../../../../../core/resources/data_state.dart';

class DeleteProductUseCase {
  final CartRepository _repository;

  DeleteProductUseCase(this._repository);

  Future<DataState> call(
      {required String cartId, required CartsEntity cartsEntity}) async {
    ///creata instanc of dataState
    late DataState dataState;

    /// send request for delete cart
    var result = await _repository.deleteProduct(cartId);

    ///check state of result
    if (result is DataSuccess) {
      /// remove cart from list of carts
      cartsEntity.carts.removeWhere((element) => element.cartId == cartId);
      dataState = DataSuccess(cartsEntity);
    } else if (result is DataFaild) {
      dataState = DataFaild(result.error!);
    }
    return dataState;
  }
}
