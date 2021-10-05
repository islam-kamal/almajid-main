import 'package:almajidoud/screens/settings/widgets/app_version.dart';
import 'package:almajidoud/screens/settings/widgets/connnected_accounts.dart';
import 'package:almajidoud/screens/settings/widgets/language_button.dart';
import 'package:almajidoud/screens/settings/widgets/settings_heeader.dart';
import 'package:almajidoud/screens/settings/widgets/settings_navigation_bar.dart';
import 'package:almajidoud/screens/settings/widgets/single_settings_item.dart';
import 'package:almajidoud/utils/file_export.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    bool switch1 = true;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
          height: height(context),
          width: width(context),
          child: Stack(
            children: [
              Container(
                height: height(context),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .13),
                    singleSettingsItem(
                        context: context,
                        switchValue: switch1,
                        text: "Enable Location",
                        onChangeSwitch: () {
                          setState(() {
                            switch1 != switch1;
                          });
                        }),
                    singleSettingsItem(
                        context: context,
                        switchValue: switch1,
                        text: "Enable Notifications",
                        onChangeSwitch: () {
                          setState(() {
                            switch1 != switch1;
                          });
                        }),

                    responsiveSizedBox(
                        context: context, percentageOfHeight: .02),
                    singleSettingsItem(
                        context: context,
                        switchValue: switch1,
                        text: "Privacy Policy",isSwitch: false,
                        onChangeSwitch: () {
                          setState(() {
                            switch1 != switch1;
                          });
                        }),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .035),
                    singleSettingsItem(
                        context: context,
                        switchValue: switch1,
                        text: "General",isSwitch: false,
                        onChangeSwitch: () {
                          setState(() {
                            switch1 != switch1;
                          });
                        }), responsiveSizedBox(
                        context: context, percentageOfHeight: .035),
                    singleSettingsItem(
                        context: context,
                        switchValue: switch1,
                        text: "About Us",isSwitch: false,
                        onChangeSwitch: () {
                          setState(() {
                            switch1 != switch1;
                          });
                        }),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .035),
                    languageButton(context: context),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .035),
                    connectedAccounts(context: context),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .02),
                    singleSettingsItem(
                        context: context,
                        switchValue: switch1,
                        text: "Twitter"),   singleSettingsItem(
                        context: context,
                        switchValue: switch1,
                        text: "Facebook",),   singleSettingsItem(
                        context: context,
                        switchValue: switch1,
                        text: "Instagram",
                       ),
                    Divider(color: mainColor),
                    appVersion(context: context),

                    responsiveSizedBox(
                        context: context, percentageOfHeight: .11),
                  ],
                )),
              ),
              Container(
                height: height(context),
                width: width(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    settingsHeader(context: context),
                    settingsBottomNavigationBar(context: context)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
