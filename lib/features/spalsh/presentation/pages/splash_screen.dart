import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/features/root/root.dart';

/// Show Splash Screen
class SplashScreen extends StatelessWidget {
  static const String routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _goToRoot(context: context);
    return Scaffold(
        body: Center(
            child: Image.asset("assets/icons/nike_logo.png",
                width: getWidth(0.24))));
  }

  /// goint to rootScreen afater 3 second
  _goToRoot({required BuildContext context}) {
    Timer.periodic(const Duration(seconds: 3), ((timer) {
      Navigator.of(context).popAndPushNamed(RootScreen.routeName);
    }));
  }
}
