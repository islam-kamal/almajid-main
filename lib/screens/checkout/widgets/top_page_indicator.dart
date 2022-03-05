import 'package:almajidoud/utils/file_export.dart';

topPageIndicator(
    {BuildContext context,
    isAddress: true,
    isPayment: false,
    isSummary: false ,
    double indicatorWidth : .33}) {
  return Container(
    width: width(context),
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customDescriptionText(
                  context: context,
                  text: "Address",
                  textColor: isAddress == true ? mainColor : greyColor),
              customDescriptionText(
                  context: context,
                  text:"Payment Method",
                  textColor: isPayment == true ? mainColor : old_price_color),
              customDescriptionText(
                  context: context,
                  text: "Summary",
                  textColor: isSummary == true ? mainColor : old_price_color),
            ],
          ),
        ),
        responsiveSizedBox(context: context, percentageOfHeight: .02),
        Container(
          height: 10,
          color: mainColor,
          width: width(context) *indicatorWidth,
        ),
      ],
    ),
  );
}
