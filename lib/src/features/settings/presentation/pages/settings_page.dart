import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:statusesapp/src/features/settings/data/models/settings_model.dart';
import 'package:statusesapp/src/features/settings/presentation/providers/theme_provider.dart';
import 'package:statusesapp/src/features/settings/presentation/widgets/setting_tile.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';
import 'package:statusesapp/src/shared/widgets/custom_app_bar.dart';
import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.read(themeNotifierProvider);
    List<SettingsModel> getAllSettings() {
      return [
        SettingsModel(
          iconData: FontAwesomeIcons.starAndCrescent,
          title: AppMessages.allowDarkMode,
          color: Colors.black,
          trailing: Switch(
            value: themeNotifier.isDarkModeEnabled,
            onChanged: (value) {
              themeNotifier.changeDarkMode(value);
            },
          ),
        ),
        SettingsModel(
            iconData: FontAwesomeIcons.info,
            title: AppMessages.aboutApp,
            color: Colors.lightBlueAccent),
        SettingsModel(
            iconData: Icons.assignment,
            title: AppMessages.privacyPolicy,
            color: Colors.grey),
        SettingsModel(
            iconData: FontAwesomeIcons.star,
            title: AppMessages.rateApp,
            color: Colors.amber),
      ];
    }

    return TargetPlatformWidget(
      materialWidget: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        /*appBar: CustomAppBar(
          title: AppMessages.settings,
        ),*/
        body: Container(
          child: ListView.separated(
              itemBuilder: (context, index) => SettingTile(
                    iconData: getAllSettings()[index].iconData,
                    title: getAllSettings()[index].title,
                    color: getAllSettings()[index].color,
                    trailing: getAllSettings()[index].trailing,
                  ),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      height: 1.hdp,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
              itemCount: getAllSettings().length),
        ),
      ),
    );
  }
}
