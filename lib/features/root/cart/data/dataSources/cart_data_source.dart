import 'package:nike_flutter/core/api/api_serivce.dart';

abstract class CartRemoteDataSource {
  Future<dynamic> getCarts(String userId);

  Future<dynamic> changeCount(String cartId, String count);

  Future<dynamic> deleteProduct(String cartId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiService apiService;

  CartRemoteDataSourceImpl(this.apiService);
  @override
  Future<dynamic> changeCount(String cartId, String count) async =>
      await apiService.changeCount(cartId, count);

  @override
  Future<dynamic> deleteProduct(String cartId) async =>
      await apiService.deleteProduct(cartId);

  @override
  Future<dynamic> getCarts(String userId) async =>
      await apiService.getCarts(userId);
}
