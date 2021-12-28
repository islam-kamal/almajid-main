import 'dart:io';

import 'package:almajidoud/screens/categories/categories_screen.dart';
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
  String _imagePath;
  File _pickedImage;

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
      _pickedImage = File(_imagePath);
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
                                userImageWidget(
                                  context: context,
                                  imagePath: _pickedImage,
                                  onTapAddImage: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Choose option',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: greenColor),
                                            ),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  InkWell(
                                                    onTap: _pickImageCamera,
                                                    splashColor: Colors.purpleAccent,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(8.0),
                                                          child: Icon(
                                                            Icons.camera,
                                                            color: Colors.purpleAccent,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Camera',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              color:
                                                              mainColor),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: _pickImageGallery,
                                                    splashColor: Colors.purpleAccent,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(8.0),
                                                          child: Icon(
                                                            Icons.image,
                                                            color: Colors.purpleAccent,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Gallery',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              color:
                                                              mainColor),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: _remove,
                                                    splashColor: Colors.purpleAccent,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(8.0),
                                                          child: Icon(
                                                            Icons.remove_circle,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Remove',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              color: Colors.red),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                    print("add image tapped ");
                                  },
                                ),
                                userName(context: context, name: _userName),
                                userEmail(context: context, email: _email),
                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .03),
                                singleAccountItem(
                                    context: context,
                                    iconPath: "assets/icons/share.png",
                                    text: "Edit Profile",
                                    isContainMoreIcon: true,
                                    onTap: () async {
                                      final _token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
                                      if(_token !=''){
                                        final result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UpdateProfile()));
                                        print('result-->'+  result['full_name']);
                                        _userName = result['full_name'];
                                        setState(() {});
                                      }else{
                                        customAnimatedPushNavigation(context, SignInScreen());
                                      }
                                    }),
                                singleAccountItem(
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
                                // singleAccountItem(
                                //     context: context,
                                //     iconPath: "assets/icons/settings3.png",
                                //     text: "Settings",
                                //     isContainMoreIcon: true,
                                //     onTap: () {
                                //       customPushNamedNavigation(context, SettingsScreen());
                                //     }),
                                singleAccountItem(
                                    context: context,
                                    iconPath: "assets/icons/settings3.png",
                                    text: _currentLang == 'en'?'العربية':'English',
                                    isContainMoreIcon: true,
                                    onTap: () {
                                      final newLang = _currentLang == 'en'?'ar':'en';
                                      _changeLang(lang: newLang);
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
                                    iconPath: "assets/icons/help.png",
                                    text: "About US",
                                    isContainMoreIcon: true,
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WebView(title: 'About us',url: Urls.ABOUT_US_URL,)));
                                    }),

                                singleAccountItem(
                                    context: context,
                                    iconPath: "assets/icons/help.png",
                                    text: "Privacy And Policy",
                                    isContainMoreIcon: true,
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WebView(title: 'Privacy And Policy',url: Urls.PTIVACY_URL,)));
                                    }),

                                singleAccountItem(
                                    context: context,
                                    iconPath: "assets/icons/help.png",
                                    text: "FAQs",
                                    isContainMoreIcon: true,
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => WebView(title: 'FAQs',url: Urls.FAQS_URL,)));
                                    }),
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
                                _drawerKey.currentState.openDrawer();
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

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);

// getting a directory path for saving
    final Directory extDir = await getApplicationDocumentsDirectory();
    String dirPath = extDir.path;
    final String filePath = '$dirPath/profile_image.png';
    //save the path in preference
    sharedPreferenceManager.writeData(CachingKey.PROFILE_IMAGE, filePath);

    final File newImage = await pickedImageFile.copy(filePath);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = newImage;
      });
    }

    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    // getting a directory path for saving
    final Directory extDir = await getApplicationDocumentsDirectory();
    String dirPath = extDir.path;
    final String filePath = '$dirPath/profile_image.png';
    //save the path in preference
    sharedPreferenceManager.writeData(CachingKey.PROFILE_IMAGE, filePath);

    final File newImage = await pickedImageFile.copy(filePath);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = newImage;
      });
    }

    Navigator.pop(context);
  }

  void _remove() {
    sharedPreferenceManager.removeData(CachingKey.PROFILE_IMAGE);
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  void _changeLang({String lang}) async {
    setState(() {
      translator.setNewLanguage(
        context,
        newLanguage: '${lang}',
        remember: true,
        restart: true,
      );

    });
    MyApp.setLocale(context, Locale('${lang}'));
    sharedPreferenceManager.writeData(CachingKey.APP_LANGUAGE, lang);
  }
}
