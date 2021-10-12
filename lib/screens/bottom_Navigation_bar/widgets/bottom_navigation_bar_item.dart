import 'package:almajidoud/utils/file_export.dart';

customBottomBarButton(
    {BuildContext context,
    String icon,
    String title: "",
    Function onTap,
    bool isActive: false}) {
  return GestureDetector(
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          color: blackColor,
          depth: 50,
          shadowDarkColor: greyColor,
          lightSource: LightSource.bottom,
          boxShape: NeumorphicBoxShape.circle(),
        ),
        child: Container(
          width: isActive == true ? width(context) * .20 : width(context) * .13,
          height: isActive == true
              ? isLandscape(context)
                  ? 2 * height(context) * .11
                  : height(context) * .11
              : isLandscape(context)
                  ? 2 * height(context) * .09
                  : height(context) * .09,
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: whiteColor, width: .05),
              shape: BoxShape.circle),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  height: isActive == true ? 30 : 25,
                ),
                responsiveSizedBox(
                    context: context,
                    percentageOfHeight: isActive == true ? 0.005 : .0),
                isActive == true
                    ? customDescriptionText(
                        context: context,
                        text: title,
                        fontWeight: FontWeight.bold,
                        percentageOfHeight: .015,
                        textColor: whiteColor)
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
      onTap: onTap);
}
