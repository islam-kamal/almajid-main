import 'package:almajidoud/utils/file_export.dart';
import 'package:html/parser.dart' show parse;
descriptionAndShareRow({BuildContext context , String description }) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(
              right: width(context) * .05, left: width(context) * .05),
          width: width(context) ,
          child: customDescriptionText(
              context: context,
              text: _parseHtmlString(description),
              textAlign: TextAlign.start,
              maxLines: 10,
              textHeight: 1.5,
              textColor: mainColor,
              percentageOfHeight: .015),
        ),
      ],
    ),
  );
}
String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);
  String parsedString = parse(document.body.text).documentElement.text;
  return parsedString;
}