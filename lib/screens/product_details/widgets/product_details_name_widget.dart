import 'package:almajidoud/custom_widgets/cart_badge.dart';
import 'package:almajidoud/utils/file_export.dart';

productDetailsNameWidget({BuildContext context , String product_name}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              child: Icon(Icons.arrow_back_ios),
              onTap: (){
              Navigator.pop(context);
              },
            ),
            Container(
              width: width(context) * .5,
              child: customDescriptionText(
                  context: context,
                  text: product_name??"",
                  percentageOfHeight: .025),
            )
          ],
        ),
        CartBadge(iconColor: Colors.black,)
      ],
    ),
  );
}
