import 'package:almajidoud/main.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/settings/widgets/app_version.dart';
import 'package:almajidoud/screens/settings/widgets/settings_heeader.dart';
import 'package:almajidoud/screens/settings/widgets/single_settings_item.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/settings/AboutUsScreen/about_us_screen.dart';
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();
  var dropdownValue = MyApp.app_langauge == 'en' ?  'ENG' : 'AR';

  @override
  Widget build(BuildContext context) {
    bool switch1 = true;
    return WillPopScope(
      onWillPop: (){
        customAnimatedPushNavigation(context,MyApp.app_langauge == 'en' ? CustomCircleNavigationBar(
          page_index: 4,
        ) : CustomCircleNavigationBar(
          page_index: 0,
        ));
      },
        child: NetworkIndicator(
            child: PageContainer(
                child:Scaffold(
                  key:_drawerKey,
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
                                        }),
                                    responsiveSizedBox(context: context, percentageOfHeight: .035),
                                    singleSettingsItem(
                                        context: context,
                                        switchValue: switch1,
                                        text: "About Us",isSwitch: false,
                                        onTapArrow: (){
                                          customPushNamedNavigation(context, AboutUsScreen(

                                          ));
                                        }),
                                    responsiveSizedBox(
                                        context: context, percentageOfHeight: .035),
                                    //languageButton(context: context),
                                    Container(
                                        padding: EdgeInsets.only(
                                            right: width(context) * .05, left: width(context) * .05),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              customDescriptionText(
                                                  context: context, text: "Languages", percentageOfHeight: .025),
                                              SizedBox(width: width(context)*.05,),
                                              Container(
                                                padding:
                                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(10)),

                                                // dropdown below..
                                                child: DropdownButton<String>(
                                                    value: dropdownValue,
                                                    icon: Icon(Icons.arrow_drop_down),
                                                    iconSize: 42,
                                                    underline: SizedBox(),
                                                    onChanged: (String newValue) {
                                                      setState(() {
                                                        dropdownValue = newValue;
                                                        changeLang(
                                                            lang: dropdownValue  == 'ENG' ? 'en' : 'ar'
                                                        );
                                                      });
                                                    },
                                                    items: <String>[
                                                      'ENG',
                                                      'AR',
                                                    ].map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value,style: TextStyle(color: mainColor),),
                                                      );
                                                    }).toList()),
                                              ),
                                            ])),
                                    responsiveSizedBox(
                                        context: context, percentageOfHeight: .035),

                                    Divider(color: mainColor),
                                    responsiveSizedBox(context: context, percentageOfHeight: .01),
                                    appVersion(context: context),


                                  ],
                                )),
                          ),
                          Container(
                            height: height(context),
                            width: width(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ScreenAppBar(
                                  right_icon: 'cart',
                                  category_name: translator.translate("Settings"),
                                  screen:translator.activeLanguageCode=='ar' ? CustomCircleNavigationBar(
                                    page_index: 0,
                                  ): CustomCircleNavigationBar(
                                    page_index: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  drawer: SettingsDrawer(
                    node: fieldNode,
                  ),
                ))),

        );
  }
  void changeLang({String lang}) async {
    setState(() {
      translator.setNewLanguage(
        context,
        newLanguage: '${lang}',
        remember: true,
        restart: false,
      );

    });

    MyApp.setLocale(context, Locale('${lang}'));
 sharedPreferenceManager.writeData(CachingKey.APP_LANGUAGE, lang);
  }

}
