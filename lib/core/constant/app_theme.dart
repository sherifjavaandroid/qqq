import 'package:flutter/material.dart';

import 'color.dart';

ThemeData themeEnglish = ThemeData(
  scaffoldBackgroundColor: AppColor.backgroundColor,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Cairo',
      height: 2,
      color: AppColor.grey,
      fontSize: 14,
    ),
  ),
);

ThemeData themeArabic = ThemeData(
  scaffoldBackgroundColor: AppColor.backgroundColor,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Cairo',
      height: 2,
      color: AppColor.grey,
      fontSize: 14,
    ),
  ),
);
