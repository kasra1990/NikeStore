import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/network/network_info.dart';
import 'package:nike_flutter/core/utils/strings.dart';
import 'package:nike_flutter/features/root/product/data/model/message_model.dart';
import 'package:nike_flutter/features/root/product/domain/usCases/add_to_cart_usecase.dart';

import '../../../../../core/resources/data_state.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddToCartUseCase _addToCartUseCase;
  final NetworkInfo _networkInfo;
  String _shoesSize = "40";
  ProductBloc(this._addToCartUseCase, this._networkInfo)
      : super(ProductInitial()) {
    on<ProductAddToCart>(_addToCart);
    on<ProductSetShoesSize>(_changeShoesSize);
  }

  // add to cart
  void _addToCart(ProductAddToCart event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    var netState = await _networkInfo.isConnected;
    if (netState) {
      DataState dataState = await _addToCartUseCase.call(
          productId: event.productId, shoesSize: _shoesSize);
      if (dataState is DataSuccess) {
        emit(ProductAddedSuccess(dataState.data));
      }
      if (dataState is DataFaild) {
        if (dataState.error == notLogin) {
          emit(ProductUserNotLogin());
        } else {
          emit(ProductError(error: dataState.error!));
        }
      }
    } else {
      emit(const ProductError(error: noConnection));
    }
  }

  void _changeShoesSize(ProductSetShoesSize event, Emitter<ProductState> emit) {
    _shoesSize = event.shoesSize;
    emit(ProductChangShoesSize(_shoesSize));
  }
}
