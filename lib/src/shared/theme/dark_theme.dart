import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:statusesapp/src/shared/layout/responsive.dart';

ThemeData appDarkTheme = ThemeData(
  primarySwatch: appCustomColor,
  primaryColor: primaryColor,
  accentColor: accentColor,
  toggleableActiveColor: accentColor,
  bottomAppBarColor: ThemeData.dark().bottomAppBarColor,
  unselectedWidgetColor: ThemeData.dark().unselectedWidgetColor,
  scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
  cardColor: ThemeData.dark().cardColor,
  dividerColor: ThemeData.dark().dividerColor,
  shadowColor: ThemeData.dark().shadowColor,
  canvasColor: ThemeData.dark().canvasColor,
  fontFamily: 'Neo_Sans',
  textTheme: ThemeData.dark().textTheme.copyWith(
      headline1: TextStyle(
        fontSize: 30.sp,
      ),
      headline2: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
      headline3: TextStyle(fontSize: 20.sp),
      headline4: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17.sp,
      ),
      headline5: TextStyle(fontSize: 12.sp),
      headline6: ThemeData.dark().textTheme.headline6),
  dialogTheme: ThemeData.dark().dialogTheme,
  dialogBackgroundColor: ThemeData.dark().dialogBackgroundColor,
  iconTheme: IconThemeData(
    color: ThemeData.dark().unselectedWidgetColor,
  ),
);
