import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:statusesapp/src/shared/theme/light_theme.dart';
import 'features/settings/presentation/providers/theme_provider.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'shared/app/app_info.dart';
import 'shared/layout/responsive.dart' show Responsive;
import 'shared/theme/dark_theme.dart';

class StatusesApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    debugPrint(MediaQuery.of(context).toString());
    Responsive.instance.init(
      mediaQueryData: MediaQuery.of(context),
      width: 375.0,
      height: 812.0,
      allowFontAccesibility: false,
      useSafeArea: false,
    );
    return MaterialApp(
      key: UniqueKey(),
      title: 'حالات واتساب',
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale("ar", ""), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("ar", ""),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      themeMode: watch(themeNotifierProvider).isDarkModeEnabled
          ? ThemeMode.dark
          : ThemeMode.light,
      home: SplashPage(),
    );
  }
}
