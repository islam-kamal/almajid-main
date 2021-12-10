import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/utils/file_export.dart';

singleSmallCard({BuildContext context, String image :"", String title}) {
  return Container(
    height: isLandscape(context)
        ? 2 * height(context) * .05
        : height(context) * .05,
    width: width(context) * .25,
    decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
        image,
          height: 23,
        ),
        SizedBox(width: width(context) * .01),
        customDescriptionText(context: context, text: title , percentageOfHeight: .015)
      ],
    ),
  );
}

singleRadioButton({BuildContext context, bool radioValue: false}) {
  return  Radio(value:radioValue , onChanged: (v){} , activeColor: Colors.blue) ;
}
