import 'package:almajidoud/screens/checkout/widgets/address_card.dart';
import 'package:almajidoud/screens/checkout/widgets/checkout_header.dart';
import 'package:almajidoud/screens/checkout/widgets/next_button.dart';
import 'package:almajidoud/screens/checkout/widgets/page_title.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/utils/file_export.dart';

class CheckoutAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            checkoutHeader(context: context),
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            topPageIndicator(context: context),
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            pageTitle(context: context, title: "Address"),
            responsiveSizedBox(context: context, percentageOfHeight: .1),
            addressCard(context: context),
            responsiveSizedBox(context: context, percentageOfHeight: .2),
            nextButton(context: context)
          ],
        ),
      ),
    );
  }
}
