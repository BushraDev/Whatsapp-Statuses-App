import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';

class RoundedIcon extends StatelessWidget {
  final Function onTap;
  final IconData iconData;
  final Color color;

  RoundedIcon({@required this.onTap, @required this.iconData, this.color});

  @override
  Widget build(BuildContext context) {
    return TargetPlatformWidget(
      materialWidget: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: EdgeInsets.all(10.hdp),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).splashColor,
                    offset: Offset(0, 1.hdp),
                    blurRadius: 6.0.hdp,
                    spreadRadius: 3.0.hdp),
              ]),
          child: Icon(
            iconData,
            color: color,
          ),
        ),
      ),
    );
  }
}
