import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/my_account/widgets/logout_dialog.dart';
import 'package:almajidoud/screens/orders/order_sucessful_dialog.dart';
logButton({BuildContext context ,var type}){
  return  Container(width: width(context)*.8,child:
  GestureDetector(onTap: ()async{
    if(type == "Logout"){
      var user_name ='';
      await sharedPreferenceManager.readString(CachingKey.USER_NAME).then((value){
        user_name = value;
      });
      print("logout------------");
      return  showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
       return LogoutDialog(
          name: user_name,
        );
        });
    }else{
      customAnimatedPushNavigation(context, SignInScreen());
    }


  },
    child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Row(children: [
            type == "Logout"? Image.asset("assets/icons/log out.png" , height: isLandscape(context) ?
            2*height(context)*.037:height(context)*.037,)
            : Icon(Icons.login)
            ,
            SizedBox(width: width(context)*.02,),
            customDescriptionText(context: context ,
                text: type, percentageOfHeight: .022,decoration: TextDecoration.underline
                , textColor: mainColor) ,

          ],),

         SizedBox()

        ], ),
   //     Divider(color: mainColor)
      ],
    ),
  ),);
}