import 'package:hive/hive.dart';

class AppInfo {
  static const String _appInfoBoxName = "AppInfo";

  static Future<bool> isCategoriesTableFirstInit() async {
    var box = await Hive.openBox(_appInfoBoxName);
    print(
        "isCategoriesTableFirstInit ${box.get('isCategoriesTableFirstInit', defaultValue: true)}");
    return box.get('isCategoriesTableFirstInit', defaultValue: true);
  }

  static updateCategoriesTableInitState() async {
    var box = await Hive.openBox(_appInfoBoxName);
    await box.put('isCategoriesTableFirstInit', false);
  }

  static Future<bool> isQuotesTableFirstInit() async {
    var box = await Hive.openBox(_appInfoBoxName);
    print(
        "isQuotesTableFirstInit ${box.get('isQuotesTableFirstInit', defaultValue: true)}");
    return box.get('isQuotesTableFirstInit', defaultValue: true);
  }

  static updateQuotesTableInitState() async {
    var box = await Hive.openBox(_appInfoBoxName);
    await box.put('isQuotesTableFirstInit', false);
  }

  static Future<bool> getAppTheme() async {
    var box = await Hive.openBox(_appInfoBoxName);
    print("is mode dark ${box.get('isDarkMode', defaultValue: false)}");
    return box.get('isDarkMode', defaultValue: false);
  }

  static updateAppTheme(bool isDarkTheme) async {
    var box = await Hive.openBox(_appInfoBoxName);
    await box.put('isDarkMode', isDarkTheme);
  }
}
