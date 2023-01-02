import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'src/features/settings/presentation/providers/theme_provider.dart';
import 'src/quotes_app.dart';
import 'src/shared/app/app_info.dart';
import 'src/shared/di/get_it.dart' as di;

void main() async {
  di.init();
  // call ensureInitialized() to make sure that you have an instance of the WidgetsBinding before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await AppInfo.getAppTheme().then((value) => isThemeDark = value);
  // used to prevent application from changing its orientation and force the layout to stick to "portrait".
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => {
            runApp(
              ProviderScope(child: DeviceWrapper()),
            ),
          });
}

class DeviceWrapper extends StatelessWidget {
  const DeviceWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: StatusesApp(),
    );
  }
}
