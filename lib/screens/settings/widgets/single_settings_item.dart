import 'package:almajidoud/utils/file_export.dart';

singleSettingsItem(
    {BuildContext context,
    bool switchValue,
    Function onChangeSwitch,
    String text,
    bool isSwitch: true,
    Function onTapArrow}) {
  return Container(
    padding: EdgeInsets.only(
        right:isSwitch == true ? width(context) * .05 :  width(context) * .05, left: isSwitch == true ? width(context) * .05 :  width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customDescriptionText(
            context: context, text: text, percentageOfHeight: .023),
        isSwitch == true
            ? Switch(

                value: switchValue,
                onChanged: (value) {
                  onChangeSwitch;
                })
            : GestureDetector(
                onTap: onTapArrow,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: mainColor,size: isLandscape(context)
                    ?2*height(context)*.025:height(context)*.025,
                ),
              )
      ],
    ),
  );
}
