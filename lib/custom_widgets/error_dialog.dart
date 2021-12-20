import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog({BuildContext context, String text, Function function}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.width / 1.5,
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      text ?? "",
                      maxLines:3 ,
                      style: TextStyle(
                          color: blackColor,
                          fontFamily: "Cairo",
                          fontSize: AlmajedFont.secondary_font_size),
                    )
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                "ok",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Cairo",
                  color: blackColor,
                ),
              ),
              onPressed: function ?? () => Navigator.pop(context),
            )
          ],
        );
      });
}
