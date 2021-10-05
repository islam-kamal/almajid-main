import 'package:almajidoud/utils/file_export.dart';

authTextField(
    {BuildContext context,
    String hint,
    bool isPasswordField: false,
    bool containPrefixIcon: false,
    IconData prefixIcon}) {
  return Container(
      width: width(context) * .8,
      child: TextField(
          decoration: InputDecoration(
              prefixIcon: containPrefixIcon == false ? null : Icon(prefixIcon),
              hintText: translator.translate(hint),
              suffixIcon: isPasswordField == true
                  ? Icon(
                      MdiIcons.eyeOff,
                      size: 18,
                      color: mainColor,
                    )
                  : null)));
}
