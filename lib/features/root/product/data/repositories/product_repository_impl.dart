import 'dart:convert';

import 'package:nike_flutter/core/local/shared_pref.dart';
import 'package:nike_flutter/core/utils/nike_notifiers.dart';
import 'package:nike_flutter/features/root/product/data/dataSource/product_remote_data_source.dart';
import 'package:nike_flutter/features/root/product/data/model/message_model.dart';
import 'package:nike_flutter/features/root/product/domain/repositories/product_repository.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/utils/strings.dart';
import '../../domain/entities/add_to_cart_entity.dart';
import '../../domain/entities/message_entity.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final NikeSharedPref _sharedPref;

  ProductRepositoryImpl(this._remoteDataSource, this._sharedPref);
  @override
  Future<DataState<MessageEntity>> addToCart(
      {required String productId, required String shoesSize}) async {
    late MessageEntity messageEntity;

    /// read user information
    final userData = await _sharedPref.getUser();
    final userId = userData.userId;

    /// check for login
    if (userId!.isEmpty) {
      return DataFaild(notLogin);
    } else {
      // add product to cart
      try {
        final model = AddToCartEntity(
            userId: userId, productId: productId, shoesSize: shoesSize);
        final response = await _remoteDataSource.addToCart(model);
        if (response.statusCode == 200) {
          messageEntity = MessageModel.fromJson(jsonDecode(response.data));
          NikeNotifiers.cartRefreshNotifier.value = true;
          return DataSuccess(messageEntity);
        } else {
          return DataFaild(serverError);
        }
      } catch (e) {
        return DataFaild(netError);
      }
    }
  }
}
