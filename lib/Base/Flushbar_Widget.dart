import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';

void FlushbarWidget({ BuildContext? context ,  GlobalKey<ScaffoldState>? scaffoldKey , var text }){
  Flushbar(
    messageText: Row(
      children: [
        Container(
          width: StaticData.get_width(context!) * 0.7,
          child: Wrap(
            children: [
              Text(
                '${text}',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: whiteColor),
              ),
            ],
          ),
        ),
        Spacer(),
        Text(
          translator.translate("Try Again" ),
          textDirection: TextDirection.rtl,
          style: TextStyle(color: whiteColor),
        ),
      ],
    ),
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: redColor,
    flushbarStyle: FlushbarStyle.FLOATING,
    duration: Duration(seconds: 3),
  )..show(scaffoldKey!.currentState!.context);
}