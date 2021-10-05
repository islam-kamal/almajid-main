import 'package:almajidoud/utils/file_export.dart';

cancelButton({BuildContext context}) {
  return Container(
      width: width(context) * .8,
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: customDescriptionText(
              context: context,
              text: "Cancel",percentageOfHeight: .025,
              textColor: whiteColor)),
      height: isLandscape(context)
          ? 2 * height(context) * .065
          : height(context) * .065);
}
