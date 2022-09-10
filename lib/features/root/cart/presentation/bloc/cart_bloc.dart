import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/utils/nike_notifiers.dart';
import 'package:nike_flutter/core/utils/strings.dart';
import 'package:nike_flutter/features/root/cart/domain/entities/cart_entity.dart';
import 'package:nike_flutter/features/root/cart/domain/useCases/decrease_count_usecase.dart';
import 'package:nike_flutter/features/root/cart/domain/useCases/get_carts_usecase.dart';
import 'package:nike_flutter/features/root/cart/domain/useCases/increase_count_usecase.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../../core/resources/data_state.dart';
import '../../domain/useCases/delete_product_usecase.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartsUseCase _getCartsUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final IncreaseCountUseCase _increaseCountUseCase;
  final DecreaseCountUseCase _decreaseCountUseCase;
  final NetworkInfo _networkInfo;
  late CartsEntity _cartsEntity;
  CartBloc(this._getCartsUseCase, this._networkInfo, this._deleteProductUseCase,
      this._increaseCountUseCase, this._decreaseCountUseCase)
      : super(CartLoading()) {
    on<CartStarted>(_start);
    on<CartDecreaseCount>(_decreaseCount);
    on<CartIncreaseCount>(_increaseCount);
    on<CartDeleteProducts>(_deleteProducts);
  }

  ///get user cart
  void _start(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());

    /// get state of network connection
    var netState = await _networkInfo.isConnected;

    /// check state of network connection
    if (netState) {
      /// check login state
      if (NikeNotifiers.authRefreshNotifier.value) {
        ///get carts
        DataState dataState = await _getCartsUseCase.call();

        /// if get carts successfully
        if (dataState is DataSuccess) {
          _cartsEntity = dataState.data;
          if (_cartsEntity.carts.isNotEmpty) {
            emit(CartSuccess(
                dataState.data, _totalPayment(carts: dataState.data.carts)));
          } else {
            emit(CartEmpty());
          }
        }
        // if get carts faild
        if (dataState is DataFaild) {
          emit(const CartError(error: netError));
        }
      } else {
        /// user not login
        emit(CartNotAuthentication());
      }
    } else {
      /// network connection has problem
      emit(const CartError(error: noConnection));
    }
  }

  /// decrease coutn of product
  void _decreaseCount(CartDecreaseCount event, Emitter<CartState> emit) async {
    debugPrint("_decreaseCount");
    var netState = await _networkInfo.isConnected;
    if (netState) {
      final DataState dataState = await _decreaseCountUseCase.call(
          cartEntity: event.cart, cartsEntity: _cartsEntity);
      if (dataState is DataSuccess) {
        _cartsEntity = dataState.data;
        emit(CartSuccess(
            _cartsEntity, _totalPayment(carts: dataState.data.carts)));
      }
      if (dataState is DataFaild) {
        emit(CartMessage(message: dataState.error!));
      }
    } else {
      emit(const CartMessage(message: noConnection));
    }
  }

  /// increase coutn of product
  void _increaseCount(CartIncreaseCount event, Emitter<CartState> emit) async {
    var netState = await _networkInfo.isConnected;
    if (netState) {
      final DataState dataState = await _increaseCountUseCase.call(
          cartEntity: event.cart, cartsEntity: _cartsEntity);
      if (dataState is DataSuccess) {
        _cartsEntity = dataState.data;
        emit(CartSuccess(
            _cartsEntity, _totalPayment(carts: dataState.data.carts)));
      }
      if (dataState is DataFaild) {
        emit(CartMessage(message: dataState.error!));
      }
    } else {
      emit(const CartMessage(message: noConnection));
    }
  }

  ///delete product
  void _deleteProducts(
      CartDeleteProducts event, Emitter<CartState> emit) async {
    var netState = await _networkInfo.isConnected;
    if (netState) {
      DataState dataState = await _deleteProductUseCase.call(
          cartId: event.cartId, cartsEntity: _cartsEntity);
      if (dataState is DataSuccess) {
        _cartsEntity = dataState.data;
        if (_cartsEntity.carts.isNotEmpty) {
          emit(CartSuccess(
              _cartsEntity, _totalPayment(carts: _cartsEntity.carts)));
        } else {
          emit(CartEmpty());
        }
        emit(const CartMessage(message: "Your item was deleted"));
      } else if (dataState is DataFaild) {
        emit(CartMessage(message: dataState.error!));
      }
    } else {
      emit(const CartMessage(message: noConnection));
    }
  }

  /// calculate total payment
  String _totalPayment({required List<CartEntity> carts}) {
    double total = 0;
    for (var element in carts) {
      total +=
          double.parse(element.product!.price!) * double.parse(element.count!);
    }
    return total.toString();
  }
}
