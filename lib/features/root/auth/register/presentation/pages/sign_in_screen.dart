import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/core/utils/system_ui_controller.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/presentation/pages/check_email_screen.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/bloc/register_bloc.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/pages/sign_up_screen.dart';
import '../../domain/entities/user_auth.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "sign_in_screen";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final String textMessage = "Please enter email and password";
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  void initState() {
    debugPrint("SignIn -> SignInScreen -> initState()");

    systemUIController();
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("SignIn -> SignInScreen -> dispose()");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          debugPrint("SignIn -> SignInScreen state-> $state");
          if (state is SignInSuccess) {
            Navigator.of(context).pop();
          }
          if (state is RegisterError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: _signInUI(),
      );

  /// signIn UI
  Widget _signInUI() {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Expanded(child: _signInForm()), _textButtons()],
        ),
      ),
    ));
  }

  /// Sign in form
  Widget _signInForm() => Form(
        key: formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/icons/nike_logo.png", width: getWidth(0.25)),
              SizedBox(height: getHeight(0.03)),
              Text("Sing in", style: TextStyle(fontSize: getFontSize(0.02))),
              SizedBox(height: getHeight(0.02)),
              Text(textMessage, style: TextStyle(fontSize: getFontSize(0.016))),
              SizedBox(height: getHeight(0.02)),
              _emailTextInput(),
              SizedBox(height: getHeight(0.015)),
              _passwordTextInput(),
              SizedBox(height: getHeight(0.025)),
              _loginButton()
            ]),
      );

  /// Email Text Input
  Widget _emailTextInput() => SizedBox(
      width: getWidth(0.8),
      child: TextFormField(
          controller: _email,
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
              return "Please enter a valid email";
            } else {
              return null;
            }
          }));

  ///Password Text input
  Widget _passwordTextInput() {
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
              controller: _pass,
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
                        context
                            .read<RegisterBloc>()
                            .add(PasswordVisibility(!passVisibility));
                      },
                      icon: passVisibility
                          ? const Icon(Icons.visibility, color: Colors.grey)
                          : const Icon(Icons.visibility_off,
                              color: Colors.grey))),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password";
                } else {
                  return null;
                }
              },
            ));
      },
    );
  }

  ///login button
  Widget _loginButton() => BlocBuilder<RegisterBloc, RegisterState>(
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
                    final isValidForm = formKey.currentState!.validate();
                    if (isValidForm) {
                      debugPrint("SignIn -> SignInScreen -> Button clicked");
                      context.read<RegisterBloc>().add(SignIn(
                          UserAuth(email: _email.text, password: _pass.text)));
                    }
                  },
                  child: const Text("Login")),
            );
          }
        },
      );

  /// Text Button
  Widget _textButtons() => Column(
        children: [
          TextButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(NikeColor.mainColor),
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              onPressed: () {
                Navigator.of(context)
                    .popAndPushNamed(CheckEmailScreen.routeName);
              },
              child: const Text("Forgot Password?")),
          TextButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(NikeColor.mainColor),
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(SignUpScreen.routeName);
              },
              child: const Text("Sign Up")),
          SizedBox(height: getHeight(0.03))
        ],
      );
}
