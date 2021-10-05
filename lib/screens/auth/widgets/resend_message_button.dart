import 'package:almajidoud/utils/file_export.dart';

resendMessageButton({BuildContext context }){
  return  Container(width: width(context)*.9,
    child: Row(mainAxisAlignment: MainAxisAlignment.end,
      children: [

        GestureDetector(child:
        customDescriptionText(context: context ,decoration:
        TextDecoration.underline, textColor: Colors.red.shade500,
            text: "Resend MSG" , percentageOfHeight: .015 ,fontWeight: FontWeight.bold )
          ,onTap: (){
            customAnimatedPushNavigation(context, ForgetPasswordScreen());

          },)    ],),
  );

}