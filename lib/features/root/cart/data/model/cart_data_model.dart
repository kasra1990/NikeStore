import 'package:nike_flutter/features/root/cart/domain/entities/cart_entity.dart';
import '../../../../../core/api/models/product_model.dart';

class CartsDataModel extends CartsEntity {
  CartsDataModel({required List<CartDataModel> carts}) : super(carts: carts);

  factory CartsDataModel.fromJson(List<dynamic> jsonArray) {
    final List<CartDataModel> carts = [];
    for (var json in jsonArray) {
      carts.add(CartDataModel.fromJson(json));
    }
    return CartsDataModel(carts: carts);
  }
}

class CartDataModel extends CartEntity {
  CartDataModel(
      {required ProductModel? product,
      required String? cartId,
      required String? shoesSize,
      required String? count})
      : super(
            product: product,
            cartId: cartId,
            shoesSize: shoesSize,
            count: count);

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
        product: ProductModel.fromJson(json['product']),
        cartId: json['cartId'],
        shoesSize: json['shoesSize'],
        count: json['count']);
  }
}
