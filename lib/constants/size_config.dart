import 'package:flutter/material.dart';

class SizeConfig {
  static late final MediaQueryData _mediaQueryData;
  static late final  double screenWidth;
  static late final  double screenHeight;
  static late final double defaultSize;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth;
}

double getProportionateScreenHeightAcc(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 683.4) * screenHeight;
}
