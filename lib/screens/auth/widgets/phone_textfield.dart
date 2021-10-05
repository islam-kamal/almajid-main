import 'package:almajidoud/utils/file_export.dart';

phoneTextField({BuildContext context , String hint
  , bool isPasswordField : false  , bool containPrefixIcon : false  , IconData prefixIcon , code , Function onTapPrefix}){
  return     Container(width: width(context)*.8,
      child: TextField(decoration: InputDecoration(

          prefixIcon: containPrefixIcon == false ?null : GestureDetector(onTap: onTapPrefix ,
              child: Container(height: 40,width: 80,
                  child: Center(child: Text(code)))),
          hintText: hint , suffixIcon :
      isPasswordField == true ?
      Icon(MdiIcons.eyeOff,size: 18,
        color: mainColor,): null))) ;
}