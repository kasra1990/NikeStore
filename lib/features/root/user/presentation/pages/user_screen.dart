import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/di/dependencies.dart';
import 'package:nike_flutter/core/local/shared_pref.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/nike_notifiers.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/pages/sign_in_screen.dart';
import 'package:nike_flutter/features/root/user/presentation/bloc/user_bloc.dart';
import 'package:nike_flutter/features/root/user/presentation/widgets/user_button.dart';

/// user screen page
class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    NikeNotifiers.authRefreshNotifier.addListener(_userLoginChanged);
    _userLoginChanged();
  }

  void _userLoginChanged() {
    context.read<UserBloc>().add(UserLoginEvent());
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("SignIn -> UserScreen -> dispose()");
    NikeNotifiers.authRefreshNotifier.removeListener(_userLoginChanged);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white, body: _userUI(context)),
    );
  }

  /// user screen UI
  Widget _userUI(BuildContext context) {
    List<String> buttonsName = ["Favorite", "Order", "Login", "Logout"];
    List<String> buttonsIcon = [
      "assets/icons/heart_icon.svg",
      "assets/icons/order.svg",
      "assets/icons/login.svg",
      "assets/icons/logout.svg",
    ];
    return Stack(
      children: [
        Positioned(
          top: getHeight(0.05),
          left: 0,
          right: 0,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(getWidth(0.02)),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.black.withOpacity(0.3), width: 1)),
                  child: Image.asset("assets/icons/nike_logo.png",
                      width: getWidth(0.15), height: getWidth(0.15))),
              SizedBox(height: getHeight(0.02)),
              BlocBuilder<UserBloc, UserState>(
                buildWhen: (previous, current) {
                  if (current is UserLoginState) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  debugPrint("UserState -> $state");
                  String userEmail = "";
                  if (state is UserLoginState) {
                    userEmail = state.userEmail;
                  }
                  return Text(userEmail,
                      style: TextStyle(
                          color: NikeColor.mainColor.withOpacity(0.8),
                          fontSize: getFontSize(0.015)));
                },
              ),
              SizedBox(height: getHeight(0.02)),
              UserButton(
                  name: buttonsName[0], icon: buttonsIcon[0], onClick: () {}),
              UserButton(
                  name: buttonsName[1], icon: buttonsIcon[1], onClick: () {}),
              BlocBuilder<UserBloc, UserState>(
                buildWhen: (previous, current) {
                  if (current is UserLoginState) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  bool loginState = false;
                  if (state is UserLoginState) {
                    loginState = state.isLogin;
                  }
                  return UserButton(
                      name: loginState ? buttonsName[3] : buttonsName[2],
                      icon: loginState ? buttonsIcon[3] : buttonsIcon[2],
                      onClick: () {
                        if (loginState) {
                          _showDialog(context);
                        } else {
                          Navigator.of(context)
                              .pushNamed(SignInScreen.routeName);
                        }
                      });
                },
              ),
              Divider(height: 0, color: Colors.grey.withOpacity(0.8)),
            ],
          ),
        ),
        Positioned(
            left: 0, right: 0, bottom: getHeight(0.03), child: _appInfo())
      ],
    );
  }

  /// Alert Dialog
  Future<Widget> _showDialog(BuildContext context) async {
    return await showModal(
        configuration: const FadeScaleTransitionConfiguration(
            transitionDuration: Duration(milliseconds: 500),
            reverseTransitionDuration: Duration(milliseconds: 300)),
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: const Text("Log out"),
              content: const Text("Are you sure?"),
              actions: [
                TextButton(
                    onPressed: () {
                      di<NikeSharedPref>().removeUser();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: NikeColor.mainColor),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ));
  }

  /// show app info in botton of page
  Widget _appInfo() {
    return Column(
      children: [
        Text("Version 1.0.1",
            style: TextStyle(color: Colors.grey, fontSize: getFontSize(0.015))),
        SizedBox(height: getHeight(0.01)),
        Text("Designed & Developed By KY",
            style: TextStyle(color: Colors.grey, fontSize: getFontSize(0.015)))
      ],
    );
  }
}
