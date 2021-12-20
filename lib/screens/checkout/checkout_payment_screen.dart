import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/Payment/Constants.dart';
import 'package:almajidoud/screens/checkout/checkout_summary_screen.dart';
import 'package:almajidoud/screens/checkout/widgets/checkout_header.dart';
import 'package:almajidoud/screens/checkout/widgets/next_button_in_payment.dart';
import 'package:almajidoud/screens/checkout/widgets/page_title.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_method_card.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_text_field.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_tilte.dart';
import 'package:almajidoud/screens/checkout/widgets/save_card_details.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

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
  OutlineInputBorder border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _currentIndex = widget.guestShipmentAddressModel.paymentMethods[0].code;
    sharedPreferenceManager.writeData(CachingKey.CHOSSED_PAYMENT_METHOD, _currentIndex);
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
          body: SingleChildScrollView(
            child:  Column(
              children: [
                checkoutHeader(context: context),
                responsiveSizedBox(context: context, percentageOfHeight: .02),
                topPageIndicator(context: context , isPayment: true  , indicatorWidth: .66),
                responsiveSizedBox(context: context, percentageOfHeight: .02),
                pageTitle(context: context, title: "Payment Method"),
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                paymentMethodCard(
                    context: context,
                paymentMethods: widget.guestShipmentAddressModel.paymentMethods) ,
                _currentIndex == "stc_pay" ? Container() :     Column(
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
                        CustomCardTypeIcon(
                          cardType: CardType.mastercard,
                          cardImage: Image.asset(
                            'assets/mastercard.png',
                            height: 48,
                            width: 48,
                          ),
                        ),
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
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        hintStyle: const TextStyle(color: greyColor),
                        labelStyle: const TextStyle(color: mainColor),
                        focusedBorder: border,
                        enabledBorder: border,
                      ),
                      expiryDateDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: greyColor),
                        labelStyle: const TextStyle(color: mainColor),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: greyColor),
                        labelStyle: const TextStyle(color: mainColor),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: greyColor),
                        labelStyle: const TextStyle(color: mainColor),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'Card Holder',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                  ],
                ),



                responsiveSizedBox(context: context, percentageOfHeight:_currentIndex == "stc_pay" ? 0.3 : .05),
                GestureDetector(
                  onTap: () {
                  if(_currentIndex == "stc_pay") {
                      customAnimatedPushNavigation(context , CheckoutSummaryScreen(
                        guestShipmentAddressModel: widget.guestShipmentAddressModel,
                        payment_method: _currentIndex,
                      ));
                    }else{
                    if (formKey.currentState.validate()) {
                      print('valid!');
                      StaticData.card_number = cardNumber.replaceAll(' ', '');
                      StaticData.card_holder_name = cardHolderName;
                      StaticData.card_security_code = cvvCode;
                      StaticData.expiry_date = expiryDate[3] + expiryDate[4] + expiryDate[0] + expiryDate[1];
                      customAnimatedPushNavigation(context , CheckoutSummaryScreen(
                        guestShipmentAddressModel: widget.guestShipmentAddressModel,
                        payment_method: _currentIndex,
                      )
                      );

                    }else{
                      print('invalid!');
                    }

                    }

                  },
                  child: Container(
                      width: width(context) * .8,
                      decoration: BoxDecoration(
                          color: mainColor, borderRadius: BorderRadius.circular(8)
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
  /*              nextButtonInPayment(
                    context: context ,
                    isAddress: false,
                    pay_method: _currentIndex,
                    guestShipmentAddressModel: widget.guestShipmentAddressModel)*/
              ],
            ),


          ),
        ),
      ),
    );
  }

  paymentMethodCard({BuildContext context ,  List<PaymentMethods> paymentMethods}) {

    return Container(
        padding: EdgeInsets.only(
            right: width(context) * .05, left: width(context) * .05),
        width: width(context) * .95,
        height: width(context) * .5,
        decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(20)),
        child: GridView.builder(
          //scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: paymentMethods.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
           childAspectRatio: 16/9,
          ),
          itemBuilder:
              (BuildContext context, int index) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                child: Theme(
                    data: Theme.of(context).copyWith(
                        unselectedWidgetColor: whiteColor,
                        disabledColor: whiteColor
                    ),
                    child:RadioListTile(
                      groupValue: _currentIndex,
                      contentPadding: const EdgeInsets.all(5.0),

                      title: Container(
                decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15)
                ),
                child:Row(
                        children: [
                          Expanded(
                            flex: 7,
                              child:  Text(
                              "${paymentMethods[index].title} ",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: AlmajedFont.secondary_font_size,color: mainColor,fontWeight: FontWeight.w300
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                ) ),

                      value: paymentMethods[index].code,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        setState(() {
                          sharedPreferenceManager.writeData(CachingKey.CHOSSED_PAYMENT_METHOD, paymentMethods[index].code);

                          _currentIndex = val;
                          print("_currentIndex : ${_currentIndex}");
                        });



                      },
                    )),
              ),
            );
          },
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
