import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/di/dependencies.dart';
import 'package:nike_flutter/core/utils/nike_notifiers.dart';
import 'package:nike_flutter/features/router/route_generator.dart';
import 'package:nike_flutter/features/spalsh/presentation/pages/splash_screen.dart';
import 'features/root/cart/presentation/bloc/cart_bloc.dart';
import 'features/root/category/presentation/bloc/category_bloc.dart';
import 'features/root/home/presentation/bloc/home_bloc.dart';

void main() {
  ///Config dependency injection
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: RouteGenerator.generatorRoute,
    );
  }
}
