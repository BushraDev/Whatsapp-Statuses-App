import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';

class CustomChip extends StatelessWidget {
  final String label;

  CustomChip({@required this.label});

  @override
  Widget build(BuildContext context) {
    return TargetPlatformWidget(
      materialWidget: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.hdp, vertical: 5.hdp),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(100)),
        child: Text(
          label,
          style: Theme.of(context).textTheme.headline3.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
