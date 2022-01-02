import 'package:almajidoud/utils/file_export.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign align;
  final int maxLines;

  MyText(
      {@required this.text,
      @required this.size,
      this.color: blackColor,
      this.weight: FontWeight.normal,
      this.align: TextAlign.center,
      this.maxLines = 2});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Text(text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: weight,
        ),
        textDirection: TextDirection.ltr,
        textAlign: align);
  }
}
