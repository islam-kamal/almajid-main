import 'package:almajidoud/utils/file_export.dart';

writeReviewButton({BuildContext context}){
  return Container(
      width: width(context) * .9,
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(8)),
      child:  Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.rate_review_outlined, color: mainColor),
          SizedBox(width: 10 ) ,

          customDescriptionText(
              context: context,
              text: "Write Review ",
              percentageOfHeight: .025,

              textColor: mainColor) ,


        ],),
      height: isLandscape(context)
          ? 2 * height(context) * .065
          : height(context) * .065) ;
}