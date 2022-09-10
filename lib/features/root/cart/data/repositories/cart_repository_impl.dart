import 'dart:convert';

import 'package:nike_flutter/core/local/shared_pref.dart';
import 'package:nike_flutter/features/root/cart/data/dataSources/cart_data_source.dart';
import 'package:nike_flutter/features/root/cart/data/model/cart_data_model.dart';
import 'package:nike_flutter/features/root/cart/domain/entities/cart_entity.dart';
import 'package:nike_flutter/features/root/cart/domain/repositories/cart_repository.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/utils/strings.dart';

class CartRepositoryImpl extends CartRepository {
  final CartRemoteDataSource dataSource;
  final NikeSharedPref _sharedPref;
  CartRepositoryImpl(this.dataSource, this._sharedPref);

  /// change count of product
  @override
  Future<DataState> changeCount(String cartId, String count) async {
    try {
      final response = await await dataSource.changeCount(cartId, count);
      if (response.statusCode == 200) {
        return DataSuccess("item count changed");
      } else {
        return DataFaild(serverError);
      }
    } catch (e) {
      return DataFaild(netError);
    }
  }

  /// delete product
  @override
  Future<DataState> deleteProduct(String cartId) async {
    try {
      final response = await dataSource.deleteProduct(cartId);
      if (response.statusCode == 200) {
        return DataSuccess("item deleted successfully");
      } else {
        return DataFaild(serverError);
      }
    } catch (e) {
      return DataFaild(netError);
    }
  }

  /// get carts
  @override
  Future<DataState<CartsEntity>> getCarts() async {
    final user = await _sharedPref.getUser();
    try {
      final response = await dataSource.getCarts(user.userId!);
      if (response.statusCode == 200) {
        CartsEntity carts = CartsDataModel.fromJson(jsonDecode(response.data));
        return DataSuccess(carts);
      } else {
        return DataFaild(serverError);
      }
    } catch (e) {
      return DataFaild(netError);
    }
  }
}
