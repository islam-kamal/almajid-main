import 'package:almajidoud/utils/file_export.dart';

singleProductSummaryCard({BuildContext context}) {
  return Container(
    width: width(context) * .4,

    child: Column(
      children: [

        Container(
          width: width(context) * .4,
          height: isLandscape(context)
              ? 2 * height(context) * .13
              : height(context) * .13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(
                      "https://perfumedeal24.com/wp-content/uploads/2021/02/perfumedeal-banner.jpeg"),
                  fit: BoxFit.cover)),
        ),
        responsiveSizedBox(context: context, percentageOfHeight: .01),
        Container(width: width(context) * .35,child: customDescriptionText(context: context ,
            text: "Lorim" , maxLines: 2, textAlign: TextAlign.start , percentageOfHeight: .015),) ,
        responsiveSizedBox(context: context, percentageOfHeight: .01),
        Container(padding: EdgeInsets.only(right: width(context)*.01 , left: width(context)*.01),
          width: width(context) * .35,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          customDescriptionText(context: context , textAlign: TextAlign.start , fontWeight: FontWeight.bold  , text: "\$ 600") ,
          Container(
            decoration: BoxDecoration(border: Border.all(color: mainColor)),
            width: width(context) * .08,height: isLandscape(context)
  ? 2 * height(context) * .04
      : height(context) * .04,

            child: Center(
            child:
            customDescriptionText(context: context , text: "1"),),)
        ],),)
      ],
    ),
  );
}
