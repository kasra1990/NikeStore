abstract class ApiService {
  /// get data for home screen
  Future<dynamic> getHomeData();

  /// get data for category screen
  Future<dynamic> getCategory(String userId, String category);

  /// get carts of user
  Future<dynamic> getCarts(String userId);

  /// change count of product from shopping cart
  Future<dynamic> changeCount(String cartId, String count);

  /// delete product from cart
  Future<dynamic> deleteProduct(String cartId);

  /// add to cart by user
  Future<dynamic> addToCart(String userId, String productId, String shoesSize);

  /// signIn
  Future<dynamic> signIn(String email, String password);

  /// singUp
  Future<dynamic> signUp(String email, String password);

  /// send digit code to email address
  Future<dynamic> sendDigitCode(String email);

  /// get OTP verification code form user
  Future<dynamic> sendOTPVerification(String id, String verifyCode);

  ///change password
  Future<dynamic> changePassword(String email, String pass);
}
