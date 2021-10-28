import 'package:almajidoud/utils/file_export.dart';

quantityButton({BuildContext context}) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.only(
            right: width(context) * .05, left: width(context) * .05),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: mainColor, width: 2),
              borderRadius: BorderRadius.circular(8)),
          width: width(context) * .4,
          height: isLandscape(context)
              ? 2 * height(context) * .06
              : height(context) * .06,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.minimize,size: width(context)* 0.05,),
              customDescriptionText(
                  context: context, text: "1", percentageOfHeight: .03),
              Icon(Icons.add,size: width(context)* 0.05,),
            ],
          )),
        ),
      ),
    ],
  );
}
