import 'dart:async';

import 'package:flutter/material.dart';
import 'package:statusesapp/src/features/home/presentation/pages/home_page.dart';
import 'package:statusesapp/src/features/splash/presentation/widgets/logo_widget.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return TargetPlatformWidget(
      materialWidget: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
            child: Center(
          child: LogoWidget(),
        )),
      ),
    );
  }
}
