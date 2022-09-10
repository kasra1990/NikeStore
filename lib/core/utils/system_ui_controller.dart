import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///we can use this function for change system ui color
void systemUIController(
    {Color statusBarColor = Colors.white,
    Brightness statusBarIconBrightness = Brightness.dark,
    Color systemNavigationBarColor = Colors.white,
    Brightness systemNavigationBarIconBrightness = Brightness.dark}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarColor: systemNavigationBarColor,
      systemNavigationBarIconBrightness: systemNavigationBarIconBrightness));
}
