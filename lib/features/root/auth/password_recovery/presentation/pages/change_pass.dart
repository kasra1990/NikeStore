import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/core/utils/system_ui_controller.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/presentation/bloc/pass_recovery_bloc.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/pages/sign_in_screen.dart';

class ChangePassScreen extends StatefulWidget {
  static const String routeName = "change_password_screen";
  final String email;
  const ChangePassScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController pass = TextEditingController();
  TextEditingController rePass = TextEditingController();
  bool passVisibility = true;
  bool rePassVisibility = true;
  final formKey = GlobalKey<FormState>();

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
    return BlocListener<PassRecoveryBloc, PassRecoveryState>(
      listener: (context, state) {
        debugPrint("listen -> $state");
        if (state is ChangePassResult) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.model.message!)));
          if (state.model.email != null) {
            Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
          }
        }
      },
      child: _createUI(),
    );
  }

  Widget _createUI() => Scaffold(
        body: Center(child: _inputForm()),
      );

  Widget _inputForm() => Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/icons/nike_logo.png", width: getWidth(0.25)),
          SizedBox(height: getHeight(0.03)),
          Text("Change password",
              style: TextStyle(fontSize: getFontSize(0.02))),
          SizedBox(height: getHeight(0.02)),
          Text("Please enter your new password",
              style: TextStyle(fontSize: getFontSize(0.016))),
          SizedBox(height: getHeight(0.02)),
          _myPasswordInput(),
          SizedBox(height: getHeight(0.015)),
          _myRePasswordInput(),
          SizedBox(height: getHeight(0.015)),
          _changePasswordButton()
        ],
      ));

  Widget _myPasswordInput() => SizedBox(
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passVisibility = !passVisibility;
                  });
                },
                icon: passVisibility
                    ? const Icon(Icons.visibility, color: Colors.grey)
                    : const Icon(Icons.visibility_off, color: Colors.grey))),
        validator: (password) {
          if (password!.isEmpty) {
            return "Please enter your password";
          } else {
            return null;
          }
        },
      ));

  Widget _myRePasswordInput() => SizedBox(
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    rePassVisibility = !rePassVisibility;
                  });
                },
                icon: rePassVisibility
                    ? const Icon(Icons.visibility, color: Colors.grey)
                    : const Icon(Icons.visibility_off, color: Colors.grey))),
        validator: (rePassword) {
          if (rePassword!.isEmpty || rePassword != pass.text) {
            return "Re-Password is not correct";
          } else {
            return null;
          }
        },
      ));

  Widget _changePasswordButton() =>
      BlocBuilder<PassRecoveryBloc, PassRecoveryState>(
        builder: (context, state) {
          if (state is PassRecoveryLoading) {
            return SizedBox(
              width: getHeight(0.06),
              height: getHeight(0.06),
              child:
                  const CircularProgressIndicator(color: NikeColor.mainColor),
            );
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
                      context
                          .read<PassRecoveryBloc>()
                          .add(SendNewPass(widget.email, pass.text));
                    }
                  },
                  child: const Text("Change Password")),
            );
          }
        },
      );
}
