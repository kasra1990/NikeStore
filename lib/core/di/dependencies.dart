import 'package:get_it/get_it.dart';
import 'package:nike_flutter/core/api/api_serivce.dart';
import 'package:nike_flutter/core/api/api_service_impl.dart';
import 'package:nike_flutter/core/local/shared_pref.dart';
import 'package:nike_flutter/core/network/network_info.dart';
import 'package:nike_flutter/core/network/network_info_impl.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/data/dataSources/pass_recovery_remote_data_source.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/data/repositories/pass_recovery_repository_impl.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/domain/repositories/pass_recovery_repository.dart';
import 'package:nike_flutter/features/root/auth/register/domain/useCases/sign_in_usecase.dart';
import 'package:nike_flutter/features/root/auth/register/domain/useCases/sign_up_usecase.dart';
import 'package:nike_flutter/features/root/cart/data/dataSources/cart_data_source.dart';
import 'package:nike_flutter/features/root/cart/data/repositories/cart_repository_impl.dart';
import 'package:nike_flutter/features/root/cart/domain/repositories/cart_repository.dart';
import 'package:nike_flutter/features/root/cart/domain/useCases/decrease_count_usecase.dart';
import 'package:nike_flutter/features/root/cart/domain/useCases/delete_product_usecase.dart';
import 'package:nike_flutter/features/root/cart/domain/useCases/get_carts_usecase.dart';
import 'package:nike_flutter/features/root/cart/domain/useCases/increase_count_usecase.dart';
import 'package:nike_flutter/features/root/category/data/dataSources/category_remote_data_source.dart';
import 'package:nike_flutter/features/root/category/data/repositories/category_repository_impl.dart';
import 'package:nike_flutter/features/root/category/domain/repositories/category_repository.dart';
import 'package:nike_flutter/features/root/category/domain/useCases/get_category_data_usecase.dart';
import 'package:nike_flutter/features/root/category/presentation/bloc/category_bloc.dart';
import 'package:nike_flutter/features/root/home/data/data_sources/home_remote_data_source.dart';
import 'package:nike_flutter/features/root/home/data/repositories/home_repository_impl.dart';
import 'package:nike_flutter/features/root/home/domain/repositories/home_repository.dart';
import 'package:nike_flutter/features/root/home/domain/use_cases/get_home_data_usecase.dart';
import 'package:nike_flutter/features/root/product/data/dataSource/product_remote_data_source.dart';
import 'package:nike_flutter/features/root/product/domain/repositories/product_repository.dart';
import 'package:nike_flutter/features/root/product/domain/usCases/add_to_cart_usecase.dart';
import 'package:nike_flutter/features/root/user/presentation/bloc/user_bloc.dart';

import '../../features/root/auth/password_recovery/domain/useCases/change_pass_usecase.dart';
import '../../features/root/auth/password_recovery/domain/useCases/send_digit_code_usecase.dart';
import '../../features/root/auth/password_recovery/domain/useCases/send_otp_code_usecase.dart';
import '../../features/root/auth/password_recovery/presentation/bloc/pass_recovery_bloc.dart';
import '../../features/root/auth/register/data/dataSources/register_remote_data_source.dart';
import '../../features/root/auth/register/data/repositories/register_repository_impl.dart';
import '../../features/root/auth/register/domain/repositories/register_repository.dart';
import '../../features/root/auth/register/presentation/bloc/register_bloc.dart';
import '../../features/root/cart/presentation/bloc/cart_bloc.dart';
import '../../features/root/category/domain/useCases/searh_in_category_usecese.dart';
import '../../features/root/home/presentation/bloc/home_bloc.dart';
import '../../features/root/product/data/repositories/product_repository_impl.dart';
import '../../features/root/product/presentation/bloc/product_bloc.dart';

final GetIt di = GetIt.instance;

void configureDependencies() {
  // Core features
  di.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  di.registerLazySingleton<NikeSharedPref>(() => NikeSharedPrefImpl());
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  /// auth features
  di.registerLazySingleton<PassRecoveryRemoteDataSource>(
      () => PassRecoveryRemoteDataSourceImpl(di()));
  di.registerLazySingleton<PassRecoveryRepository>(
      () => PassRecoveryRepositoryImpl(di()));
  di.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(di()));
  di.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(di(), di()));
  di.registerLazySingleton<SignInUseCase>(() => SignInUseCase(di()));
  di.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(di()));

  di.registerLazySingleton<SendDigitCodeUseCase>(
      () => SendDigitCodeUseCase(di()));
  di.registerLazySingleton<SendOtpCodeCodeUseCase>(
      () => SendOtpCodeCodeUseCase(di()));
  di.registerLazySingleton<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(di()));

  di.registerFactory<RegisterBloc>(() => RegisterBloc(di(), di(), di()));
  di.registerFactory<PassRecoveryBloc>(
      () => PassRecoveryBloc(di(), di(), di(), di()));

  /// cart feature
  di.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(di()));
  di.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(di(), di()));
  di.registerLazySingleton<GetCartsUseCase>(() => GetCartsUseCase(di()));
  di.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(di()));
  di.registerLazySingleton<IncreaseCountUseCase>(
      () => IncreaseCountUseCase(di()));
  di.registerLazySingleton<DecreaseCountUseCase>(
      () => DecreaseCountUseCase(di()));
  di.registerFactory<CartBloc>(() => CartBloc(di(), di(), di(), di(), di()));

  /// category feature
  di.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(di()));
  di.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(di(), di()));
  di.registerLazySingleton<GetCategoryDataUseCase>(
      () => GetCategoryDataUseCase(di()));
  di.registerLazySingleton<SearchInCategoryUseCase>(
      () => SearchInCategoryUseCase(di()));
  di.registerFactory<CategoryBloc>(() => CategoryBloc(di(), di(), di()));

  /// home feature
  di.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeDataRemoteDataSourceImpl(di()));
  di.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(di()));
  di.registerLazySingleton<GetHomeDataUseCase>(() => GetHomeDataUseCase(di()));
  di.registerFactory<HomeBloc>(() => HomeBloc(di(), di()));

  /// product feature
  di.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(di()));
  di.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(di(), di()));
  di.registerLazySingleton<AddToCartUseCase>(() => AddToCartUseCase(di()));
  di.registerFactory<ProductBloc>(() => ProductBloc(di(), di()));

  /// user features
  di.registerFactory<UserBloc>(() => UserBloc(di()));
}
