import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/core/utils/system_ui_controller.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/bloc/register_bloc.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/pages/sign_in_screen.dart';

import '../../domain/entities/user_auth.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "sign_up_screen";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController rePass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final String textMessage = "Please enter email and password";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    systemUIController();
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
        }
        if (state is RegisterError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: _signUpUI(),
    );
  }

  /// signUp UI
  Widget _signUpUI() => Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: _singUpForm()),
                  _signInTextButton(),
                  SizedBox(height: getHeight(0.03))
                ],
              )),
        ),
      );

  ///SignUp Form
  Widget _singUpForm() => Form(
        key: formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/icons/nike_logo.png", width: getWidth(0.25)),
              SizedBox(height: getHeight(0.03)),
              Text("Sing up", style: TextStyle(fontSize: getFontSize(0.02))),
              SizedBox(height: getHeight(0.02)),
              Text(textMessage, style: TextStyle(fontSize: getFontSize(0.016))),
              SizedBox(height: getHeight(0.02)),
              _myEamilInput(),
              SizedBox(height: getHeight(0.015)),
              _myPasswordInput(),
              SizedBox(height: getHeight(0.015)),
              _myRePasswordInput(),
              SizedBox(height: getHeight(0.015)),
              _singUpButton(),
            ]),
      );

  /// Email Text Input
  Widget _myEamilInput() {
    return SizedBox(
        width: getWidth(0.8),
        child: TextFormField(
          controller: email,
          cursorColor: NikeColor.mainColor,
          style: const TextStyle(color: NikeColor.mainColor),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              label: const Text("Email"),
              labelStyle: const TextStyle(color: NikeColor.mainColor),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: NikeColor.mainColor)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          validator: (email) {
            if (email!.isEmpty || !EmailValidator.validate(email)) {
              return "Please enter valid email";
            } else {
              return null;
            }
          },
        ));
  }

  /// Password Text Input
  Widget _myPasswordInput() {
    bool passVisibility = true;
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) {
        if (current is ChangePasswordVisibility) {
          passVisibility = current.visibilityState;
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return SizedBox(
            width: getWidth(0.8),
            child: TextFormField(
              controller: pass,
              cursorColor: NikeColor.mainColor,
              obscureText: passVisibility,
              style: const TextStyle(color: NikeColor.mainColor),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  label: const Text("Password"),
                  labelStyle: const TextStyle(color: NikeColor.mainColor),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: NikeColor.mainColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        debugPrint("singUp -> change visibility pass");
                        context
                            .read<RegisterBloc>()
                            .add(PasswordVisibility(!passVisibility));
                      },
                      icon: passVisibility
                          ? const Icon(Icons.visibility, color: Colors.grey)
                          : const Icon(Icons.visibility_off,
                              color: Colors.grey))),
              validator: (password) {
                if (password!.isEmpty) {
                  return "Please enter your password";
                } else {
                  return null;
                }
              },
            ));
      },
    );
  }

  /// repeat-password text input
  Widget _myRePasswordInput() {
    bool rePassVisibility = true;
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) {
        if (current is ChangeRepeatPasswordVisibility) {
          rePassVisibility = current.visibilityState;
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return SizedBox(
            width: getWidth(0.8),
            child: TextFormField(
              controller: rePass,
              cursorColor: NikeColor.mainColor,
              obscureText: rePassVisibility,
              style: const TextStyle(color: NikeColor.mainColor),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  label: const Text("Re-Password"),
                  labelStyle: const TextStyle(color: NikeColor.mainColor),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: NikeColor.mainColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        debugPrint("singUp -> change visibility re-pass");
                        context
                            .read<RegisterBloc>()
                            .add(RepeatPasswordVisibility(!rePassVisibility));
                      },
                      icon: rePassVisibility
                          ? const Icon(Icons.visibility, color: Colors.grey)
                          : const Icon(Icons.visibility_off,
                              color: Colors.grey))),
              validator: (rePassword) {
                if (rePassword!.isEmpty || rePassword != pass.text) {
                  return "Re-Password is not correct";
                } else {
                  return null;
                }
              },
            ));
      },
    );
  }

  /// singUp button
  Widget _singUpButton() => BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          if (state is RegisterLoading) {
            return const CircularProgressIndicator(color: NikeColor.mainColor);
          } else {
            return SizedBox(
              width: getWidth(0.8),
              height: getHeight(0.06),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (!states.contains(MaterialState.disabled)) {
                          return NikeColor.mainColor;
                        } else {
                          return null;
                        }
                      }),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  onPressed: () {
                    debugPrint("singUp -> signUp button");
                    final isValidForm = formKey.currentState!.validate();
                    if (isValidForm) {
                      context.read<RegisterBloc>().add(SignUp(
                          UserAuth(email: email.text, password: pass.text)));
                    }
                  },
                  child: const Text("Sign Up")),
            );
          }
        },
      );

  ///SingIn Text button
  Widget _signInTextButton() => TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(NikeColor.mainColor),
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
      onPressed: () {
        Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
      },
      child: const Text("Sign in"));
}
