import 'package:almajidoud/utils/file_export.dart';
import 'package:html/parser.dart' show parse;

shippingAndReturnsWidget({BuildContext? context}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: width(context) * .05, vertical: 5),
          width: width(context),
          child: Scrollbar(
            isAlwaysShown: true,
            showTrackOnHover: true,
            thickness: 10,
            radius: Radius.circular(20),
            interactive: true,
           // scrollbarOrientation: ScrollbarOrientation.left,

            child: ListView.builder(
              itemBuilder:(context, index) {
                return Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                            title: customDescriptionText(
                                context: context,
                                text: _parseHtmlString(translator.translate("shipping&returns_frist")),
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                textHeight: 1.5,
                                textColor: mainColor,
                                percentageOfHeight: .015)
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                            title: customDescriptionText(
                                context: context,
                                text: _parseHtmlString(translator.translate("shipping&returns_second")),
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                textHeight: 1.5,
                                textColor: mainColor,
                                percentageOfHeight: .015)
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                            title: customDescriptionText(
                                context: context,
                                text: _parseHtmlString(translator.translate( "shipping&returns_third" )),
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                textHeight: 1.5,
                                textColor: mainColor,
                                percentageOfHeight: .015)
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                            title: customDescriptionText(
                                context: context,
                                text: _parseHtmlString(translator.translate("shipping&returns_fourth")),
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                textHeight: 1.5,
                                textColor: mainColor,
                                percentageOfHeight: .015)
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                            title: customDescriptionText(
                                context: context,
                                text: _parseHtmlString(translator.translate( "shipping&returns_fifth" )),
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                textHeight: 1.5,
                                textColor: mainColor,
                                percentageOfHeight: .015)
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    )
                );
              },
              itemCount: 1,
            ),
          ),
        )
      ],
    ),
  );
}

String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);
  String parsedString = parse(document.body!.text).documentElement!.text;
  return parsedString.replaceAll('.', '\n');
}
