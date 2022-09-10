import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the  height as per screen size
/// inputHeight --> between 0 to 1
double getHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return inputHeight * screenHeight;
}

// Get the with as per screen size
/// inputWidth --> between 0 to 1
double getWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return inputWidth * screenWidth;
}

/// inputHeight --> between 0 to 1
double getFontSize(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return inputHeight * screenHeight;
}
