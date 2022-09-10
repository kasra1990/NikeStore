import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/network/network_info.dart';
import 'package:nike_flutter/core/network/network_info_impl.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/domain/entities/verify_entity.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/presentation/bloc/pass_recovery_bloc.dart';
import 'package:nike_flutter/features/root/auth/password_recovery/presentation/pages/change_pass.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = "verification_screen";
  final VerifyEntity verifyEntity;
  const VerificationScreen({Key? key, required this.verifyEntity})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  PassRecoveryBloc? bloc;
  late NetworkInfo networkInfo;
  String textMessage = "Enter your OTP code number";
  List<String> digitCode = [];

  @override
  void initState() {
    networkInfo = NetworkInfoImpl();
    super.initState();
  }

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PassRecoveryBloc, PassRecoveryState>(
      listener: (context, state) {
        debugPrint("listen -> state -> $state");
        if (state is EmailValidation) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.model.message ?? "")));
          if (state.model.email != null) {
            Navigator.of(context).popAndPushNamed(ChangePassScreen.routeName,
                arguments: state.model.email!);
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

  Widget _createUI() => SafeArea(
          child: Scaffold(
              body: Center(
                  child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/nike_logo.png", width: getWidth(0.25)),
          SizedBox(height: getHeight(0.03)),
          Text("Verification",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getFontSize(0.016),
              )),
          SizedBox(height: getHeight(0.02)),
          Text(textMessage,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: getFontSize(0.016),
              )),
          SizedBox(height: getHeight(0.02)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(0.15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textFieldOTP(),
                _textFieldOTP(),
                _textFieldOTP(),
                _textFieldOTP(last: true)
              ],
            ),
          ),
          SizedBox(height: getHeight(0.01)),
          _checkVerifyCodeButton(),
          SizedBox(height: getHeight(0.05)),
          _resendOTPTextButton()
        ],
      ))));

  Widget _textFieldOTP({bool last = false}) {
    return SizedBox(
      height: getHeight(0.08),
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextFormField(
          autofocus: true,
          showCursor: false,
          maxLines: 1,
          maxLength: 1,
          obscureText: false,
          style: TextStyle(fontSize: getFontSize(0.03)),
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: NikeColor.mainColor),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: NikeColor.mainColor),
                borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) {
            if (value.length == 1 && digitCode.length < 4) {
              digitCode.add(value);
              if (!last) {
                FocusScope.of(context).nextFocus();
              }
            }
            if (value.isEmpty && digitCode.isNotEmpty) {
              digitCode.removeLast();
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }

  Widget _checkVerifyCodeButton() =>
      BlocBuilder<PassRecoveryBloc, PassRecoveryState>(
        builder: (context, state) {
          if (state is PassRecoveryLoading) {
            return SizedBox(
              height: getHeight(0.06),
              width: getHeight(0.06),
              child:
                  const CircularProgressIndicator(color: NikeColor.mainColor),
            );
          } else {
            return SizedBox(
              height: getHeight(0.06),
              width: getWidth(0.8),
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
                    if (digitCode.length == 4) {
                      var verifyCode = "";
                      for (var element in digitCode) {
                        verifyCode += element;
                      }
                      debugPrint("DigitCode: $verifyCode");
                      context.read<PassRecoveryBloc>().add(
                          SendVerification(widget.verifyEntity.id, verifyCode));
                    }
                  },
                  child: const Text("Check Verify Code")),
            );
          }
        },
      );

  Widget _resendOTPTextButton() => TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(NikeColor.mainColor),
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
      onPressed: () {
        context
            .read<PassRecoveryBloc>()
            .add(SendEmailEvent(widget.verifyEntity.email));
      },
      child: const Text("Resend OTP code"));
}
