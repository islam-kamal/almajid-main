import 'package:almajidoud/screens/checkout/widgets/checkout_header.dart';
import 'package:almajidoud/screens/checkout/widgets/next_button_in_payment.dart';
import 'package:almajidoud/screens/checkout/widgets/page_title.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_method_card.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_text_field.dart';
import 'package:almajidoud/screens/checkout/widgets/payment_tilte.dart';
import 'package:almajidoud/screens/checkout/widgets/save_card_details.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/utils/file_export.dart';

class CheckoutPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            checkoutHeader(context: context),
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            topPageIndicator(context: context , isPayment: true  , indicatorWidth: .66),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            pageTitle(context: context, title: "Payment Method"),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            paymentMethodCard(context: context) ,
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
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            saveCardDetails(context: context),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            nextButtonInPayment(context: context , isAddress: false)
          ],
        ),
      ),
    );
  }
}
