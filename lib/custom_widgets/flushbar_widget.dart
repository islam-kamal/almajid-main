import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:another_flushbar/flushbar.dart';

class FlushbarWidget extends StatelessWidget{
  final String message;
  BuildContext context;
  FlushbarWidget({this.message,this.context});
  @override
  Widget build(BuildContext context) {
    return Flushbar(
      messageText: Row(
        children: [
          Container(
            width: StaticData.get_width(context) * 0.7,
            child: Wrap(
              children: [
                Text(
                  '${message}',
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
      duration: Duration(seconds: 6),
    )..show(context);
  }

}