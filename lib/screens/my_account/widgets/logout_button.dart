import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/my_account/widgets/logout_dialog.dart';
import 'package:almajidoud/screens/orders/order_sucessful_dialog.dart';
logoutButton({BuildContext context }){
  return  Container(width: width(context)*.8,child:
  GestureDetector(onTap: ()async{
    var user_name ='';
    await sharedPreferenceManager.readString(CachingKey.USER_NAME).then((value){
      user_name = value;
    });
       return LogoutDialog(
        name: user_name,
      );

  },
    child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Row(children: [
            Image.asset("assets/icons/log out.png" , height: isLandscape(context) ?
            2*height(context)*.037:height(context)*.037,),
            SizedBox(width: width(context)*.02,),
            customDescriptionText(context: context , text: "Logout", percentageOfHeight: .022,decoration: TextDecoration.underline
                , textColor: Colors.red.shade900) ,

          ],),

         SizedBox()

        ], ),
   //     Divider(color: mainColor)
      ],
    ),
  ),);
}