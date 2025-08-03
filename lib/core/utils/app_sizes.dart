import 'package:flutter/material.dart';

class AppSizes {
  static double widthRatio(BuildContext context, double figmaWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (figmaWidth / 1400); // حساب النسبة بناءً على عرض التصميم الأصلي
  }

  static double heightRatio(BuildContext context, double figmaHeight) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * (figmaHeight / 1020); // حساب النسبة بناءً على الطول الأصلي (إذا كان لديك مرجع للطول)
  }
}