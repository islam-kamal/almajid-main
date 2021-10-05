import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:almajidoud/utils/file_export.dart';

class CustomButton extends StatelessWidget {
  final double percentageOfHeight;
  final double percentageOfWidth;
  final double radius;
  final Color buttonColor;
  final String text;
  final Color textColor;
  final double fontSize;
  final Function onTapButton;
  final FontWeight fontWieght;
  CustomButton(
      {this.percentageOfHeight: .08,
      this.percentageOfWidth: .9,
      this.radius: 30,
      this.buttonColor: mainColor,
      this.text :"bitton text ",
      this.textColor : whiteColor ,
      this.fontSize : .025 ,
      this.fontWieght : FontWeight.bold ,
      this.onTapButton});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              height: isLandscape(context)
                  ? 2 * height * percentageOfHeight
                  : height * percentageOfHeight,
              width: isLandscape(context)
                  ?  width * percentageOfWidth
                  : width * percentageOfWidth,
              child: Center(
                  child: Text(
                translator.translate(text),

                style: TextStyle(
                    color: textColor,
                    fontWeight: fontWieght,
                    fontSize:isLandscape(context) ? 2*height*fontSize:height*fontSize  ),
              )),
              decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(30)),
            ),
            onTap: onTapButton,
          )
        ],
      ),
    );
  }
}
