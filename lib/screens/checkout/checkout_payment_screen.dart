import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/checkout/widgets/checkout_header.dart';
import 'package:almajidoud/screens/checkout/widgets/next_button_in_payment.dart';
import 'package:almajidoud/screens/checkout/widgets/page_title.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_method_card.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_text_field.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_tilte.dart';
import 'package:almajidoud/screens/checkout/widgets/save_card_details.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/utils/file_export.dart';

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

  @override
  void initState() {
    _currentIndex = widget.guestShipmentAddressModel.paymentMethods[0].code;
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
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                paymentTitle(context: context , title: "Name Of Card"),
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                paymentTextFields(context: context , hint: "Name Of Card"),
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                paymentTitle(context: context , title: "Card Number"),
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                paymentTextFields(context: context , hint: "1234456767890"),
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                paymentTitle(context: context , title: "Expire Date"),
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                paymentTextFields(context: context  , hint: "05 - 2025"),
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                paymentTitle(context: context , title: "CVV"),
                responsiveSizedBox(context: context, percentageOfHeight: .01),
                paymentTextFields(context: context , hint: "*****"),
                responsiveSizedBox(context: context, percentageOfHeight: .05),
                nextButtonInPayment(context: context ,
                    isAddress: false,
                    pay_method: _currentIndex,
                    guestShipmentAddressModel: widget.guestShipmentAddressModel)
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
        width: width(context) * .9,
        height: width(context) * .3,
        decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(20)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: paymentMethods.length,
          itemBuilder:
              (BuildContext context, int index) {
            if(index == 0){
              sharedPreferenceManager.writeData(CachingKey.CHOSSED_PAYMENT_METHOD, paymentMethods[index].code);
            }
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                width: 150,
                height: 50,

                child: Theme(
                    data: Theme.of(context).copyWith(
                        unselectedWidgetColor: whiteColor,
                        disabledColor: whiteColor
                    ),
                    child:RadioListTile(
                      groupValue: _currentIndex,
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                          "${paymentMethods[index].title} ",
                          style: TextStyle(fontSize: AlmajedFont.secondary_font_size,color: whiteColor)
                      ),
                      value: paymentMethods[index].code,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        setState(() {
                          _currentIndex = val;
                          sharedPreferenceManager.writeData(CachingKey.CHOSSED_PAYMENT_METHOD, paymentMethods[index].code);
                        });



                      },
                    )),
              ),
            );
          },
        )


      /* Column(
      children: [
        responsiveSizedBox(context: context, percentageOfHeight: .005),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                singleSmallCard(context: context , title: "Cash" , image: "assets/icons/cash icon.png"),
                singleRadioButton(context: context)
              ],
            ),
            Row(
              children: [
                singleSmallCard(context: context , title: "Credit Card" , image:  "assets/icons/credit cards.png"),
                singleRadioButton(context: context , )
              ],
            )
          ],
        ),
        responsiveSizedBox(context: context, percentageOfHeight: .005),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                singleSmallCard(context: context , title: "Pay" , image: "assets/icons/apple pay.png" ),
                singleRadioButton(context: context)
              ],
            ),
           SizedBox()
          ],
        ),
        responsiveSizedBox(context: context, percentageOfHeight: .005),
      ],
    ),*/
    );
  }

}
