import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:statusesapp/src/shared/app/app_info.dart';

final themeNotifierProvider = ChangeNotifierProvider((ref) => ThemeNotifier());
bool isThemeDark = false;

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkModeEnabled = isThemeDark;
  bool get isDarkModeEnabled => _isDarkModeEnabled;
  void changeDarkMode(isDarkModeEnabled) {
    AppInfo.updateAppTheme(isDarkModeEnabled);
    _isDarkModeEnabled = isDarkModeEnabled;
    notifyListeners(); // Notify all it's listeners about update. If you comment this line then you will see that new added items will not be reflected in the list.
  }
}
