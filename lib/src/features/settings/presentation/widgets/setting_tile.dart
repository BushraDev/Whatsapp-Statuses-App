import 'package:flutter/material.dart';
import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';

class SettingTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Widget trailing;
  final Color color;

  SettingTile({this.iconData, this.title, this.trailing, this.color});

  @override
  Widget build(BuildContext context) {
    return TargetPlatformWidget(
      materialWidget: ListTile(
        contentPadding:
            EdgeInsets.symmetric(vertical: 10.hdp, horizontal: 20.hdp),
        leading: Container(
          padding: EdgeInsets.all(10.hdp),
          child: Icon(
            iconData,
            color: Colors.white,
            size: 15.hdp,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: color),
        ),
        title: Text(
          title,
        ),
        trailing: trailing,
      ),
    );
  }
}
