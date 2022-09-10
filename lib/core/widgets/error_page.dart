import 'package:flutter/material.dart';
import 'package:nike_flutter/core/utils/nike_notifiers.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/core/utils/strings.dart';

import '../utils/nike_color.dart';

/// Error page screen
class ErrorPage extends StatelessWidget {
  final String error;
  const ErrorPage({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error, textAlign: TextAlign.center),
          SizedBox(height: getHeight(0.01)),
          OutlinedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(getWidth(0.4), getHeight(0.045))),
                  overlayColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0.3)),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor:
                      MaterialStateProperty.all(NikeColor.mainColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)))),
              onPressed: () async {
                NikeNotifiers.checkConnection();
              },
              child: const Text(tryAgain))
        ],
      ));
}
