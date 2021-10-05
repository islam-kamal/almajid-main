import 'package:almajidoud/screens/checkout/widgets/checkout_header.dart';
import 'package:almajidoud/screens/checkout/widgets/done_button.dart';
import 'package:almajidoud/screens/checkout/widgets/order_summary_widget.dart';
import 'package:almajidoud/screens/checkout/widgets/single_order_summary_item.dart';
import 'package:almajidoud/screens/checkout/widgets/single_product_summary_card.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/utils/file_export.dart';
class CheckoutSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            checkoutHeader(context: context),
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            topPageIndicator(
                context: context,
                isPayment: true,
                isAddress: true,
                indicatorWidth: 1,
                isSummary: true),
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            Container(
              width: width(context),
              height: isLandscape(context)
                  ? 2 * height(context) * .23
                  : height(context) * .23,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      singleProductSummaryCard(context: context),
                      SizedBox(width: width(context) * .05)
                    ],
                  );
                },
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            Container(
                width: width(context) * .9,
                child: Divider(
                  color: greyColor,
                )),
            singleOrderSummaryItem(
                context: context,
                isAddress: true,
                title: "Address",
                details: "Lorim"),
            Container(
                width: width(context) * .9,
                child: Divider(
                  color: greyColor,
                )),
            singleOrderSummaryItem(
                context: context,
                title: "Payment",
                details: "Credit Card \n *******"),
            Container(
                width: width(context) * .9,
                child: Divider(
                  color: greyColor,
                )),
            orderSummaryWidget(context: context) ,
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            doneButton(context: context)

          ],
        ),
      ),
    );
  }
}
