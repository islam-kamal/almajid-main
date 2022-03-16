import 'dart:async';

import 'package:almajidoud/Model/CityModel/city_model.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/client/address_model.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/Repository/CountriesRepo/countries_repoistory.dart';
import 'package:almajidoud/Repository/ShippmentAdressRepo/shipment_address_repository.dart';
import 'package:almajidoud/Widgets/customText.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/checkout/checkout_payment_screen.dart';
import 'package:almajidoud/screens/checkout/widgets/address_card.dart';
import 'package:almajidoud/screens/checkout/widgets/checkout_header.dart';
import 'package:almajidoud/screens/checkout/widgets/next_button.dart';
import 'package:almajidoud/screens/checkout/widgets/page_title.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_tilte.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Bloc/ShippmentAddress_Bloc/shippment_address_bloc.dart';
import 'package:almajidoud/screens/checkout/Shippment_Address/custom_saved_addresses_widget.dart';
import 'package:almajidoud/screens/checkout/Shippment_Address/custom_cities_widget.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CheckoutAddressScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckoutAddressScreenState();
  }

}
class CheckoutAddressScreenState extends State<CheckoutAddressScreen> with TickerProviderStateMixin {
  //-------------- get cities -----------------------------
  var selected_address_id;
  bool selected_address_status = false;
  var check = true;
  var _currentIndex ;
  var city_id;
  List<Item> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: header_item[index],
      );
    });
  }
  List header_item = [translator.activeLanguageCode == 'ar'? 'اختيار المدينة' : 'Chosse City'];
  List<Item> _data;
  Future<List<CityModel>> cities_list;
