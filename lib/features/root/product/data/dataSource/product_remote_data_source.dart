import 'package:dio/dio.dart';
import 'package:nike_flutter/core/api/api_serivce.dart';
import 'package:nike_flutter/features/root/product/domain/entities/add_to_cart_entity.dart';

abstract class ProductRemoteDataSource {
  ///get user cart
  Future<Response> addToCart(AddToCartEntity model);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiService apiService;

  ProductRemoteDataSourceImpl(this.apiService);

  @override
  Future<Response> addToCart(AddToCartEntity model) async => await apiService
      .addToCart(model.userId, model.productId, model.shoesSize);
}
