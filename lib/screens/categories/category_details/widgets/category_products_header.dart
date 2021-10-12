import 'package:almajidoud/utils/file_export.dart';

categoryProductsHeader({BuildContext context, String name}) {
  return Container(
    padding: EdgeInsets.only(top: height(context) * .05),
    alignment: Alignment.topCenter,
    child: Center(
      child: customDescriptionText(
          context: context,
          text: "${name}",
          textColor: whiteColor,
          textAlign: TextAlign.center,
          percentageOfHeight: .025),
    ),
    color: mainColor,
    width: width(context),
    height: isLandscape(context)
        ? 2 * height(context) * .08
        : height(context) * .08,
  );
}
