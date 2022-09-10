import 'package:flutter/material.dart';
import '../utils/nike_color.dart';

//loading
class Loading extends StatelessWidget {
  final Color loadingColor;
  const Loading({Key? key, this.loadingColor = NikeColor.mainColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
          child: CircularProgressIndicator(
        color: loadingColor,
      ));
}
