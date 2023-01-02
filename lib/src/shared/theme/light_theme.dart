import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:statusesapp/src/shared/layout/responsive.dart';

ThemeData appLightTheme = ThemeData(
    primarySwatch: appCustomColor,
    primaryColor: primaryColor,
    bottomAppBarColor: Colors.white,
    accentColor: accentColor,
    unselectedWidgetColor: unselectedWidgetColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    cardColor: cardColor,
    dividerColor: dividerColor,
    splashColor: splashColor,
    buttonColor: accentColor,
    elevatedButtonTheme: ThemeData.light().elevatedButtonTheme,
    canvasColor: cardShadowColor,
    fontFamily: 'Neo_Sans',
    iconTheme: IconThemeData(color: iconColor),
    textTheme: TextTheme(
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
        headline6: ThemeData.light().textTheme.headline6));
