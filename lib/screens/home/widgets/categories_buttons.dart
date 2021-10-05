import 'package:almajidoud/utils/file_export.dart';

categoriesButtons({BuildContext context}){
  return

        Container(width: width(context),height: isLandscape(context) ?2*height(context)*.07:height(context)*.07,
          child: ListView.builder(itemBuilder: (context , index  ){
            return Row(
              children: [
                SizedBox(width: width(context)*.01) ,
                Container(
                  width: width(context)*.33,
                  color: index == 0 ?  mainColor : whiteColor , child: Center(child: customDescriptionText(context:
                context , text: "Perfumes" , textColor:  index == 0 ? whiteColor : mainColor
                    , percentageOfHeight: .02),),),
              ],
            );

  } , itemCount: 10 , scrollDirection: Axis.horizontal),
        );
}