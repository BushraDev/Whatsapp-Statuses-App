import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';

final appBarNotifierProvider = ChangeNotifierProvider((_) => appBarNotifier());
bool isThemeDark;

class appBarNotifier extends ChangeNotifier {
  String _title = AppMessages.home;
  String get title => _title;
  void changeTitle(String title) {
    _title = title;
    notifyListeners(); // Notify all it's listeners about update. If you comment this line then you will see that new added items will not be reflected in the list.
  }
}
