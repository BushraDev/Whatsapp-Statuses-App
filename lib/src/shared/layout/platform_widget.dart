import 'dart:io';

import 'package:flutter/material.dart';

class TargetPlatformWidget extends StatelessWidget {
  final Widget cupertinoWidget;
  final Widget materialWidget;
  const TargetPlatformWidget(
      {Key key, @required this.materialWidget, this.cupertinoWidget})
      : assert(materialWidget != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS && cupertinoWidget != null
        ? cupertinoWidget
        : materialWidget;
  }
}
