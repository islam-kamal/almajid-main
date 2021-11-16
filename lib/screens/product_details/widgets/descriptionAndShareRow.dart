import 'package:almajidoud/utils/file_export.dart';
import 'package:html/parser.dart' show parse;
import 'package:share/share.dart';
descriptionAndShareRow({BuildContext context , String description ,String product_name}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: width(context) * .7,
          child: customDescriptionText(
              context: context,
              text: _parseHtmlString(description),
              textAlign: TextAlign.start,
              maxLines: 2,
              textColor: greyColor,
              percentageOfHeight: .023),
        ),
        InkWell(
          onTap: () {
            final RenderBox box =
            context.findRenderObject();
            Share.share('${product_name??""}',
                subject: 'Welcome To Amajed Oud',
                sharePositionOrigin:
                box.localToGlobal(Offset.zero) &
                box.size);
          },
          child: Container(
            width: width(context) * .10,
            height: isLandscape(context)
                ? 2 * height(context) * .05
                : height(context) * .05,

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [Icon(Icons.share_outlined)],
            ),
          ),
        )
      ],
    ),
  );
}
String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);
  String parsedString = parse(document.body.text).documentElement.text;
  return parsedString;
}