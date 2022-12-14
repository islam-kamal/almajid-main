import 'package:almajidoud/utils/file_export.dart';
import 'package:html/parser.dart' show parse;

descriptionAndShareRow({BuildContext? context, String? description}) {
  return  Scrollbar(
      isAlwaysShown: true,
      showTrackOnHover: true,
      thickness: 10,
      radius: Radius.circular(20),
      interactive: true,
      // scrollbarOrientation: ScrollbarOrientation.left,

      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width(context) * .05, vertical: 5),
        width: width(context),
        child: customDescriptionText(
            context: context,
            text: _parseHtmlString(description!),
            textAlign: TextAlign.start,
            maxLines: 10,
            textHeight: 1.5,
            textColor: mainColor,
            percentageOfHeight: .015),
      ),
    );
}

String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);
  String parsedString = parse(document.body!.text).documentElement!.text;
  return parsedString.replaceAll('.', '\n');
}
