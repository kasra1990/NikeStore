import 'package:nike_flutter/features/root/product/domain/entities/message_entity.dart';

import '../../../../../core/resources/data_state.dart';

abstract class ProductRepository {
  // get user cart
  Future<DataState<MessageEntity>> addToCart(
      {required String productId, required String shoesSize});
}
