import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:anavrin/shared/styles/colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      backgroundColor: Appcolors.white,
      fontFamily: "Montserrat",
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Appcolors.black,
        ),
        subtitle1: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ));
}
