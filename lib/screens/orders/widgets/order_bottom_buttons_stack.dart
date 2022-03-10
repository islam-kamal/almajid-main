import 'package:almajidoud/Repository/OrderRepo/order_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/orders/widgets/orders_details_header.dart';

orderBottomButtonsStack({BuildContext context ,var total_payment, var currency, var order_id}) {
  return Container(
    height: isLandscape(context) ? 2 * height(context) : height(context),
    child: Column(
      children: [
        orderDetailsHeader(context: context),
        responsiveSizedBox(context: context, percentageOfHeight: .003),
        Container(
          height: isLandscape(context)
              ? 2 * height(context) * .35
              : height(context) * .35,
          color: whiteColor,
        ),
        responsiveSizedBox(context: context, percentageOfHeight: .447),
        Row(
          children: [
            Container(
              height: isLandscape(context)
                  ? 2 * height(context) * .08
                  : height(context) * .08,
              width: width(context) * .6,
              decoration: BoxDecoration(color: whiteColor),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customDescriptionText(
                        context: context,
                        percentageOfHeight: .02,
                        textColor: mainColor,
                        text: "${translator.translate("Total to pay")} "),
                    SizedBox(
                      height: 5,
                    ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       customDescriptionText(
                           context: context,
                           percentageOfHeight: .025,
                           textColor: mainColor,
                           text: " ${total_payment??''} ",
                           fontWeight: FontWeight.bold),
                       customDescriptionText(
                           context: context,
                           percentageOfHeight: .02,
                           textColor: mainColor,
                           text: " ${MyApp.country_currency??''}",
                           fontWeight: FontWeight.bold)
                     ],
                   )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                orderRepository.re_order(
                  context: context,
                  order_id:order_id
                );
              },
              child: Container(
                height: isLandscape(context)
                    ? 2 * height(context) * .08
                    : height(context) * .08,
                width: width(context) * .4,
                decoration: BoxDecoration(color: greenColor),
                child: Center(
                  child: customDescriptionText(
                      context: context,
                      percentageOfHeight: .02,
                      textColor: whiteColor,
                      text: translator.translate("Re-Order")),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}
