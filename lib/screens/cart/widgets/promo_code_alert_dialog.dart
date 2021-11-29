import 'package:flutter/cupertino.dart';
import 'package:almajidoud/custom_widgets/responsive_sized_box.dart';
import 'package:almajidoud/custom_widgets/custom_description_text.dart';
import 'package:almajidoud/utils/file_export.dart';

Future promoCodeAlertDialog({BuildContext base_context}) {
  TextEditingController controller = new TextEditingController();
  return showDialog<void>(
    context: base_context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.grey.shade300,

        
        actionsPadding: EdgeInsets.only(left: width(context)*.05 , right: width(context)*.05),
        content: Container(
//          width: isLandscape(context)
//              ? .7 * width(context) * .85
//              : width(context) * .85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: width(context),height: height(context) *.08,color: whiteColor,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween
                  ,children: [
                    SizedBox(),
                  customDescriptionText(context: context , text: "Promo Code" , percentageOfHeight: .025 , fontWeight: FontWeight.bold)
,
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close) ,

                  ),
                ],),
              ),
          Container(width: width(context),height: 4 ,color: mainColor),
              Container(
                
                child: Column(children: [
                  responsiveSizedBox(context: context, percentageOfHeight: .02),
                  customDescriptionText(context: context , text: "Apply your promo code to avail offers" ,
                      percentageOfHeight: .02 , fontWeight: FontWeight.bold , textColor: greyColor),
                  responsiveSizedBox(context: context, percentageOfHeight: .02),
                  Container(width: width(context)*.7,height: height(context)*.06,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.edit),
                          hintText: translator.translate("Input copoun number"),
                          hintStyle: TextStyle(
                              color:  greyColor.withOpacity(.5) ,
                              fontWeight: FontWeight.bold,
                              fontSize:  isLandscape(context)   ? 2* height(context)*.018 :height(context)*.018),
                          filled: true,fillColor: whiteColor,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide(color: blackColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide(color: blackColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: BorderSide(color: blackColor)),
                        ))),
                  responsiveSizedBox(context: context, percentageOfHeight: .02),
                  dotsRow(context: context),
                  responsiveSizedBox(context: context, percentageOfHeight: .02),
                ],),
              )

            ],
          ),
        ),
        actions: <Widget>[
          
          Container(
            child: Center(
              child: GestureDetector(onTap: (){
                print("------ prom_code ---- ${controller.value.text}");
                shoppingCartBloc.add(ApplyPromoCodeEvent(
                  context: base_context,
                  prom_code: controller.value.text
                ));
                Navigator.pop(context);

              },
                child: Container(
                    width: width(context) * .9,
                    decoration: BoxDecoration(
                        color: mainColor, borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: customDescriptionText(
                            context: context,
                            text: "Apply",percentageOfHeight: .025,
                            textColor: whiteColor)),
                    height: isLandscape(context)
                        ? 2 * height(context) * .045
                        : height(context) * .045),
              ),
            ),
          )
        ],
      );
    },
  );
}
dotsRow({BuildContext context}){
  return Container(width: width(context),child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Container(width: width(context)*.6,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),
          singleDot(context: context),],
      ),
    ) ,
    RotatedBox(quarterTurns: 2,
        child: Icon(Icons.content_cut)) ,
    Container(color: mainColor,height: 3,width: 30
    )
  ],),) ;
}
singleDot({BuildContext context}){
  return Container(color: mainColor,height: 3,width: 4
  );
}
