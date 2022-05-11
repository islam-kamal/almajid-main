import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/main.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/Payment/Constants.dart';
import 'package:almajidoud/screens/checkout/checkout_summary_screen.dart';
import 'package:almajidoud/screens/checkout/widgets/checkout_header.dart';
import 'package:almajidoud/screens/checkout/widgets/page_title.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_method_card.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_text_field.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_tilte.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'dart:io' show Platform;

class CheckoutPaymentScreen extends StatefulWidget {
  GuestShipmentAddressModel? guestShipmentAddressModel;
  CheckoutPaymentScreen({this.guestShipmentAddressModel});
  @override
  State<StatefulWidget> createState() {
    return CheckoutPaymentScreenState();
  }
}

class CheckoutPaymentScreenState extends State<CheckoutPaymentScreen>
    with TickerProviderStateMixin {
  var _currentIndex;

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
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var toRemove_apple_pay = [];
  @override
  void initState() {
    widget.guestShipmentAddressModel!.paymentMethods?.forEach((element) {
      if(element.code == "cashondelivery"){
        _currentIndex = element.code;
        sharedPreferenceManager.writeData(CachingKey.CHOSSED_PAYMENT_METHOD, _currentIndex);
        payment_method_name = element.title;
      }  else if(!StaticData.apple_pay_activation && element.code == "mestores_applepay" ){
        print("1");
        toRemove_apple_pay.add(element);
      }
    });
    widget.guestShipmentAddressModel!.paymentMethods?.removeWhere((e) => toRemove_apple_pay.contains(e));



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
            key: _drawerKey,
            backgroundColor: small_grey,
            body: Directionality(
              textDirection: MyApp.app_langauge == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                height: height(context),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: checkoutHeader(context: context,title: "Payment Method"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: topPageIndicator(
                            context: context,
                            isPayment: true,
                            indicatorWidth: .66),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: _currentIndex == 'aps_fort_cc' || _currentIndex == "tap"
                          ? Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.arrow_back_ios_outlined),
                                    onPressed: () {
                                      setState(() {
                                        _currentIndex = null;
                                      });
                                    }),
                                Container(
                                  child: customDescriptionText(
                                      context: context,
                                      textColor: mainColor,
                                      textAlign: TextAlign.start,
                                      text: "Credit/Debit Card",
                                      percentageOfHeight: .022,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          : pageTitle(
                              context: context, title: "Payment Method"),
                    ),

                    _currentIndex == 'aps_fort_cc' || _currentIndex == "tap"
                        ? Expanded(
                            flex: 8,
                            child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CreditCardWidget(
                                        glassmorphismConfig: useGlassMorphism
                                            ? Glassmorphism.defaultConfig()
                                            : null,
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
                                        backgroundImage: useBackgroundImage
                                            ? 'assets/card_bg.png'
                                            : null,
                                        isSwipeGestureEnabled: true,
                                        onCreditCardWidgetChange:
                                            (CreditCardBrand creditCardBrand) {},
                                        customCardTypeIcons: <
                                            CustomCardTypeIcon>[],
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
                                          labelText:
                                          translator.translate("Card Number"),
                                          hintText: 'XXXX XXXX XXXX XXXX',
                                          hintStyle: const TextStyle(
                                            color: greyColor,
                                          ),
                                          labelStyle:
                                          const TextStyle(color: mainColor),
                                          focusedBorder: border,
                                          alignLabelWithHint: true,
                                          enabledBorder: border,

                                          //  hintTextDirection: MyApp.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr ,
                                          contentPadding:
                                          new EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 10.0),
                                        ),
                                        expiryDateDecoration: InputDecoration(
                                          hintStyle:
                                          const TextStyle(color: greyColor),
                                          labelStyle:
                                          const TextStyle(color: mainColor),
                                          focusedBorder: border,
                                          enabledBorder: border,
                                          labelText: translator
                                              .translate("Expired Date"),
                                          hintText: 'XX/XX',
                                          hintTextDirection:
                                          MyApp.app_langauge == 'ar'
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                          contentPadding:
                                          new EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 10.0),
                                        ),
                                        cvvCodeDecoration: InputDecoration(
                                          hintStyle:
                                          const TextStyle(color: greyColor),
                                          labelStyle:
                                          const TextStyle(color: mainColor),
                                          focusedBorder: border,
                                          enabledBorder: border,
                                          labelText: translator.translate("CVV"),
                                          hintText: 'XXX',
                                          hintTextDirection:
                                          MyApp.app_langauge == 'ar'
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                          contentPadding:
                                          new EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 10.0),
                                        ),
                                        cardHolderDecoration: InputDecoration(
                                          hintStyle:
                                          const TextStyle(color: greyColor),
                                          labelStyle:
                                          const TextStyle(color: mainColor),
                                          focusedBorder: border,
                                          enabledBorder: border,
                                          labelText:
                                          translator.translate("Card Holder"),
                                          hintTextDirection:
                                          MyApp.app_langauge == 'ar'
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                          contentPadding:
                                          new EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 10.0),
                                        ),
                                        onCreditCardModelChange:
                                        onCreditCardModelChange,
                                      ),
                                    ],
                                  ),
                                )))
                        : Expanded(
                            flex: 8,
                            child: _currentIndex == 'aps_fort_cc' || _currentIndex == "tap"
                                ? Container()
                                : paymentMethodCard(
                                    context: context,
                                    paymentMethods: widget
                                        .guestShipmentAddressModel!
                                        .paymentMethods)),

                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          if (_currentIndex == "stc_pay" || _currentIndex == 'tamara_pay_by_instalments' ||
                              _currentIndex == 'cashondelivery' || _currentIndex == 'mestores_applepay') {
                            if(_currentIndex == 'mestores_applepay' && Platform.isAndroid){
                              errorDialog(
                                context: context,
                                text: translator.translate("Please select payment method") 
                              );
                            }else{
                              customAnimatedPushNavigation(
                                  context,
                                  CheckoutSummaryScreen(
                                    guestShipmentAddressModel:
                                    widget.guestShipmentAddressModel!,
                                    payment_method: payment_method_name,
                                  ));
                            }
                          
                          } else {
                            if (formKey.currentState!.validate()) {
                              StaticData.card_number = cardNumber.replaceAll(' ', '');
                              StaticData.card_holder_name = cardHolderName;
                              StaticData.card_security_code = cvvCode;
                              StaticData.expiry_date = expiryDate[3] +
                                  expiryDate[4] +
                                  expiryDate[0] +
                                  expiryDate[1];

                              customAnimatedPushNavigation(
                                  context,
                                  CheckoutSummaryScreen(
                                    guestShipmentAddressModel:
                                        widget.guestShipmentAddressModel!,
                                    payment_method: payment_method_name,
                                  )
                              );
                            } else {}
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(color: greenColor),
                            child: Center(
                                child: customDescriptionText(
                                    context: context,
                                    text: "Next",
                                    percentageOfHeight: .025,
                                    textColor: whiteColor)),
                            height: isLandscape(context)
                                ? 2 * height(context) * .065
                                : height(context) * .065),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  paymentMethodCard({BuildContext? context, List<PaymentMethods>? paymentMethods}) {
    var toRemove = [];
    var image;
    paymentMethods!.forEach((element) {
      if (element.code == "aps_fort_vault") {
        toRemove.add(element);
      }

      if (widget.guestShipmentAddressModel!.totals?.grandTotal < 99) {
        if (element.code == "tamara_pay_by_instalments" ||
            element.code == "tamara_pay_later") {
          toRemove.add(element);
        }
      }
      if (element.code == "mestores_applepay" && Platform.isAndroid) {
        toRemove.add(element);
      }
    });
    paymentMethods.removeWhere((e) => toRemove.contains(e));

    return Container(
      padding: EdgeInsets.all(width(context) * .05),
      decoration: BoxDecoration(
        color: small_grey,
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: paymentMethods.length,
        itemBuilder: (BuildContext context, int index) {
          switch (paymentMethods[index].code) {
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
              image = "tap.png";
              break;
            case 'mestores_applepay':
              image = "apple pay.png";
              break;
          }

          return Column(
            children: [
              Container(
                color: whiteColor,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: mainColor,
                    disabledColor: mainColor,
                  ),
                  child: RadioListTile<String>(
                    groupValue: _currentIndex,
                    contentPadding: const EdgeInsets.all(5.0),
                    dense: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          paymentMethods[index].code == 'tamara_pay_by_instalments'
                              ? translator.translate("Tamara")
                              : paymentMethods[index].code == 'mestores_applepay'
                                  ? translator.translate("Apple Pay")
                                  : "${paymentMethods[index].title == "Credit Card" ? translator.translate("Credit/Debit Card") : paymentMethods[index].title} ",
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: AlmajedFont.secondary_font_size,
                              color: mainColor,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                          child: Image.asset(
                            'assets/icons/$image',
                            width: width(context) * 0.08,
                          ),
                        ),
                      ],
                    ),
                    value: paymentMethods[index].code,
                    activeColor: mainColor,
                    onChanged: (val) {
                      setState(() {
                        sharedPreferenceManager.writeData(
                            CachingKey.CHOSSED_PAYMENT_METHOD,
                            paymentMethods[index].code);
                        payment_method_name = paymentMethods[index].title;
                        _currentIndex = val;
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 10,
              )
            ],
          );
        },
      ),
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