//--------------------------------------------------------------

  //------------------------ get saved address --------------------------
  var saved_address_currentIndex = 1;
  List<Item> saved_address_generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: saved_address_header_item[index],
      );
    });
  }
  List saved_address_header_item = [translator.activeLanguageCode == 'ar'? 'اختيار من العناوين المحفوظة' : 'Chosse From Saved Address'];
  List<Item> saved_address_data;
  //-----------------------------------------------------

  TextEditingController city_controller = TextEditingController();
  String city_search_text='';
  bool city_search_field_Status = true;

  TextEditingController address_controller = TextEditingController();
  String address_search_text='';
  bool address_search_field_Status = true;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();

  AnimationController _loginButtonController;
  bool isLoading = false;
  bool edit_address_status = false;
  bool add_new_address_status = false;
  var frist_name,last_name,phone,street, addres_city_name,address_city_id;

  Future<List<AddressModel>> all_addresses;
  @override
  void initState() {
    StaticData.vistor_value == 'visitor' ? null :  all_addresses = shipmentAddressRepository.get_all_saved_addresses(context: context);
    cities_list= countriesRepository.get_cities(context: context);
    get_frist_city();
    _data = generateItems(1);

    saved_address_data = saved_address_generateItems(1);


    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();

  }

  void get_frist_city()async{
    await cities_list.then((value){
      _currentIndex=  value[1].value;

    });

  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
    }
  }
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
          child: Scaffold(
            key: _drawerKey,
            backgroundColor: whiteColor,
            body: BlocListener<ShipmentAddressBloc,AppState>(
                  bloc: shipmentAddressBloc,
                  listener: (context,state){
                    if (state is Loading) {
                      if(state.indicator == "address_detials"){
                        _playAnimation();
                      }else if(state.indicator == 'AddNewAdress'){
                        _playAnimation();
                      }else if (state.indicator == 'GuestAddAdress'){
                        _playAnimation();
                      }
                    }
                    else if (state is ErrorLoading) {
                      _stopAnimation();
                      if(state.indicator == "address_detials"){
                        var data = state.model as AddressModel;
                        Flushbar(
                          messageText: Row(
                            children: [
                              Container(
                                width: StaticData.get_width(context) * 0.7,
                                child: Wrap(
                                  children: [
                                    Text(
                                      '${data.message}',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(color: whiteColor),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Text(
                                translator.translate("Try Again"),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: whiteColor),
                              ),
                            ],
                          ),
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          backgroundColor: redColor,
                          flushbarStyle: FlushbarStyle.FLOATING,
                          duration: Duration(seconds: 6),
                        )..show(_drawerKey.currentState.context);
                      }else{
                        if(StaticData.vistor_value != 'visitor'){
                          var data = state.model as AddressModel;
                          Flushbar(
                            messageText: Row(
                              children: [
                                Container(
                                  width: StaticData.get_width(context) * 0.7,
                                  child: Wrap(
                                    children: [
                                      Text(
                                        '${data.message}',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  translator.translate("Try Again"),
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: redColor,
                            flushbarStyle: FlushbarStyle.FLOATING,
                            duration: Duration(seconds: 6),
                          )..show(_drawerKey.currentState.context);
                        }else{
                          var data = state.model as GuestShipmentAddressModel;
                          Flushbar(
                            messageText: Row(
                              children: [
                                Container(
                                  width: StaticData.get_width(context) * 0.7,
                                  child: Wrap(
                                    children: [
                                      Text(
                                        '${data.message}',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  translator.translate("Try Again"),
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: redColor,
                            flushbarStyle: FlushbarStyle.FLOATING,
                            duration: Duration(seconds: 6),
                          )..show(_drawerKey.currentState.context);
                        }
                      }


                    }
                    else if (state is Done) {
                      _stopAnimation();
                      if(state.indicator == "address_detials"){
                        var data = state.model as AddressModel;
                   setState(() {
                     frist_name = data.firstname;
                     last_name = data.lastname;
                     phone = data.telephone;
                     street = data.street[0];
                     addres_city_name = data.city;
                     address_city_id = data.regionId;
                     shipmentAddressBloc.frist_name_controller.value = frist_name;
                     shipmentAddressBloc.last_name_controller.value = last_name;
                     shipmentAddressBloc.phone_controller.value = phone;
                     shipmentAddressBloc.street_controller.value = street;
                   });
                      }
                      else {
                        if(state.indicator == "GetAllAddressesEvent"){
                        }else{
                          var data = state.model as GuestShipmentAddressModel;

                          customAnimatedPushNavigation(context,CheckoutPaymentScreen(
                            guestShipmentAddressModel: data,
                          ));
                        }
                        }

                    }
                  },
                  child: Container(
                    height: height(context),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child:    checkoutAdresssAppBar()
                        ),
                        Expanded(
                          flex: 1,
                          child:    Padding(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            child:  topPageIndicator(context: context),
                          ),
                        ),

                        !edit_address_status ?         StaticData.vistor_value == 'visitor' ?  Expanded(
                          flex: 9,
                          child:base_checkout_address(),
                        )
                            :      Expanded(
                          flex: 9,
                          child:  StaticData.saved_addresses_count == 0? Container():          show_all_avaliable_addresses(),
                        )
                            :  Expanded(
                          flex: 9,
                      child: SingleChildScrollView(
                        child: StaticData.chosse_address_status ? checkout_address(
                            frist_name: frist_name,
                            last_name: last_name,
                            street: street,
                            phone: phone,
                            address_city_id: address_city_id,
                            city_name: addres_city_name
                        ) : base_checkout_address(),
                      )

                    ),

                        //  nextButton(context: context)
                        Expanded(
                            flex: 1,
                            child:    addressNextButton(context: context)
                        )
                      ],
                    ),
                  )
                )
            ),
          ),
        );
  }


  Widget base_checkout_address(){
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(8)),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Form(
              key: _formKey,

              child: Column(
                children: [
                  responsiveSizedBox(context: context, percentageOfHeight: .01),

                  get_cities(),

                  responsiveSizedBox(context: context, percentageOfHeight: .01),

                  paymentTitle(context: context, title: "First Name"),
                  responsiveSizedBox(context: context, percentageOfHeight: .015),
                  frist_name_addressTextFields(context: context, hint: "Frist Name"),
                  responsiveSizedBox(context: context, percentageOfHeight: .015),

                  paymentTitle(context: context, title: "Last Name"),
                  responsiveSizedBox(context: context, percentageOfHeight: .015),
                  last_name_addressTextFields(context: context, hint: "Last Name"),

                  StaticData.vistor_value == 'visitor' ?   Column(
                    children: [
                      responsiveSizedBox(context: context, percentageOfHeight: .015),
                      paymentTitle(context: context, title: "Email"),
                      responsiveSizedBox(context: context, percentageOfHeight: .015),
                      email_addressTextFields(context: context, hint: "Email"),
                    ],
                  ) : Container(),
                  responsiveSizedBox(context: context, percentageOfHeight: .015),

                  paymentTitle(context: context, title: "Phone"),
                  responsiveSizedBox(context: context, percentageOfHeight: .015),
                  phone_addressTextFields(
                      context: context, hint: "Ex: 5xxxxxxxx"),
                  responsiveSizedBox(
                      context: context, percentageOfHeight: .015),

                  paymentTitle(context: context, title: "Street"),
                  responsiveSizedBox(
                      context: context, percentageOfHeight: .015),
                  street_addressTextFields(
                      context: context, hint: "Street"),
                  responsiveSizedBox(
                      context: context, percentageOfHeight: .015),
                ],
              ))
      ),
    );
  }

  Widget checkout_address({var frist_name,var last_name,var phone,var street,var city_name,
    var address_city_id}){
    return  Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(8)),
        width: width(context) * .9,
        child: Form(
        key: _formKey,
        child: Column(
          children: [
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            get_cities(
              current_adress_city_id: address_city_id,
              city_name: city_name
            ),

            responsiveSizedBox(context: context, percentageOfHeight: .01),

            paymentTitle(
                context: context, title: "First Name"),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            frist_name_addressTextFields(
                context: context, hint: frist_name,initialValue: frist_name),
            responsiveSizedBox(context: context, percentageOfHeight: .01),

            paymentTitle(
                context: context, title: "Last Name"),
            responsiveSizedBox(
                context: context, percentageOfHeight: .01),
            last_name_addressTextFields(context: context, hint: last_name,initialValue: last_name),

            StaticData.vistor_value == 'visitor' ?   Column(
              children: [
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                paymentTitle(context: context, title: "Email"),
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                email_addressTextFields(context: context, hint: "Email"),
              ],
            ) : Container(),
            responsiveSizedBox(
                context: context, percentageOfHeight: .01),

            paymentTitle(context: context, title: "Phone"),
            responsiveSizedBox(
                context: context, percentageOfHeight: .01),
            phone_addressTextFields(
                context: context, hint: phone==null?"Ex: 5xxxxxxxx" : phone.toString().substring(4)),
            responsiveSizedBox(
                context: context, percentageOfHeight: .01),

            paymentTitle(context: context, title: "Street"),
            responsiveSizedBox(
                context: context, percentageOfHeight: .01),
            street_addressTextFields(
                context: context, hint: street,initialValue: street),
            responsiveSizedBox(
                context: context, percentageOfHeight: .01),
          ],
        ))
    );
  }




  Widget get_saved_addresses(){
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.9,
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              saved_address_data[index].isExpanded = !isExpanded;
              address_search_field_Status = !address_search_field_Status;
            });
          },
          children: saved_address_data.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.headerValue),
                  subtitle:  address_search_field_Status ? null : TextFormField(
                  controller: address_controller,
                  onChanged: (value){
                    setState(() {
                      address_search_text = address_controller.value.text;

                    });
                  },

                  style: TextStyle(color: mainColor,
                    fontSize:AlmajedFont.primary_font_size,
                  ),
                  cursorColor: greyColor,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),

                    hintText: translator.translate("Search By Address" ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize:AlmajedFont.secondary_font_size,),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: greenColor)),
                  ),
                ),
                );
              },
              body: Container(
                  height: MediaQuery.of(context).size.width / 2.5,
                  child: FutureBuilder<List<AddressModel>>(
                    future: all_addresses,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length != 0) {
                            return Directionality(
                                textDirection: translator.activeLanguageCode == 'ar'?TextDirection.rtl : TextDirection.ltr,
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child:  ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {

                                            return snapshot.data[index].street[0].toLowerCase().contains(address_search_text) ?
                                            Directionality(
                                              textDirection: MyApp.app_langauge == 'ar'? TextDirection.rtl :  TextDirection.ltr,
                                              child:Container(
                                                  padding: EdgeInsets.only(
                                                      right: 10, left: 10),
                                                  child: Column(
                                                    children: <Widget>[
                                                      RadioListTile(
                                                        groupValue: saved_address_currentIndex,
                                                        title: Text(
                                                            "${snapshot.data[index].region.region} ,${snapshot.data[index].street[0]}",
                                                            style: TextStyle(fontSize: AlmajedFont.secondary_font_size)
                                                        ),
                                                        value: snapshot.data[index].id,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            saved_address_currentIndex = val;
                                                            StaticData.chossed_address_id = snapshot.data[index].id;
                                                            sharedPreferenceManager.writeData(CachingKey.CHOSSED_ADDRESS_ID, StaticData.chossed_address_id);

                                                            shipmentAddressBloc.add(AddressDetailsEvent(
                                                                address_id: snapshot.data[index].id
                                                            ));


                                                            item.isExpanded = false;
                                                            address_search_field_Status = true;
                                                            address_controller.clear();
                                                            address_search_text = '';

                                                            saved_address_header_item.add( "${snapshot.data[index].region.region} ,${snapshot.data[index].street[0]}");

                                                            item.headerValue =
                                                                saved_address_header_item.last;
                                                            StaticData.chosse_address_status = true;
                                                          });
                                                        },
                                                      ),
                                                      Divider(
                                                        color: Color(0xFFDADADA),
                                                      )
                                                    ],
                                                  )),
                                            )
                                                  : Container();
                                          },
                                        ))
                                  ],
                                )
                            );
                          } else {
                            return Container(
                              child: Text(
                                  translator.translate("There is no saved addresses")),
                            );
                          }
                        } else {
                          return Container(
                            child: Text(translator.translate("There is no saved addresses")),
                          );
                        }
                      }

                      // By default, show a loading spinner.
                      return Center(
                        child: CircularProgressIndicator(

                        ),
                      );
                    },
                  )),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ));
  }

  Widget get_cities({var current_adress_city_id, var city_name}){
    if(current_adress_city_id != null){
      sharedPreferenceManager.writeData(CachingKey.REGION_ID, current_adress_city_id.toString());
      sharedPreferenceManager.writeData(CachingKey.REGION_EN,  city_name);
      sharedPreferenceManager.writeData(CachingKey.REGION_AR,  city_name);

    }

    return   Directionality(
        textDirection: MyApp.app_langauge == 'ar'? TextDirection.rtl :  TextDirection.ltr,
        child: Container(
        padding: EdgeInsets.all(10),
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
              city_search_field_Status = !city_search_field_Status;
            });
          },
          children: _data.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(city_name?? item.headerValue),
                  subtitle: city_search_field_Status ? null: TextFormField(
                    controller: city_controller,
                    onChanged: (value){
                      setState(() {
                        city_search_text = city_controller.value.text;

                      });
                    },
                    style: TextStyle(color: mainColor,
                      fontSize:AlmajedFont.primary_font_size,
                    ),
                    cursorColor: greyColor,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                      hintText: translator.translate("Search By City Name"),
                      hintStyle:
                      TextStyle(color: Colors.grey, fontSize:AlmajedFont.secondary_font_size,),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: greenColor)),
                    ),
                  ),
                );
              },
              body:Container(
                  height: MediaQuery.of(context).size.width / 3,
                  child: FutureBuilder<List<CityModel>>(
                    future: cities_list,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length != 0) {
                            return  ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {

                                if(index ==0){
                                  return Container();
                                }
                                if(MyApp.app_langauge == 'ar'){
                                  return snapshot.data[index].label.toLowerCase().contains(city_search_text) ?
                                  Directionality(
                                    textDirection: MyApp.app_langauge == 'ar'? TextDirection.rtl :  TextDirection.ltr,
                                    child: Container(
                                        padding: EdgeInsets.only(right: 10, left: 10),
                                        child: Column(
                                          children: <Widget>[
                                            RadioListTile(
                                              groupValue:  _currentIndex,
                                              title: Text(
                                                "${translator.activeLanguageCode == 'ar'? snapshot.data[index].label :snapshot.data[index].title}",
                                                textDirection: MyApp.app_langauge == 'ar'? TextDirection.rtl :  TextDirection.ltr,
                                              ),
                                              value: snapshot.data[index].value,
                                              onChanged: (val) {

                                                _currentIndex = val;
                                                city_id = snapshot.data[index].value;
                                                addres_city_name  = translator.activeLanguageCode == 'ar'? snapshot.data[index].label
                                                    : snapshot.data[index].title;
                                                address_city_id = snapshot.data[index].value.toString();
                                                sharedPreferenceManager.writeData(CachingKey.REGION_ID, snapshot.data[index].value.toString());
                                                sharedPreferenceManager.writeData(CachingKey.REGION_EN,  snapshot.data[index].title);
                                                sharedPreferenceManager.writeData(CachingKey.REGION_AR,  snapshot.data[index].label);

                                                item.isExpanded = false;
                                                city_search_field_Status = true;
                                                city_controller.clear();
                                                city_search_text = '';


                                                header_item.add( translator.activeLanguageCode == 'ar'? snapshot.data[index].label
                                                    :  snapshot.data[index].title);
                                                setState(() {
                                                  item.headerValue =
                                                      header_item.last;
                                                });
                                              },
                                            ),
                                            Divider(
                                              color: Color(0xFFDADADA),
                                            )
                                          ],
                                        )),
                                  ) : Container();
                                }
                                else{
                                  return snapshot.data[index].title.toLowerCase().contains(city_search_text) ?
                                  Directionality(
                                    textDirection: MyApp.app_langauge == 'ar'? TextDirection.rtl :  TextDirection.ltr,
                                    child:Container(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Column(
                                          children: <Widget>[
                                            RadioListTile(
                                              groupValue:  _currentIndex,
                                              title: Text(
                                                "${translator.activeLanguageCode == 'ar'? snapshot.data[index].label :snapshot.data[index].title}",
                                                textDirection:MyApp.app_langauge == 'ar'? TextDirection.rtl :  TextDirection.ltr,
                                              ),
                                              value: snapshot.data[index].value,
                                              onChanged: (val) {

                                                _currentIndex = val;
                                                city_id = snapshot.data[index].value;
                                                addres_city_name  = translator.activeLanguageCode == 'ar'? snapshot.data[index].label
                                                    : snapshot.data[index].title;
                                                address_city_id = snapshot.data[index].value.toString();
                                                sharedPreferenceManager.writeData(CachingKey.REGION_ID, snapshot.data[index].value.toString());
                                                sharedPreferenceManager.writeData(CachingKey.REGION_EN,  snapshot.data[index].title);
                                                sharedPreferenceManager.writeData(CachingKey.REGION_AR,  snapshot.data[index].label);

                                                item.isExpanded = false;
                                                city_search_field_Status = true;
                                                city_controller.clear();
                                                city_search_text = '';

                                                header_item.add( translator.activeLanguageCode == 'ar'? snapshot.data[index].label
                                                    :  snapshot.data[index].title);
                                                setState(() {
                                                  item.headerValue =
                                                      header_item.last;
                                                });
                                              },
                                            ),
                                            Divider(
                                              color: Color(0xFFDADADA),
                                            )
                                          ],
                                        )),
                                  ) : Container();
                                }


                              },
                            );
                          } else {
                            return Container(
                              child: Text(
                                  translator.translate("There is no cities")),
                            );
                          }
                        } else {
                          return Container(
                            child: Text(translator.translate("There is no cities")),
                          );
                        }
                      }

                      // By default, show a loading spinner.
                      return Center(
                        child: CircularProgressIndicator( ),
                      );
                    },
                  )),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        )   ));
  }


  frist_name_addressTextFields({BuildContext context, String hint , var initialValue}) {
    return StreamBuilder<String>(
      stream: shipmentAddressBloc.frist_name,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(right: width(context) * .025, left: width(context) * .025),
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            initialValue: initialValue??'',
            style: TextStyle(
                color: mainColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .020
                    : height(context) * .020),
            cursorColor: greyColor.withOpacity(.5),
            decoration: InputDecoration(
           hintText: translator.translate(hint??"First Name"),
              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintStyle: TextStyle(
                  color: mainColor,
                  fontWeight:initialValue == null ? FontWeight.normal : FontWeight.bold,
                  fontSize: isLandscape(context)
                      ? initialValue == null ? 2* height(context) * .016 : 2* height(context) * .018
                      : initialValue == null ? height(context) * .016 : height(context) * .018
              ),
              filled: true,
              fillColor: backGroundColor,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              errorText: snapshot.error,

            ),
            validator: StaticData.chossed_address_id != null ? null :(value) {
              if (value == null || value.isEmpty) {
                return '${translator.translate("Please enter")} ${translator.translate("Frist Name")}';
              }
              return null;
            },
            onChanged: shipmentAddressBloc.frist_name_change,
          ),
        );
      },
    );
  }

  last_name_addressTextFields({BuildContext context, String hint,var initialValue}) {
    return StreamBuilder<String>(
      stream: shipmentAddressBloc.last_name,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(right: width(context) * .025, left: width(context) * .025),

          child: TextFormField(
            initialValue: initialValue??'',
            style: TextStyle(
                color: mainColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .02
                    : height(context) * .02),
            cursorColor: greyColor.withOpacity(.5),
            decoration: InputDecoration(
              hintText: translator.translate(hint??"Last Name"),
              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

              hintStyle: TextStyle(
                  color: mainColor,
                  fontWeight:initialValue == null ? FontWeight.normal : FontWeight.bold,
                  fontSize: isLandscape(context)
                      ? initialValue == null ? 2* height(context) * .016 : 2* height(context) * .018
                      : initialValue == null ? height(context) * .016 : height(context) * .018),
              filled: true,
              fillColor: backGroundColor,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              errorText: snapshot.error,

            ),
            validator: StaticData.chossed_address_id != null ? null :(value) {
              if (value == null || value.isEmpty) {
                return '${translator.translate("Please enter")} ${translator.translate("Last Name")}';
              }
              return null;
            },
            onChanged: shipmentAddressBloc.last_name_change,
          ),
        );
      },
    );
  }

  email_addressTextFields({BuildContext context, String hint}) {
    return StreamBuilder<String>(
      stream: shipmentAddressBloc.email,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(right: width(context) * .025, left: width(context) * .025),
          child: TextFormField(

            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: mainColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .02
                    : height(context) * .02),
            cursorColor: greyColor.withOpacity(.5),
            decoration: InputDecoration(
              hintText: translator.translate(hint??"Email"),
              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

              hintStyle: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.normal,
                  fontSize: isLandscape(context)
                      ? 2 * height(context) * .016
                      : height(context) * .016),
              filled: true,
              fillColor: backGroundColor,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              errorText: snapshot.error,

            ),
            validator: StaticData.chossed_address_id != null ? null :(value) {
        Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
              if (!regex.hasMatch(value)) {
                return '${translator.translate("Please enter")} ${translator.translate("Email")}';
              }
              return null;
            },
            onChanged: shipmentAddressBloc.email_change,
          ),
        );
      },
    );
  }

  phone_addressTextFields({BuildContext context, String hint,var initialValue}) {

    String _countryCode  = MyApp.app_location == 'sa' ?"+966" : MyApp.app_location == 'kw' ? "+965" : "+971";

    return StreamBuilder<String>(
      stream: shipmentAddressBloc.phone,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(right: width(context) * .025, left: width(context) * .025),
          child: translator.activeLanguageCode == 'en'?Row(
            children: [
              CountryCodePicker(
                onChanged: (Object object)=>_countryCode=object.toString(),
                initialSelection: MyApp.app_location == 'sa' ?'SA' : MyApp.app_location == 'kw' ? 'KW' : 'AE',
                countryFilter: ['SA', 'KW',],
                showFlagDialog: true,
              ),
              Flexible(
                child: TextFormField(
                  initialValue: initialValue??'',
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: mainColor,
                      fontSize: isLandscape(context)
                          ? 2 * height(context) * .02
                          : height(context) * .02),
                  cursorColor: greyColor.withOpacity(.5),
                  decoration: InputDecoration(
                    hintText: translator.translate(hint??"Ex: 5xxxxxxxx"),
                    contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                    hintStyle: TextStyle(
                        color: mainColor,
                        fontWeight:initialValue == null ? FontWeight.normal : FontWeight.bold,
                        fontSize: isLandscape(context)
                            ? initialValue == null ? 2* height(context) * .016 : 2* height(context) * .018
                            : initialValue == null ? height(context) * .016 : height(context) * .018),
                    filled: true,
                    fillColor: whiteColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    errorText: snapshot.error,

                  ),
                  validator: StaticData.chossed_address_id != null ? null :(value) {
                    Pattern pattern = r'^(009665|009715|00965|9665|9715|\+9665||\+9715|\+965|05|5)(5|0|3|6|4|9|1|8|7|2)([0-9]{7})?$';
                    RegExp regex = new RegExp(pattern);

                    if (value == null || value.isEmpty) {
                      return '${translator.translate("Please enter")} ${translator.translate("Phone")}';
                    }else  if(!regex.hasMatch(value) || value.length < 8){
                      return '${translator.translate("Please enter a correct phone number")} ';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    shipmentAddressBloc.phone_change(_countryCode+text);
                  },
                ),
              ),
            ],
          ):Row(
            children: [
              Flexible(
                child: TextFormField(
                  textAlign: TextAlign.left,
                  initialValue: initialValue??'',
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: mainColor,
                      fontSize: isLandscape(context)
                          ? 2 * height(context) * .02
                          : height(context) * .02),
                  cursorColor: greyColor.withOpacity(.5),
                  decoration: InputDecoration(
                    hintText: translator.translate(hint??"Ex: 5xxxxxxxx"),
                    contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                    hintStyle: TextStyle(
                        color:mainColor,
                        fontWeight:initialValue == null ? FontWeight.normal : FontWeight.bold,
                        fontSize: isLandscape(context)
                            ? initialValue == null ? 2* height(context) * .016 : 2* height(context) * .018
                            : initialValue == null ? height(context) * .016 : height(context) * .018),
                    filled: true,
                    fillColor: whiteColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    errorText: snapshot.error,

                  ),
                  validator: StaticData.chossed_address_id != null ? null :(value) {
                    Pattern pattern = r'^(009665|009715|00965|9665|9715|\+9665||\+9715|\+965|05|5)(5|0|3|6|4|9|1|8|7|2)([0-9]{7})?$';
                    RegExp regex = new RegExp(pattern);

                    if (value == null || value.isEmpty) {
                      return '${translator.translate("Please enter")} ${translator.translate("Phone")}';
                    }else  if(!regex.hasMatch(value) || value.length < 8){
                      return '${translator.translate("Please enter a correct phone number")} ';

                    }
                    return null;
                  },
                  onChanged: (text) {
                    shipmentAddressBloc.phone_change(_countryCode+text);
                  },
                ),
              ),
              CountryCodePicker(
                onChanged: (Object object)=>_countryCode=object.toString(),
                initialSelection: MyApp.app_location == 'sa' ?'SA' : MyApp.app_location == 'kw' ? 'KW' : 'AE',
                countryFilter: ['SA', 'KW', ],
                showFlagDialog: true,
              ),
            ],
          ),
        );
      },
    );
  }

  street_addressTextFields({BuildContext context, String hint,var initialValue}) {
    return StreamBuilder<String>(
      stream: shipmentAddressBloc.street,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(right: width(context) * .025, left: width(context) * .025),

          child: TextFormField(
            initialValue: initialValue??'',
            keyboardType: TextInputType.streetAddress,
            style: TextStyle(
                color: mainColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .02
                    : height(context) * .02),
            cursorColor: greyColor.withOpacity(.5),
            decoration: InputDecoration(
              hintText: translator.translate(hint??"Shippment Address"),
              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

              hintStyle: TextStyle(
                  color: mainColor,
                  fontWeight:initialValue == null ? FontWeight.normal : FontWeight.bold,
                  fontSize: isLandscape(context)
                      ? initialValue == null ? 2* height(context) * .016 : 2* height(context) * .018
                      : initialValue == null ? height(context) * .016 : height(context) * .018),
              filled: true,
              fillColor: backGroundColor,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              errorText: snapshot.error,

            ),
            validator:StaticData.chossed_address_id != null ? null : (value) {
              if (value == null || value.isEmpty) {
                return '${translator.translate("Please enter")} ${translator.translate("Shippment Address")}';
              }
              return null;
            },
            onChanged: shipmentAddressBloc.street_change,
          ),
        );
      },
    );
  }


  addressNextButton({BuildContext context,}) {
    return StaggerAnimation(
      titleButton: translator.translate("Next"),
      buttonController: _loginButtonController.view,
      btn_width: width(context) ,
      checkout_color: true,
        product_details_page :true,
      onTap: () {
        if(selected_address_id != null){
          StaticData.order_address = addres_city_name +
              " , " //use this to show address in CheckoutSummaryScreen
                  "${shipmentAddressBloc.street_controller.value == null
                  ? street
                  : shipmentAddressBloc.street_controller.value }";
          shipmentAddressBloc.add(
              GuestAddAdressEvent(context: context)
          );
        }else{
          if (_formKey.currentState.validate() ) {
            if(addres_city_name == null){
              errorDialog(
                  context: context,
                  text: translator.translate("City should be mandatory in checkout")
              );
            }
            else{
              StaticData.order_address = addres_city_name +
                  " , " //use this to show address in CheckoutSummaryScreen
                      "${shipmentAddressBloc.street_controller.value == null
                      ? street
                      : shipmentAddressBloc.street_controller.value }";
              shipmentAddressBloc.add(
                  GuestAddAdressEvent(context: context)
              );
            }

          }
          else if(frist_name !=null  ){
            StaticData.order_address = addres_city_name +
                " , " //use this to show address in CheckoutSummaryScreen
                    "${shipmentAddressBloc.street_controller.value == null
                    ? street
                    : shipmentAddressBloc.street_controller.value }";
            shipmentAddressBloc.add(
                GuestAddAdressEvent(context: context)
            );

          }else{
          }
        }

      },
    );
  }


  Widget checkoutAdresssAppBar(){
    return SingleChildScrollView(
      child: Container(
          width: width(context),
          color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(edit_address_status){
                            setState(() {
                              edit_address_status = false;
                            });
                          }else{
                            Navigator.of(context).pop();
                          }


                        },
                        child: Icon(
                          Icons.navigate_before,
                          color: mainColor,
                          size: 30,
                        ),
                      ),
                      customDescriptionText(
                          context: context,
                          textColor: mainColor,
                          text: "Address",
                          percentageOfHeight: .025),
                      StaticData.vistor_value == 'visitor' ?  SizedBox():      GestureDetector(
                        onTap: () {
                          setState(() {
                            edit_address_status = true;
                            StaticData.chosse_address_status = false;
                            frist_name = null;
                            last_name = null;
                            phone  = null;
                            street = null;
                            addres_city_name = null;
                            address_city_id = null;
                          });

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: mainColor)
                          ),
                          child: Icon(
                            Icons.add,
                            color: mainColor,
                            size: 25,
                          ),
                        ),
                      )  ,
                    ],
                  )
              ),
              Divider(color: mainColor,thickness: 1,)
            ],
          )
      ),
    );
  }


  Widget show_all_avaliable_addresses (){
    return FutureBuilder<List<AddressModel>>(
      future: all_addresses,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              return listViewOfAdressesCards(
                data: snapshot.data
              );
            } else {
              return Container(
                child: Text(
                    translator.translate("There is no saved addresses")),
              );
            }
          } else {
            return Container(
              child: Text(translator.translate("There is no saved addresses")),
            );
          }
        }

        // By default, show a loading spinner.
        return Center(
          child: SpinKitFadingCube(
            color: Theme.of(context).primaryColor,
            size: 30.0,
          ),

        );
      },
    );
  }

  Widget listViewOfAdressesCards({List<AddressModel> data}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(width * 0.02),
                child:  singlePaymentCard(
                        cardModel: data[index], index: data[index].id)
              );
            }));
  }


  Widget singlePaymentCard({AddressModel cardModel, int index}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl :TextDirection.ltr ,
      child: Container(
        width: width * .90,
        padding: EdgeInsets.all( width * .05),
        decoration: BoxDecoration(
            color: selected_address_id == index
                ? Colors.green.withOpacity(.2)  : small_grey ,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: blackColor,width: 2)
        ),

        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: InkWell(
              onTap: () {
                setState(() {
                  selected_address_id = cardModel.id;
                  selected_address_status = ! selected_address_status;
                  setState(() {
                    frist_name = cardModel.firstname;
                    last_name = cardModel.lastname;
                    phone = cardModel.telephone;
                    street = cardModel.street[0];
                    addres_city_name = cardModel.city;
                    address_city_id = cardModel.regionId;
                    shipmentAddressBloc.frist_name_controller.value = frist_name;
                    shipmentAddressBloc.last_name_controller.value = last_name;
                    shipmentAddressBloc.phone_controller.value = phone;
                    shipmentAddressBloc.street_controller.value = street;
                    sharedPreferenceManager.writeData(CachingKey.REGION_ID, cardModel.regionId.toString());
                    sharedPreferenceManager.writeData(CachingKey.REGION_EN,  cardModel.region.region);
                    sharedPreferenceManager.writeData(CachingKey.REGION_AR,  cardModel.region.region);

                  });
                });
              },
              child: Container(
                  child: selected_address_id == index
                      ?Icon(Icons.check_circle,color: greenColor,) : Icon(Icons.check_circle_outline,color: mainColor,)
              ),
            )
            ),
          Expanded(
            flex: 4,
            child:    Column(
              children: [
            Padding(
            padding: EdgeInsets.all( 5),
            child:  Align(
              child:   customDescriptionText(
                context: context,
                textColor: mainColor,
                maxLines: 2,
                text: "${cardModel.firstname} ${cardModel.lastname}",
              ),
              alignment:translator.activeLanguageCode == 'en' ? Alignment.centerLeft :  Alignment.centerRight,
            ),
          ),
                Padding(
                  padding: EdgeInsets.all( 5),
                  child:  Align(
                    child:    customDescriptionText(
                      context: context,
                      textColor: mainColor,
                      maxLines: 1,
                      text: cardModel.telephone,
                    ),
                    alignment:translator.activeLanguageCode == 'en' ? Alignment.centerLeft :  Alignment.centerRight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all( 5),
                  child:  Align(
                    child:  customDescriptionText(
                      context: context,
                      textColor: mainColor,
                      maxLines: 2,
                      text: "${cardModel.street[0]} , ${cardModel.region.region}" ,

                    ),
                    alignment:translator.activeLanguageCode == 'en' ? Alignment.centerLeft :  Alignment.centerRight,
                  ),
                ),
              ],
            ),
          ),
            Expanded(
                flex: 1,
                child:   InkWell(
                  onTap: (){
                    setState(() {
                      edit_address_status = true;
                      StaticData.chossed_address_id = cardModel.id;
                      print("chossed_address_id : ${StaticData.chossed_address_id}");
                      sharedPreferenceManager.writeData(CachingKey.CHOSSED_ADDRESS_ID, StaticData.chossed_address_id);

                      shipmentAddressBloc.add(AddressDetailsEvent(
                          address_id: cardModel.id
                      ));
                      StaticData.chosse_address_status = true;

                    });
                  },
                  child:  Icon(Icons.edit) ,
                ))


    ],
        )


      ),
    );
  }

}
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}


