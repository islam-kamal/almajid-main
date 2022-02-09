/*
import 'dart:io';

import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/screens/Store_Locator/store_locator_screen.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
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
                                          return Directionality(
                                              textDirection: MyApp.app_langauge =='ar' ? TextDirection.rtl :TextDirection.ltr,
                                              child: AlertDialog(
                                                title: Text(
                                                  translator.translate("Choose option"),
                  */


import 'package:almajidoud/Base/network-mappers.dart';

class AddressModel extends BaseMappable{
  var id;
  var customerId;
  Region region;
  var regionId;
  var countryId;
  List<String> street;
  var telephone;
  var postcode;
  var city;
  var firstname;
  var lastname;
  String message;
  Parameters parameters;
  AddressModel(
      {this.id,
        this.customerId,
        this.region,
        this.regionId,
        this.countryId,
        this.street,
        this.telephone,
        this.postcode,
        this.city,
        this.firstname,
        this.lastname,this.message,this.parameters});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    regionId = json['region_id'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    data['region_id'] = this.regionId;
    data['country_id'] = this.countryId;
    data['street'] = this.street;
    data['telephone'] = this.telephone;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    regionId = json['region_id'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    return AddressModel(parameters: parameters,message: message,customerId: customerId,id: id,lastname: lastname,
        firstname: firstname,city: city,countryId: countryId,postcode: postcode,region: region,regionId: regionId,
        street: street,telephone: telephone);
  }
}

class Region {
  var regionCode;
  var region;
  var regionId;

  Region({this.regionCode, this.region, this.regionId});

  Region.fromJson(Map<String, dynamic> json) {
    regionCode = json['region_code'];
    region = json['region'];
    regionId = json['region_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_code'] = this.regionCode;
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    return data;
  }
}
class Parameters {
  String fieldName;
  Null fieldValue;

  Parameters({this.fieldName, this.fieldValue});

  Parameters.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
    fieldValue = json['fieldValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    data['fieldValue'] = this.fieldValue;
    return data;
  }
}
