import 'package:almajidoud/utils/file_export.dart';

resetPasswordTextFields({BuildContext context, String hint}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    height: isLandscape(context)
        ? 2 * height(context) * .08
        : height(context) * .08,
    child: TextFormField(
      style: TextStyle(
          color: blackColor,
          fontSize: isLandscape(context)
              ? 2 * height(context) * .02
              : height(context) * .02),
      cursorColor: greyColor.withOpacity(.5),
      decoration: InputDecoration(
        hintText: translator.translate(hint),
        hintStyle: TextStyle(
            color: greyColor.withOpacity(1),
            fontWeight: FontWeight.bold,
            fontSize: isLandscape(context)
                ? 2 * height(context) * .018
                : height(context) * .018),
        filled: true,
        fillColor: whiteColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(color: blackColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(color: blackColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(color: blackColor)),
      ),
    ),
  );
}
