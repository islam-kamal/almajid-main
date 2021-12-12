import 'package:almajidoud/utils/file_export.dart';

singleOrderSummaryItem(
    {BuildContext context,
    String title: "",
    String details: "",
    Function onTapChange,
    String image: "" , bool isAddress : false  , bool rValue}) {
  return Column(
    children: [
      Container(
        width: width(context) * .9,
        child: customDescriptionText(
            context: context,
            text: title,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
            percentageOfHeight: .022),
      ),
      Container(
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  isAddress == false?
                  Image.asset(
                    "assets/icons/credit cards.png",
                    height: 20,
                  ) : Icon(Icons.location_on , color: mainColor),

                  SizedBox(width: width(context)*.02,),
                 Container(width: width(context)*.55,
                     child:  customDescriptionText(
                   context: context,
                   textAlign: TextAlign.start,
                   maxLines: 2,
                   text: details ,
                   textColor: greyColor,)) ,
                ],
              ) ,
              Radio(value:rValue  , onChanged: (v){} , activeColor: Colors.blue) ,

            ],
          )),
      Container(
        width: width(context) * .9,
        child: GestureDetector(onTap: onTapChange,child:
        customDescriptionText(
            context: context,
            text: "Change",
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
            percentageOfHeight: .022),)
      ),
    ],
  );
}
