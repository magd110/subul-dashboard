import 'dart:ui';

import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color deepPurple = Color(0xFF29206F);
  static const Color goldenYellow = Color(0xFFF0A613);
  static const Color vibrantOrange = Color(0xFFFA4E0A);
  static const Color brightBlue = Color(0xFF05A8F5);
  static const Color richPurple = Color(0xFF8B21CA);
  static const Color softGray = Color(0xFFE0E0E0);
  static const Color extraLightGray = Color(0xFFECECEC);
  static const Color mediumGray = Color(0xFFD9D9D9); 
  static const Color white = Color(0xFFFFFFFF);
  static const Color deepRed = Color(0xFFC40003);
  static const Color deepGreen = Color(0xFF01891E);
  static const Color black = Color(0xFF000000);
  static const Color bluishGray = Color(0xFF5C777E);

  static const BoxDecoration globalBackgroundGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.softGray,
      AppColors.white,
    ],
  ),
);
}
