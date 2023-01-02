import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({@required this.title});

  @override
  Widget build(BuildContext context) {
    return TargetPlatformWidget(
      materialWidget: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: Theme.of(context).unselectedWidgetColor),
        title: Text(title,
            style: Theme.of(context).textTheme.headline4.copyWith(
                  color: Theme.of(context).textTheme.headline6.color,
                )),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.hdp);
}
