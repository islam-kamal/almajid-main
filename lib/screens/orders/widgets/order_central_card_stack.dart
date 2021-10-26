import 'package:almajidoud/utils/file_export.dart';

orderCentralCardStack({BuildContext context}){
  return  Container(padding: EdgeInsets.only(top:  isLandscape(context) ? 2*height(context)*.12:height(context)*.12),
    height:  isLandscape(context) ? 2*height(context) :height(context),child: Center(child: Container(
      padding: EdgeInsets.only(right: width(context)*.05, left: width(context)*.05),
      child: Column(children: [
        responsiveSizedBox(context: context , percentageOfHeight: .01) ,
        Row(children: [
          customDescriptionText(context: context , text: "ITEMS" , percentageOfHeight: .026, textColor:greyColor) ,
        ],) ,
        responsiveSizedBox(context: context , percentageOfHeight: .005) ,

        Container(height: isLandscape(context) ? 2*height(context)*.2 :height(context)*.2,child:
        ListView.builder(padding: EdgeInsets.zero,
            itemBuilder: (context , index){
              return  Row(mainAxisAlignment:MainAxisAlignment.spaceBetween , children: [


                Row(children: [
                  Container(width: width(context)*.1, height: isLandscape(context) ? 2*height(context)*.08: height(context)*.08
                    ,decoration: BoxDecoration(image: DecorationImage(image:
                    NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0Og0-LY1uOs7Z3I_sBLafG8F2IbFwRVprrg&usqp=CAU") ,
                        fit: BoxFit.cover)),),
                  SizedBox(width: 5,) ,
                  customDescriptionText(context: context , text: "Product name" , percentageOfHeight: .023) ,
                  customDescriptionText(context: context , text: " *  ${2} " , percentageOfHeight: .023) ,
                ],)  ,
                customDescriptionText(context: context , text: "\$600" , percentageOfHeight: .025 , fontWeight: FontWeight.bold)

              ],) ;
            } , itemCount: 2),) ,
        responsiveSizedBox(context: context , percentageOfHeight: .01) ,

        Container(width: width(context)*.8,child: Divider(thickness: 2,),) ,
        responsiveSizedBox(context: context , percentageOfHeight: .01) ,

        Row(children: [
          customDescriptionText(context: context , text: "Delivered to :" , percentageOfHeight: .02 , textColor:greyColor) ,
        ],) ,
        responsiveSizedBox(context: context , percentageOfHeight: .005) ,

        Row(children: [
          Icon(Icons.location_on , color: mainColor,),
          SizedBox(width: 2,) ,
          customDescriptionText(context: context , text: "99 - Georgy street london" ,fontWeight: FontWeight.normal
              , percentageOfHeight: .015 , textColor:mainColor) ,
        ],) ,
        responsiveSizedBox(context: context , percentageOfHeight: .005) ,


        Row(children: [
          customDescriptionText(context: context , text: "Payment method :" , percentageOfHeight: .02 , textColor:greyColor) ,
        ],) ,
        responsiveSizedBox(context: context , percentageOfHeight: .005) ,

        Row(children: [
          Image.asset("assets/icons/credit cards.png" , height: 20,) ,
          SizedBox(width: 2,) ,
          customDescriptionText(context: context , text: "99 - Georgy street london" ,fontWeight: FontWeight.normal
              , percentageOfHeight: .015 , textColor:mainColor) ,
        ],),
        responsiveSizedBox(context: context , percentageOfHeight: .01) ,

        Container(width:
        width(context)*.8,child: Divider(thickness: 2,),) ,
        responsiveSizedBox(context: context , percentageOfHeight: .01) ,

        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customDescriptionText(context: context , text: "Suptotal:" , percentageOfHeight: .02 , textColor:greyColor) ,
            customDescriptionText(context: context , text: "\$18000" , percentageOfHeight: .018 , textColor:mainColor ,
                fontWeight: FontWeight.bold) ,

          ],) ,
        responsiveSizedBox(context: context , percentageOfHeight: .005) ,

        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customDescriptionText(context: context , text: "Delivery:" , percentageOfHeight: .02 , textColor:greyColor) ,
            customDescriptionText(context: context , text: "Free" , percentageOfHeight: .018 , textColor:mainColor ,
                fontWeight: FontWeight.bold) ,

          ],),
        responsiveSizedBox(context: context , percentageOfHeight: .005) ,

        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customDescriptionText(context: context , text: "Coupon discount :" , percentageOfHeight: .02 , textColor:greyColor) ,
            customDescriptionText(context: context , text: "\$00" , percentageOfHeight: .018 , textColor:mainColor ,
                fontWeight: FontWeight.bold) ,

          ],) ,
        responsiveSizedBox(context: context , percentageOfHeight: .005) ,


        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customDescriptionText(context: context , text: "VAT :" , percentageOfHeight: .02 , textColor:greyColor) ,
            customDescriptionText(context: context , text: "\$00" , percentageOfHeight: .018 , textColor:mainColor ,
                fontWeight: FontWeight.bold) ,

          ],)


      ],),
      height: isLandscape(context) ? 2*height(context)*.6:height(context)*.6,
      width: width(context)*.9,

      decoration: BoxDecoration(color: whiteColor ,
        borderRadius: BorderRadius.circular(8),),),),) ;
}