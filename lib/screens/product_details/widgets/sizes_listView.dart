import 'package:almajidoud/utils/file_export.dart';

sizesListView({BuildContext? context}) {
  var selected_size =0 ;
  return Container(
    width: width(context),
    height: isLandscape(context)
        ? 2 * height(context) * .07
        : height(context) * .07,
    child: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){

            },
            child: Row(
              children: [
                SizedBox(width: width(context) * .02),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: selected_size == index ?mainColor : greyColor, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  width: width(context) * .2,
                  child: Center(
                    child: customDescriptionText(
                        context: context, text: "90 ml", percentageOfHeight: .02),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: 3,
        scrollDirection: Axis.horizontal),
  );
}
