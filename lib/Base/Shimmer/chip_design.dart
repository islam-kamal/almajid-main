import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';

class ChipDesign extends StatelessWidget {
  final String label;
  final Color color;
  final txtColor;

  const ChipDesign({Key key, this.label, this.color, this.txtColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chip(
         shape: StadiumBorder(side: BorderSide(
           color: mainColor
         )),
        label: Text(
          label,
          style: TextStyle(color:txtColor, fontFamily: 'Almarai'),
        ),
        backgroundColor: color,
        // elevation: 4,
        // shadowColor: mainAppColor,
        padding: EdgeInsets.all(4),
      ),
      margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
    );
  }
}
