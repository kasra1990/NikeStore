import 'package:nike_flutter/features/root/product/domain/repositories/product_repository.dart';

import '../../../../../core/resources/data_state.dart';
import '../entities/message_entity.dart';

class AddToCartUseCase {
  final ProductRepository repository;

  AddToCartUseCase(this.repository);

  Future<DataState<MessageEntity>> call(
          {required String productId, required String shoesSize}) =>
      repository.addToCart(productId: productId, shoesSize: shoesSize);
}
