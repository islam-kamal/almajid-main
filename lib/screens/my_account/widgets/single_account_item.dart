import 'package:almajidoud/utils/file_export.dart';

singleAccountItem({BuildContext context, String text, String iconPath,
  Function onTap, bool isContainMoreIcon: false, double percentageOfHeight }) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 2),
    width: width(context) * .8,
    child: GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  iconPath==null? Icon(Icons.location_on) :   Image.asset(
                    iconPath,
                    color: mainColor,
                    height: isLandscape(context)
                        ? 2 * height(context) * .03
                        : height(context) * .03,
                  ),
                  SizedBox(
                    width: width(context) * .02,
                  ),
                  customDescriptionText(
                      context: context, text: text, percentageOfHeight: percentageOfHeight??.022),
                ],
              ),
              isContainMoreIcon == true
                  ? Icon(Icons.arrow_forward_ios,
                      size: isLandscape(context)
                          ? 2 * height(context) * .025
                          : height(context) * .025)
                  : SizedBox()
            ],
          ),
          Divider(color: mainColor)
        ],
      ),
    ),
  );
}
