import 'dart:io';

import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/screens/Store_Locator/store_locator_screen.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/settings/language_country_screen.dart';
import 'package:almajidoud/screens/my_account/update_profile.dart';
import 'package:almajidoud/screens/my_account/widgets/logout_button.dart';
import 'package:almajidoud/screens/my_account/widgets/single_account_item.dart';
import 'package:almajidoud/screens/my_account/widgets/user_email.dart';
import 'package:almajidoud/screens/my_account/widgets/user_image_widget.dart';
import 'package:almajidoud/screens/my_account/widgets/user_name.dart';
import 'package:almajidoud/screens/web_view/webview.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/my_account/register_bottom_sheet.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/screens/WishList/wishlist_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:almajidoud/screens/my_account/widgets/profile_image.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();

  String _email = "";
  String _userName = "";
  String _currentLang = "";
  String? _imagePath;
  File? _pickedImage;
  bool finance_status=false;
  @override
  void initState() {
    _getUseData();
    super.initState();
  }

  void _getUseData() async {
    _currentLang =  MyApp.app_langauge;
    _email = await sharedPreferenceManager.readString(CachingKey.EMAIL);
    _userName = await sharedPreferenceManager.readString(CachingKey.USER_NAME);
    _imagePath = await sharedPreferenceManager.readString(CachingKey.PROFILE_IMAGE);
    if(_imagePath !='' ){
      _pickedImage = File(_imagePath!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
              backgroundColor: whiteColor,
              key: _drawerKey,
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
                                  context: context,
                                  percentageOfHeight: .10,
                                ),
                                ProfileImage(),

                                StaticData.vistor_value == "visitor"
                                    ? Container()
                                    :     userName(context: context, name: _userName),
                                StaticData.vistor_value == "visitor"
                                    ? Container()
                                    :       userEmail(context: context, email: _email),
                                responsiveSizedBox(context: context, percentageOfHeight: .03),
                                StaticData.vistor_value == "visitor"
                                    ? Container()
                                    :       singleAccountItem(
                                    context: context,
                                    iconPath: "assets/icons/profile2.png",
                                    text: "Edit Profile",
                                    isContainMoreIcon: true,
                                    onTap: () async {
                                      final _token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
                                      if(_token !=''){
                                        final result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UpdateProfile()));
                                        _userName = result['full_name'];
                                        setState(() {});
                                      }else{
                                        customAnimatedPushNavigation(context, SignInScreen());
                                      }
                                    }),
                                StaticData.vistor_value == "visitor"
                                    ? Container()
                                    :                 singleAccountItem(
                                    context: context,
                                    iconPath: "assets/icons/tracking.png",
                                    text: "My Orders",
                                    isContainMoreIcon: true,
                                    onTap: () {
                                      customPushNamedNavigation(context, OrdersScreen());
                                    }),
                                StaticData.vistor_value == "visitor"
                                    ? Container()
                                    : singleAccountItem(
                                    context: context,
                                    iconPath: "assets/icons/heart.png",
                                    text: "My WishList",
                                    isContainMoreIcon: true,
                                    onTap: () {
                                      customPushNamedNavigation(
                                          context, WishListScreen());
                                    }),
                                singleAccountItem(
                                    context: context,
                                    iconPath: "assets/icons/settings.png",
                                    text:   translator.translate("Settings"),
                                    isContainMoreIcon: true,
                                    onTap: () {
                                      customPushNamedNavigation(
                                          context, LanguageCountryScreen(
                                        type: 'settings' ,
                                      ));
                                    }),

                                singleAccountItem(
                                    context: context,
                                    text:translator.translate("Our Locations"),
                                    isContainMoreIcon: true,
                                    onTap: () {
                                      StoreLocatorScreen();
                                      customAnimatedPushNavigation(context, StoreLocatorScreen());
                                    }),

                                singleAccountItem(
                                    context: context,
                                    iconPath: "assets/icons/help.png",
                                    text: "Help Center",
                                    isContainMoreIcon: true,
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WebView(title: 'Contact us',url: Urls.CONTACT_US_URL,)));
                                    }),

                                singleAccountItem(
                                    context: context,
                                    iconPath: "assets/icons/faqs.png",
                                    text: translator.translate("FAQs"),
                                    isContainMoreIcon: true,
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WebView(title: "FAQs",url: Urls.FAQS_URL,)));
                                    }),

                                Container(
                                  width: width(context) * .95,
                                  padding:translator.activeLanguageCode == 'ar'? EdgeInsets.only(right: width(context)*0.08)
                                      :EdgeInsets.only(left: width(context)*0.08),
                                  child:     ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        ListTile(
                                          leading:  Image(
                                              image: AssetImage('assets/icons/shield.png'),
                                              width: isLandscape(context)
                                                  ? 2 * height(context) * .025
                                                  : height(context) * .025
                                          ),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 2),
                                          minLeadingWidth : 10,
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: customDescriptionText(
                                                    context: context,
                                                    text:"Policies and Information".tr(),
                                                    percentageOfHeight: .022,
                                                    textAlign: translator.activeLanguageCode == 'ar'?
                                                    TextAlign.right : TextAlign.left),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: IconButton(
                                                  icon: Icon(Icons.keyboard_arrow_down,size: 30,color: mainColor,), onPressed: () {  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: (finance_status)? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              singleAccountItem(
                                                  context: context,
                                                  iconPath: "assets/icons/about_us.png",
                                                  text: translator.translate("About US"),
                                                  percentageOfHeight: .018,
                                                  isContainMoreIcon: true,
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WebView(title: "About US",url: Urls.ABOUT_US_URL,)));
                                                  }),

                                              singleAccountItem(
                                                  context: context,
                                                  iconPath: "assets/icons/privacy.png",
                                                  text:translator.translate( "Privacy And Policy"),
                                                  percentageOfHeight: .018,
                                                  isContainMoreIcon: true,
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder:
                                                        (BuildContext context) => WebView(title: "Privacy And Policy",url: Urls.PTIVACY_URL,)));
                                                  }),

                                              singleAccountItem(
                                                  context: context,
                                                  iconPath: "assets/icons/tracking.png",
                                                  percentageOfHeight: .018,
                                                  text:translator.translate( "Shipping, Exchange, and Return"),
                                                  isContainMoreIcon: true,
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WebView(title: "Shipping, Exchange, and Return",url: Urls.SHIPPING_URL,)));
                                                  }),
                                              singleAccountItem(
                                                  context: context,
                                                  iconPath: "assets/icons/cancelled.png",
                                                  percentageOfHeight: .018,
                                                  text:translator.translate("Payment & Cancellations" ),
                                                  isContainMoreIcon: true,
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder:
                                                        (BuildContext context) => WebView(title: "Payment & Cancellations" ,url: Urls.CANCELLATIONS_URL,)));
                                                  }),
                                              singleAccountItem(
                                                  context: context,
                                                  iconPath: "assets/icons/vat.png",
                                                  text:translator.translate("VAT_certification" ),
                                                  isContainMoreIcon: true,
                                                  percentageOfHeight: .018,
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder:
                                                        (BuildContext context) => WebView(title: "VAT_certification" ,url: Urls.VAT_URL,)));
                                                  }),
                                              singleAccountItem(
                                                  context: context,
                                                  iconPath: "assets/icons/verified.png",
                                                  percentageOfHeight: .018,
                                                  text:translator.translate("Official Permits" ),
                                                  isContainMoreIcon: true,
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder:
                                                        (BuildContext context) => WebView(title:"Official Permits",url: Urls.PERMITS_URL,)));
                                                  }),
                                            ],
                                          ): null,
                                          onTap: (){
                                            setState(() {
                                              finance_status = !finance_status;
                                            });
                                          },

                                        ),

                                      ]),

                                ),

                                StaticData.vistor_value == 'visitor'
                                    ? logButton(context: context, type: "Sign In")
                                    : logButton(context: context, type: "Logout"),
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
                            ScreenAppBar(
                              onTapCategoryDrawer: () {
                                _drawerKey.currentState!.openDrawer();
                              },
                              category_name: translator.translate("My Account"),
                              // left_icon: "",
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              drawer: SettingsDrawer(
                node: fieldNode,
              ),
            )));
  }



}
