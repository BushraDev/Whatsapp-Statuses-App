import 'package:fluttertoast/fluttertoast.dart';
import 'package:statusesapp/src/shared/layout/responsive.dart';

showShortToast(String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0.hdp);
}
