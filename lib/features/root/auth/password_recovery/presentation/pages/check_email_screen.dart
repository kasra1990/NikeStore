import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/domain/entities/verify_entity.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/presentation/bloc/pass_recovery_bloc.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/presentation/pages/verification_screen.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/pages/sign_in_screen.dart';

class CheckEmailScreen extends StatefulWidget {
  static const String routeName = "check_email_screen";
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String textMessage =
      "Enter your user account's verified email address and we will send you a password.";

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
    return BlocListener<PassRecoveryBloc, PassRecoveryState>(
      listener: (context, state) {
        if (state is EmailValidation) {
          final id = int.parse(state.model.id!);
          if (id > 0) {
            Navigator.of(context).pushNamed(VerificationScreen.routeName,
                arguments: VerifyEntity(state.model.id!, email.text));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.model.message ?? "")));
          }
        }
        if (state is PassRecoveryError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: _createUI(),
    );
  }

  Widget _createUI() => Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: _inputForm()),
                _signInTextButton(),
                SizedBox(
                  height: getHeight(0.03),
                )
              ],
            ),
          ),
        ),
      );

  Widget _inputForm() => Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/icons/nike_logo.png", width: getWidth(0.25)),
            SizedBox(height: getHeight(0.03)),
            SizedBox(
              width: getWidth(0.7),
              child: Text(textMessage,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: getFontSize(0.016),
                  )),
            ),
            SizedBox(height: getHeight(0.02)),
            _myTextInput(),
            SizedBox(height: getHeight(0.03)),
            _sendButton()
          ],
        ),
      );

  Widget _myTextInput() => SizedBox(
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
              return "Please enter a valid email";
            } else {
              return null;
            }
          }));

  Widget _sendButton() => BlocBuilder<PassRecoveryBloc, PassRecoveryState>(
        builder: (context, state) {
          if (state is PassRecoveryLoading) {
            return SizedBox(
              height: getHeight(0.06),
              width: getHeight(0.06),
              child: const Center(
                  child: CircularProgressIndicator(color: NikeColor.mainColor)),
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
                          .add(SendEmailEvent(email.text));
                    }
                  },
                  child: const Text("Send Verification Code")),
            );
          }
        },
      );

  Widget _signInTextButton() => TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(NikeColor.mainColor),
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
      onPressed: () {
        Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
      },
      child: const Text("Sign in"));
}
