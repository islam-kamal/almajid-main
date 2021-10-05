import 'dart:ui';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:almajidoud/utils/file_export.dart';

titleRow({BuildContext context, String text}) {
  return Container(
    width: width(context)*.9,
    child: Row(
      children: [
        Text(
          translator.translate(text),
          style: TextStyle(
              color: mainColor,
              fontSize: isLandscape(context)
                  ? 2 * height(context) * .023
                  : height(context) * .023),
        )
      ],
    ),
  );
}
