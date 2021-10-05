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
          height: 10,
          color: mainColor,
          width: width(context) *indicatorWidth,
        ),
        responsiveSizedBox(context: context, percentageOfHeight: .02),
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
                  text: "Payment",
                  textColor: isPayment == true ? mainColor : greyColor),
              customDescriptionText(
                  context: context,
                  text: "Summary",
                  textColor: isSummary == true ? mainColor : greyColor),
            ],
          ),
        )
      ],
    ),
  );
}
