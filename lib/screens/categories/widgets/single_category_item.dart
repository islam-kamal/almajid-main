import 'package:almajidoud/utils/file_export.dart';

singleCategoryItem(
    {BuildContext context,
    String imagePath,
    String text,
    Function onTapSingleCategory}) {
  return GestureDetector(
    onTap: onTapSingleCategory,
    child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imagePath, height: 30),
              SizedBox(
                width: width(context) * .02,
              ),
              customDescriptionText(context: context, text: text),
            ],
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 30,
          )
        ],
      ),
    ),
  );
}
