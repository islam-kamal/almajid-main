import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

resendSmsButton({BuildContext context}) {
  return Container(
      width: width(context) * .85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          customDescriptionText(
              context: context,
              textColor: mainColor,
              textAlign: TextAlign.end,
              decoration: TextDecoration.underline,
              text: "Resend SMS",
              percentageOfHeight: .018),
          Icon(
            Icons.refresh,
            color: mainColor,
            size: isLandscape(context)
                ? 2 * height(context) * .025
                : height(context) * .025,
          ),
        ],
      ));
}
