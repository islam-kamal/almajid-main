import 'package:almajidoud/utils/file_export.dart';

topHeader({BuildContext context}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05,top: width(context) * .0),
    width: width(context),
    color: mainColor,
    height: isLandscape(context)
        ? 2 * height(context) * .07
        : height(context) * .07,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.navigate_before,
            color: whiteColor,
            size: 30,
          ),
        ),
      ],
    ),
  );
}
