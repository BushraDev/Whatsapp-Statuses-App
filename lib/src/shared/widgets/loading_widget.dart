import 'package:flutter/material.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TargetPlatformWidget(
      materialWidget: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
