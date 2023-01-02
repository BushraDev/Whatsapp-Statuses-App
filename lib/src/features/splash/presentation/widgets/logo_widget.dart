import 'package:flutter/material.dart';
import 'package:statusesapp/src/shared/assets/images.dart';

import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TargetPlatformWidget(
      materialWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Images.logo,
            height: 100.hdp,
            width: 170.hdp,
          ),
          SizedBox(
            height: 15.hdp,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppMessages.statusesAr,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Theme.of(context).accentColor,
                      )),
              Text(AppMessages.whatsApp,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Theme.of(context).primaryColor,
                      )),
            ],
          ),
          SizedBox(
            height: 10.hdp,
          ),
          Text(
            AppMessages.splashScreenText,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Theme.of(context).dividerColor,
                ),
          )
        ],
      ),
    );
  }
}
