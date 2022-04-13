import 'package:almajidoud/utils/file_export.dart';

responsiveSizedBox({BuildContext? context, double? percentageOfHeight}) {
  return SizedBox(
      height: isLandscape(context)
          ? 2 * height(context) * percentageOfHeight!
          : height(context) * percentageOfHeight!);
}
