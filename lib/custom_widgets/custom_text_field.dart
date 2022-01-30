import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:almajidoud/utils/file_export.dart';

import 'custom_description_text.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final bool secure;
  final bool containsSuffixIcon;
  final bool  containsPrefixIcon;

  final int maxLines ;
  bool isPrefixIconComplex ;
  final bool isSearchTextField;
  final TextEditingController controller;
  final TextInputType inputType;
  CustomTextField(

      {this.secure: false,
        this.maxLines:1 ,
        this.isPrefixIconComplex : false ,
      this.hint: "",
      this.inputType: TextInputType.text,
      this.containsPrefixIcon: false,
      this.containsSuffixIcon: false ,
      this.isSearchTextField: false,
      this.controller,});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String _errorMessage(String str) {
    switch (widget.hint) {
      case 'Enter your name':
        return 'Name is empty !';
      case 'Enter your email':
        return 'Email is empty !';
      case 'Enter your password':
        return 'Password is empty !';
    }
  }




  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(

    );
  }


}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Widget icon;
}


