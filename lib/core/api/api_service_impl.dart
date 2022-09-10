import 'package:dio/dio.dart';
import 'package:nike_flutter/core/api/api_serivce.dart';
import 'package:nike_flutter/core/utils/constants.dart';

class ApiServiceImpl extends ApiService {
  late Dio _httpClient;
  ApiServiceImpl() {
    _httpClient = Dio(BaseOptions(baseUrl: Constatnts.baseUrl));
  }

  @override
  Future<Response> getHomeData() async => await _httpClient.get('homeData.php');

  @override
  Future<Response> getCategory(String userId, String category) async =>
      await _httpClient.post('getProducts.php',
          data: {"userId": userId, "category": category});

  @override
  Future<Response> changeCount(String cartId, String count) async =>
      await _httpClient.post('changeCountOfCart.php',
          data: {"cartId": cartId, "count": count});

  @override
  Future<Response> deleteProduct(String cartId) async => await _httpClient
      .post('deleteProductFromCart.php', data: {"cartId": cartId});

  @override
  Future<Response> getCarts(String userId) async =>
      await _httpClient.post('getFromCart.php', data: {"userId": userId});

  @override
  Future<Response> addToCart(
          String userId, String productId, String shoesSize) async =>
      await _httpClient.post('addToCart.php', data: {
        "userId": userId,
        "productId": productId,
        "shoesSize": shoesSize
      });

  @override
  Future<Response> signIn(String email, String password) async =>
      await _httpClient
          .post('signIn.php', data: {"email": email, "password": password});

  @override
  Future<Response> signUp(String email, String password) async =>
      await _httpClient
          .post('signUp.php', data: {"email": email, "password": password});

  @override
  Future<Response> sendDigitCode(String email) async =>
      await _httpClient.post('sendDigitCode.php', data: {"email": email});

  @override
  Future<Response> sendOTPVerification(String id, String verifyCode) async =>
      await _httpClient.post('identityDigitCode.php',
          data: {"id": id, "verifyCode": verifyCode});

  @override
  Future<Response> changePassword(String email, String pass) async =>
      await _httpClient
          .post('updatePassword.php', data: {"email": email, "password": pass});
}
