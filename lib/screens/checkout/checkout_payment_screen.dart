import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/main.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/Payment/Constants.dart';
import 'package:almajidoud/screens/checkout/checkout_summary_screen.dart';
import 'package:almajidoud/screens/checkout/widgets/checkout_header.dart';
import 'package:almajidoud/screens/checkout/widgets/page_title.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_method_card.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_text_field.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_tilte.dart';
import 'package:almajidoud/screens/checkout/widgets/save_card_details.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'dart:io' show Platform;
class CheckoutPaymentScreen extends StatefulWidget{
  GuestShipmentAddressModel guestShipmentAddressModel;
  CheckoutPaymentScreen({this.guestShipmentAddressModel});
  @override
  State<StatefulWidget> createState() {
  return CheckoutPaymentScreenState();
  }

}


class CheckoutPaymentScreenState extends State<CheckoutPaymentScreen>with TickerProviderStateMixin {
  var _currentIndex ;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  var payment_method_name;
  OutlineInputBorder border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _currentIndex = widget.guestShipmentAddressModel.paymentMethods[0].code;
    sharedPreferenceManager.writeData(CachingKey.CHOSSED_PAYMENT_METHOD, _currentIndex);
    payment_method_name = widget.guestShipmentAddressModel.paymentMethods[0].title;
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
        key:_drawerKey,
          backgroundColor: whiteColor,
          body: Directionality(
            textDirection: MyApp.app_langauge =='ar' ? TextDirection.rtl :TextDirection.ltr,
            child: SingleChildScrollView(
            child:  Column(
              children: [
                checkoutHeader(context: context),
                responsiveSizedBox(context: context, percentageOfHeight: .02),
                topPageIndicator(context: context , isPayment: true  , indicatorWidth: .66),
                responsiveSizedBox(context: context, percentageOfHeight: .02),
                pageTitle(context: context, title: "Payment Method"),
                responsiveSizedBox(context: context, percentageOfHeight: .02),
                paymentMethodCard(
                    context: context,
                    paymentMethods: widget.guestShipmentAddressModel.paymentMethods
                ),
                _currentIndex == "stc_pay" ||  _currentIndex == 'tamara_pay_by_instalments'
                    ||   _currentIndex ==  'cashondelivery' || _currentIndex == 'mestores_applepay' ?
                Container() :    Directionality(
                  textDirection: TextDirection.ltr,
                  child:  Column(
                  children: [
                    CreditCardWidget(
                      glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      height: width(context) * 0.5,
                      obscureCardNumber: false,
                      obscureCardCvv: true,
                      isHolderNameVisible: false,
                      cardBgColor: greyColor,
                      backgroundImage:
                      useBackgroundImage ? 'assets/card_bg.png' : null,
                      isSwipeGestureEnabled: true,
                      onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},

                      customCardTypeIcons: <CustomCardTypeIcon>[
                      ],
                    ),
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      themeColor: Colors.blue,
                      textColor: mainColor,
                      cardNumberDecoration: InputDecoration(
                        labelText: translator.translate("Card Number"),
                        hintText: 'XXXX XXXX XXXX XXXX',
                        hintStyle: const TextStyle(color: greyColor,),
                        labelStyle: const TextStyle(color: mainColor),
                        focusedBorder: border,
                        alignLabelWithHint: true,
                        enabledBorder: border,

                      //  hintTextDirection: MyApp.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr ,
                        contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                      ),
                      expiryDateDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: greyColor),
                        labelStyle: const TextStyle(color: mainColor),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: translator.translate("Expired Date"),
                        hintText: 'XX/XX',
                        hintTextDirection: MyApp.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr ,
                        contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                      ),
                      cvvCodeDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: greyColor),
                        labelStyle: const TextStyle(color: mainColor),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: translator.translate("CVV"),
                        hintText: 'XXX',
                        hintTextDirection: MyApp.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr ,
                        contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                      ),
                      cardHolderDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: greyColor),
                        labelStyle: const TextStyle(color: mainColor),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: translator.translate("Card Holder"),
                        hintTextDirection: MyApp.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr ,
                        contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                  ],
                )),



                responsiveSizedBox(context: context, percentageOfHeight: _currentIndex == "stc_pay" ||
                    _currentIndex == 'tamara_pay_by_instalments'
                    ||   _currentIndex ==  'cashondelivery'
                    || _currentIndex == 'mestores_applepay'? 0.1: .05),
                GestureDetector(
                  onTap: () {
                  if(_currentIndex == "stc_pay" || _currentIndex == 'tamara_pay_by_instalments'
                      ||   _currentIndex ==  'cashondelivery'  || _currentIndex == 'mestores_applepay') {
                      customAnimatedPushNavigation(context , CheckoutSummaryScreen(
                        guestShipmentAddressModel: widget.guestShipmentAddressModel,
                        payment_method: payment_method_name,
                      ));
                    }else{
                    if (formKey.currentState.validate()) {


                      StaticData.card_number = cardNumber.replaceAll(' ', '');
                      StaticData.card_holder_name = cardHolderName;
                      StaticData.card_security_code = cvvCode;
                      StaticData.expiry_date = expiryDate[3] + expiryDate[4] + expiryDate[0] + expiryDate[1];

                      customAnimatedPushNavigation(context , CheckoutSummaryScreen(
                        guestShipmentAddressModel: widget.guestShipmentAddressModel,
                        payment_method: payment_method_name,
                      )
                      );

                    }else{
                    }
                    }

                  },
                  child: Container(
                      width: width(context) * .8,
                      decoration: BoxDecoration(
                          color: greenColor, borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                          child: customDescriptionText(
                              context: context,
                              text: "Next",
                              percentageOfHeight: .025,
                              textColor: whiteColor
                          )
                      ),
                      height: isLandscape(context)
                          ? 2 * height(context) * .065
                          : height(context) * .065),
                ),

              ],
            ),


          ),
        ) ),
      ),
    );
  }

  paymentMethodCard({BuildContext context ,  List<PaymentMethods> paymentMethods}) {
    var toRemove = [];
    var image;
    paymentMethods.forEach((element) {
      if(element.code =="aps_fort_vault" ){
        toRemove.add(element);
      }

      if(widget.guestShipmentAddressModel.totals.grandTotal < 99){
        if(element.code =="tamara_pay_by_instalments" || element.code == "tamara_pay_later"){
          toRemove.add(element);
        }
      }
      if(element.code == "mestores_applepay" && Platform.isAndroid){
        toRemove.add(element);
      }
    });
    paymentMethods.removeWhere( (e) => toRemove.contains(e));


    return Container(
        padding: EdgeInsets.only(
            right: width(context) * .05, left: width(context) * .05),
        width: width(context) * .95,
        height:    _currentIndex == "stc_pay" ||  _currentIndex == 'tamara_pay_by_instalments'
            ||   _currentIndex ==  'cashondelivery' || _currentIndex == 'mestores_applepay' ? width(context) * 0.7  :  width(context) * .5,
        decoration: BoxDecoration(
            color: small_grey,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: GridView.builder(
            //scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: paymentMethods.length,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 20/9,
            ),
            itemBuilder: (BuildContext context, int index) {

                switch(paymentMethods[index].code){
                  case 'stc_pay':
                    image = "stc pay.png";
                    break;
                  case 'tamara_pay_by_instalments':
                    image = "tamara.png";
                    break;
                  case 'cashondelivery':
                    image = "cash icon.png";
                    break;
                  case 'aps_fort_cc':
                    image = "credit card.png";
                    break;
                  case 'tap':
                    image = "credit card.png";
                    break;
                  case 'mestores_applepay' :
                    image = "apple pay.png";
                    break;
                }

              return  Container(
                  child: Theme(
                      data: Theme.of(context).copyWith(
                          unselectedWidgetColor: mainColor,
                          disabledColor: mainColor,
                      ),
                      child:RadioListTile(
                        groupValue: _currentIndex,
                        contentPadding: const EdgeInsets.all(5.0),
                        dense: true,
                        title: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child:Row(
                              children: [
                                Row(
                                    children: [
                                      Padding(padding: EdgeInsets.all(3),
                                      child: Image.asset('assets/icons/$image',
                                        width: width(context) * 0.05,
                                      ),
                                      ),
                                   Container(
                                    width: width(context) * 0.15,
                                     child:    Text(
                                    paymentMethods[index].code == 'tamara_pay_by_instalments'? translator.translate("Tamara") :  paymentMethods[index].code == 'mestores_applepay'? translator.translate("Apple Pay") :  "${paymentMethods[index].title} ",
                                       maxLines: 2,
                                       style: TextStyle(
                                           fontSize: AlmajedFont.secondary_font_size,color: mainColor,fontWeight: FontWeight.w300
                                       ),
                                       textAlign: TextAlign.center,
                                     ),
                                   )
                                    ],

                                ),

                              ],
                            ) ),

                        value: paymentMethods[index].code,
                        activeColor: mainColor,
                        onChanged: (val) {
                          setState(() {
                            sharedPreferenceManager.writeData(CachingKey.CHOSSED_PAYMENT_METHOD, paymentMethods[index].code);
                            payment_method_name =   paymentMethods[index].title;

                            _currentIndex = val;
                          });



                        },
                      )),

              );
            },
          ),
        )


    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

}
