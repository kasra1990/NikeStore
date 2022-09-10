import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/api/entities/product_entity.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/domain/entities/verify_entity.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/presentation/pages/change_pass.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/presentation/pages/check_email_screen.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/pages/sign_in_screen.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/pages/sign_up_screen.dart';
import 'package:nike_flutter/features/root/product/presentation/pages/product_screen.dart';
import 'package:nike_flutter/features/root/root.dart';
import 'package:nike_flutter/features/spalsh/presentation/pages/splash_screen.dart';
import '../../core/di/dependencies.dart';
import '../root/auth/password_recovery/presentation/bloc/pass_recovery_bloc.dart';
import '../root/auth/password_recovery/presentation/pages/verification_screen.dart';
import '../root/auth/register/presentation/bloc/register_bloc.dart';
import '../root/product/presentation/bloc/product_bloc.dart';

class RouteGenerator {
  static Route? generatorRoute(RouteSettings settings) {
    final args = settings.arguments;
    final routeName = settings.name;
    switch (routeName) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RootScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RootScreen());
      case ProductScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => di<ProductBloc>(),
                  child: ProductScreen(product: args as ProductEntity),
                ));
      case SignInScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => di<RegisterBloc>(),
                  child: const SignInScreen(),
                ));
      case SignUpScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => di<RegisterBloc>(),
                  child: const SignUpScreen(),
                ));
      case ChangePassScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => di<PassRecoveryBloc>(),
                  child: ChangePassScreen(email: args as String),
                ));
      case CheckEmailScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => di<PassRecoveryBloc>(),
                  child: const CheckEmailScreen(),
                ));
      case VerificationScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => di<PassRecoveryBloc>(),
                  child: VerificationScreen(verifyEntity: args as VerifyEntity),
                ));
      default:
        return null;
    }
  }
}
