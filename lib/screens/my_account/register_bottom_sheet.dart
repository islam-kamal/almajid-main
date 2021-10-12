
import 'package:almajidoud/utils/file_export.dart';

void showRegisterBottomSheet({BuildContext context  , providerId}){
  showModalBottomSheet(
      context: context,
      builder: (builder){
        return new Container(
          height: height(context),
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              height: height(context)*.9,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: new Container(
                padding: EdgeInsets.only(right: width(context)*.05 , left:width(context)*.05),
                child: SingleChildScrollView(
                    child:Column(children: [
                      responsiveSizedBox(context: context , percentageOfHeight: .02),
                      singleTextFieldTitle(context: context , textFieldTitle: "User Name"),
                      responsiveSizedBox(context: context , percentageOfHeight: .01),
                      registerInAccountTextFields(context:context  , hint: "name") ,
                      responsiveSizedBox(context: context , percentageOfHeight: .01),
                      singleTextFieldTitle(context: context , textFieldTitle: "Email"),
                      responsiveSizedBox(context: context , percentageOfHeight: .01),
                      registerInAccountTextFields(context:context  , hint: "Email") ,
                      responsiveSizedBox(context: context , percentageOfHeight: .01),
                      singleTextFieldTitle(context: context , textFieldTitle: "Phone Number"),
                      responsiveSizedBox(context: context , percentageOfHeight: .01),
                      registerInAccountTextFields(context:context  , hint: "Phone Number") ,
                      responsiveSizedBox(context: context , percentageOfHeight: .01),
                      singleTextFieldTitle(context: context , textFieldTitle: "Password"),
                      responsiveSizedBox(context: context , percentageOfHeight: .01),
                      registerInAccountTextFields(context:context  , hint: "Password") ,
                      responsiveSizedBox(context: context , percentageOfHeight: .01 ),
                      singleTextFieldTitle(context: context , textFieldTitle: "Date Of Birht"),
                      responsiveSizedBox(context: context , percentageOfHeight: .01),
                      registerInAccountTextFields(context:context  , hint: "Date Of Birht") ,
                      responsiveSizedBox(context: context , percentageOfHeight: .01),
                      singleTextFieldTitle(context: context , textFieldTitle: "Country/Region"),
                      responsiveSizedBox(context: context , percentageOfHeight: .01),
                      registerInAccountTextFields(context:context  , hint: "Country/Region") ,
                      responsiveSizedBox(context: context , percentageOfHeight: .01),





                    ],)
                ),
              )),
        );
      }
  );
}
registerInAccountTextFields({BuildContext context , String hint }){
  return   Container(
    height: isLandscape(context)
        ?2*height(context)*.08:height(context)*.08 ,
    child: TextFormField(
      style: TextStyle(color:  greyColor.withOpacity(.5),
          fontSize:
          isLandscape(context)   ? 2* height(context)*.02 :height(context)*.02),
      cursorColor:  greyColor.withOpacity(.5) ,
      decoration: InputDecoration(
        hintText: translator.translate(hint),
        hintStyle: TextStyle(
            color:  greyColor.withOpacity(.5) ,
            fontWeight: FontWeight.bold,
            fontSize:  isLandscape(context)   ? 2* height(context)*.018 :height(context)*.018),
        filled: true,fillColor: whiteColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: blackColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: blackColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: blackColor)),
      ),
    ),
  );
}

singleTextFieldTitle({BuildContext context , String textFieldTitle}){
  return Row(children: [
    customDescriptionText(context: context , text: textFieldTitle ,
        textColor: blackColor , fontWeight: FontWeight.bold , percentageOfHeight:
        .025 , textAlign: TextAlign.start)
  ],);
}