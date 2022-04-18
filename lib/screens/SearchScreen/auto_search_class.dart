
import 'package:almajidoud/screens/SearchScreen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:almajidoud/utils/file_export.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const MyTextField(this.controller, this.focusNode);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width(context) * .5,
      height: isLandscape(context) ? 2 * height(context) * .04 : height(context) * .04,
      child: TextFormField(
        onTap: (){
          customAnimatedPushNavigation(context, SearchScreen());
        },
        style: TextStyle(color:whiteColor),
        textAlign: TextAlign.right,

        cursorColor: greyColor.withOpacity(.5),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: mainColor, fontSize: 12, ),
          hintText: translator.translate("Type here to search"),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              size: 20,
            ),
            color: mainColor,
            onPressed: () {
            },
          ),
          filled: false,

          contentPadding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: mainColor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: mainColor, width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: mainColor, width: 1)),
        ),
      ),
    );
  }
}

