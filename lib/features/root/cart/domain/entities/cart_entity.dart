import '../../../../../core/api/models/product_model.dart';

class CartsEntity {
  final List<CartEntity> carts;

  CartsEntity({required this.carts});
}

class CartEntity {
  final ProductModel? product;
  final String? cartId;
  final String? shoesSize;
  String? count;

  CartEntity(
      {required this.product,
      required this.cartId,
      required this.shoesSize,
      required this.count});
}
