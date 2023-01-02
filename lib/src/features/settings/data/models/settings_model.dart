import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class SettingsModel {
  IconData iconData;
  String title;
  Widget trailing;
  Color color;

  SettingsModel({@required this.iconData, @required this.title,@required this.color, this.trailing});
}
