import 'dart:ui';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:almajidoud/utils/file_export.dart';

customDescriptionText(
    {BuildContext context,
    String text,
    double percentageOfHeight: .019,
    Color textColor: blackColor,
    FontWeight fontWeight: FontWeight.normal,
    textAlign: TextAlign.center,
    decoration: null,
    fontStyle: FontStyle.normal,
    int maxLines: 1,
    double textHeight: 1.0}) {
  return Text(
    translator.translate(text),
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        height: textHeight,
        fontStyle: fontStyle,
        decoration: decoration,
        fontWeight: fontWeight,
        color: textColor,
        fontSize: isLandscape(context)
            ? 2 * height(context) * percentageOfHeight
            : height(context) * percentageOfHeight),
  );
}
