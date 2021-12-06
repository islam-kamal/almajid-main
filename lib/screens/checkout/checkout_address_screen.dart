import 'package:almajidoud/Model/ShipmentAddressModel/client/saved_addresses_model.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
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

class CheckoutAddressScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckoutAddressScreenState();
  }

}
class CheckoutAddressScreenState extends State<CheckoutAddressScreen> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();

  AnimationController _loginButtonController;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }

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
            body: SingleChildScrollView(
                child: BlocListener<ShipmentAddressBloc,AppState>(
                  bloc: shipmentAddressBloc,
                  listener: (context,state){
                    if (state is Loading) {
                      print("Loading");
                      _playAnimation();
                    } else if (state is ErrorLoading) {
                      print("ErrorLoading");
                      _stopAnimation();
                      if(StaticData.new_address_status == true ){
                        var data = state.model as SavedAddressesModel;
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

                    } else if (state is Done) {
                      print("done");
                      _stopAnimation();
                      if(StaticData.new_address_status == true ){
                        errorDialog(
                          context: context,
                          text: translator.translate("new address added sucessfuly"),
                          function: (){
                            StaticData.new_address_status = false;
                            customAnimatedPushNavigation(context,CheckoutAddressScreen());
                          }
                        );

                      }else{
                        var data = state.model as GuestShipmentAddressModel;
                        customAnimatedPushNavigation(context,CheckoutPaymentScreen(
                          guestShipmentAddressModel: data,
                        ));
                      }

                    }
                  },
                  child: Column(
                    children: [
                      checkoutHeader(context: context),
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      topPageIndicator(context: context),
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .04),
                      //   addressCard(context: context),
                      StaticData.vistor_value == 'visitor' ? Container() :
                      StaticData.saved_addresses_count == 0? Container()
                          : StaticData.new_address_status == true ? Container() : CustomSavedAddressesWidget(),
                      Container(
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8)),
                          width: width(context) * .9,
                          child: Column(
                            children: [

                              StaticData.saved_addresses_count == 0    ?  Column(
                                children: [
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  CustomCitiesWidget(),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),

                                  paymentTitle(context: context, title: "First Name"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  frist_name_addressTextFields(
                                      context: context, hint: "Frist Name"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),

                                  paymentTitle(context: context, title: "Last Name"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  last_name_addressTextFields(
                                      context: context, hint: "Last Name"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),

                                  paymentTitle(context: context, title: "Email"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  email_addressTextFields(
                                      context: context, hint: "Email"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),

                                  paymentTitle(context: context, title: "Phone"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  phone_addressTextFields(
                                      context: context, hint: "Phone"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),

                                  paymentTitle(context: context, title: "Street"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  street_addressTextFields(
                                      context: context, hint: "Street"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                ],
                              )
                                  :  StaticData.new_address_status == true ? Column(
                                children: [
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  CustomCitiesWidget(),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),

                                  paymentTitle(context: context, title: "First Name"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  frist_name_addressTextFields(
                                      context: context, hint: "Frist Name"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),

                                  paymentTitle(context: context, title: "Last Name"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  last_name_addressTextFields(
                                      context: context, hint: "Last Name"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),

                                  paymentTitle(context: context, title: "Email"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  email_addressTextFields(
                                      context: context, hint: "Email"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),

                                  paymentTitle(context: context, title: "Phone"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  phone_addressTextFields(
                                      context: context, hint: "Phone"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),

                                  paymentTitle(context: context, title: "Street"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                  street_addressTextFields(
                                      context: context, hint: "Street"),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .01),
                                ],
                              ) :Container()


                            ],
                          )),


                      responsiveSizedBox(
                          context: context,
                          percentageOfHeight: (StaticData.saved_addresses_count !=0 && StaticData.new_address_status == false)? 0.5:.05),
                      //  nextButton(context: context)
                      addressNextButton(context: context)
                    ],
                  ),
                )
            ),
          ),
        ));
  }

  frist_name_addressTextFields({BuildContext context, String hint}) {
    return StreamBuilder<String>(
      stream: shipmentAddressBloc.frist_name,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(
              right: width(context) * .05, left: width(context) * .05),
          height: isLandscape(context)
              ? 2 * height(context) * .065
              : height(context) * .065,
          child: TextFormField(
            style: TextStyle(
                color: whiteColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .02
                    : height(context) * .02),
            cursorColor: greyColor.withOpacity(.5),
            decoration: InputDecoration(
              hintText: translator.translate(hint),
              hintStyle: TextStyle(
                  color: greyColor.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                  fontSize: isLandscape(context)
                      ? 2 * height(context) * .018
                      : height(context) * .018),
              filled: true,
              fillColor: greyColor.withOpacity(.5),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
            ),
            onChanged: shipmentAddressBloc.frist_name_change,
          ),
        );
      },
    );
  }

  last_name_addressTextFields({BuildContext context, String hint}) {
    return StreamBuilder<String>(
      stream: shipmentAddressBloc.last_name,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(
              right: width(context) * .05, left: width(context) * .05),
          height: isLandscape(context)
              ? 2 * height(context) * .065
              : height(context) * .065,
          child: TextFormField(
            style: TextStyle(
                color: whiteColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .02
                    : height(context) * .02),
            cursorColor: greyColor.withOpacity(.5),
            decoration: InputDecoration(
              hintText: translator.translate(hint),
              hintStyle: TextStyle(
                  color: greyColor.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                  fontSize: isLandscape(context)
                      ? 2 * height(context) * .018
                      : height(context) * .018),
              filled: true,
              fillColor: greyColor.withOpacity(.5),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
            ),
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
          padding: EdgeInsets.only(
              right: width(context) * .05, left: width(context) * .05),
          height: isLandscape(context)
              ? 2 * height(context) * .065
              : height(context) * .065,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: whiteColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .02
                    : height(context) * .02),
            cursorColor: greyColor.withOpacity(.5),
            decoration: InputDecoration(
              hintText: translator.translate(hint),
              hintStyle: TextStyle(
                  color: greyColor.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                  fontSize: isLandscape(context)
                      ? 2 * height(context) * .018
                      : height(context) * .018),
              filled: true,
              fillColor: greyColor.withOpacity(.5),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
            ),
            onChanged: shipmentAddressBloc.email_change,
          ),
        );
      },
    );
  }

  phone_addressTextFields({BuildContext context, String hint}) {
    return StreamBuilder<String>(
      stream: shipmentAddressBloc.phone,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(
              right: width(context) * .05, left: width(context) * .05),
          height: isLandscape(context)
              ? 2 * height(context) * .065
              : height(context) * .065,
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
                color: whiteColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .02
                    : height(context) * .02),
            cursorColor: greyColor.withOpacity(.5),
            decoration: InputDecoration(
              hintText: translator.translate(hint),
              hintStyle: TextStyle(
                  color: greyColor.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                  fontSize: isLandscape(context)
                      ? 2 * height(context) * .018
                      : height(context) * .018),
              filled: true,
              fillColor: greyColor.withOpacity(.5),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
            ),
            onChanged: shipmentAddressBloc.phone_change,
          ),
        );
      },
    );
  }

  street_addressTextFields({BuildContext context, String hint}) {
    return StreamBuilder<String>(
      stream: shipmentAddressBloc.street,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(
              right: width(context) * .05, left: width(context) * .05),
          height: isLandscape(context)
              ? 2 * height(context) * .065
              : height(context) * .065,
          child: TextFormField(
            keyboardType: TextInputType.streetAddress,
            style: TextStyle(
                color: whiteColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .02
                    : height(context) * .02),
            cursorColor: greyColor.withOpacity(.5),
            decoration: InputDecoration(
              hintText: translator.translate(hint),
              hintStyle: TextStyle(
                  color: greyColor.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                  fontSize: isLandscape(context)
                      ? 2 * height(context) * .018
                      : height(context) * .018),
              filled: true,
              fillColor: greyColor.withOpacity(.5),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: greyColor)),
            ),
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
      btn_width: width(context) * .7,
      onTap: () {
          shipmentAddressBloc.add(
              StaticData.new_address_status == true ? AddNewAdressEvent(context: context) :   GuestAddAdressEvent(context: context)
          );
      },
    );
  }
}

