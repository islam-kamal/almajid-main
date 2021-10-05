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
//      child: TextFormField(maxLines: widget.maxLines,
//        controller: widget.controller,
//        keyboardType: widget.inputType,
//        style: TextStyle(color:  greyColor.withOpacity(.5), fontSize:  isLandscape(context)   ? 2* height*.02 :height*.02),
//        obscureText: widget.secure,
//        cursorColor:  greyColor.withOpacity(.5) ,
//        decoration: InputDecoration(
//          suffixIcon: widget.containsSuffixIcon== false
//              ? null
//              : Container(
//                  height: 5,
//                  width: 5,
//                  child: Center(
//                      heightFactor: 10,
//                      widthFactor: 10,
//                      child: Icon(Icons.remove_red_eye ,
//                        color: greyColor.withOpacity(.5),)),
//                ),
//          prefixIcon:  widget.containsPrefixIcon  == false
//              ?  null : Container(
//
//                child:
//
//                    widget.isPrefixIconComplex ?  DropdownButton<Item>(
//                      icon: SizedBox(),
//                      underline: SizedBox(),
//                      hint: Container(
//                          padding: EdgeInsets.only(left: width*.03 , right: width
//                              *.03),
//                          height: isLandscape(context) ?2* height*.045:height*.045  ,
//                          width:  width*.3,
//                          child: Center(
//                              heightFactor: isLandscape(context) ?2* height*.045:height*.045 ,
//                              widthFactor:  width*.2,
//                              child: Container(padding: EdgeInsets.only(right: width*.01 , left: width*.01),
//                                height: isLandscape(context) ?2* height*.045:height*.045  ,
//                                width: width*.3,
//                                decoration: BoxDecoration(color:  greyColor.withOpacity(.5) , borderRadius: BorderRadius.circular(30)),
//
//                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: [
//                                    Image.asset(
//                                      AppIcons.flag ,
//                                      height: 10,
//                                      width:  width*.07,
//                                    ),
//                                    customDescriptionText(context: context , text: "+ 994" , textColor: blackColor ),
//                                    Image.asset(
//                                      AppIcons.downArrow,
//                                      height: 10,
//                                      width:  width*.03,
//                                    ),
//                                  ],
//                                ),
//                              )
//                          )),
//                      value: selectedUser,
//                      onChanged: (Item Value) {
//                        setState(() {
//                          selectedUser = Value;
//                        });
//                      },
//                      items: users.map((Item user) {
//                        return  DropdownMenuItem<Item>(
//                          value: user,
//                          child:
//                          Container(
//                              padding: EdgeInsets.only(left: width*.03 , right: width
//                                  *.03),
//                              height: isLandscape(context) ?2* height*.045:height*.045  ,
//                              width:  width*.3,
//                              child: Center(
//                                  heightFactor: isLandscape(context) ?2* height*.045:height*.045 ,
//                                  widthFactor:  width*.2,
//                                  child: Container(padding: EdgeInsets.only(right: width*.01 , left: width*.01),
//                                    height: isLandscape(context) ?2* height*.045:height*.045  ,
//                                    width: width*.3,
//                                    decoration: BoxDecoration(color:  greyColor.withOpacity(.5) , borderRadius: BorderRadius.circular(30)),
//
//                                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                                      children: [
//                                        user.icon ,
//                                        SizedBox(width: width*.02,),
//                                        customDescriptionText(context: context , text: user.name , textColor: blackColor ),
////                                        Image.asset(
////                                          AppIcons.downArrow,
////                                          height: 10,
////                                          width:  width*.03,
////                                        ),
//                                      ],
//                                    ),
//                                  )
//                              ))
//
////                          Row(
////                            children: <Widget>[
////                              user.icon,
////                              SizedBox(width: 10,),
////                              Text(
////                                user.name,
////                                style:  TextStyle(color: Colors.black),
////                              ),
////                            ],
////                          ),
//                        );
//                      }).toList(),
//                    ):
//                Container(
//                    height: 5,
//                    width: 5,
//                    child: Center(
//                        heightFactor: 10,
//                        widthFactor: 10,
//                        child: Image.asset(
//                         widget.prefixIconPath ,
//                          height: 25,
//                          width: 25,
//                        )),
//                  ),
//              ),
//
//          hintText: translator.translate(widget.hint),
//          hintStyle: TextStyle(
//              color:  greyColor.withOpacity(.5) ,
//              fontWeight: FontWeight.bold,
//              fontSize:  isLandscape(context)   ? 2* height*.018 :height*.018),
//          filled: false,
//          enabledBorder: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(10),
//              borderSide: BorderSide(color:  greyColor.withOpacity(.5))),
//          focusedBorder: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(10),
//              borderSide: BorderSide(color:  greyColor.withOpacity(.5))),
//          border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(10),
//              borderSide: BorderSide(color: greenColor)),
//        ),
//      ),
    );
  }

//  chooseCountryKeyNumberWidget({BuildContext context}){
//    double height = MediaQuery.of(context).size.height;
//    double width = MediaQuery.of(context).size.width;
//    return  GestureDetector(onTap: (){
//    },
//      child: Container(
//          padding: EdgeInsets.only(left: width*.03 , right: width
//              *.03),
//          height: isLandscape(context) ?2* height*.045:height*.045  ,
//          width:  width*.3,
//          child: Center(
//              heightFactor: isLandscape(context) ?2* height*.045:height*.045 ,
//              widthFactor:  width*.2,
//              child: Container(padding: EdgeInsets.only(right: width*.01 , left: width*.01),
//                height: isLandscape(context) ?2* height*.045:height*.045  ,
//                width: width*.3,
//                decoration: BoxDecoration(color:  greyColor.withOpacity(.5) , borderRadius: BorderRadius.circular(30)),
//
//                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    Image.asset(
//                      AppIcons.flag ,
//                      height: 10,
//                      width:  width*.07,
//                    ),
//                    customDescriptionText(context: context , text: "+ 994" , textColor: blackColor ),
//                    Image.asset(
//                      AppIcons.downArrow,
//                      height: 10,
//                      width:  width*.03,
//                    ),
//                  ],
//                ),
//              )
//          )),
//    ) ;
//  }
}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Widget icon;
}
//class DropdownScreen extends StatefulWidget {
//  State createState() =>  DropdownScreenState();
//}
//class DropdownScreenState extends State<DropdownScreen> {
//  Item selectedUser;
//  List<Item> users = <Item>[
//    const Item('Android',Icon(Icons.android,color:  const Color(0xFF167F67),)),
//    const Item('Flutter',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
//    const Item('ReactNative',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
//    const Item('iOS',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
//  ];
//  @override
//  Widget build(BuildContext context) {
//    return  MaterialApp(
//      home:  Scaffold(
//        appBar: AppBar(
//          backgroundColor: const Color(0xFF167F67),
//          title: Text(
//            'Dropdown options',
//            style: TextStyle(color:  greyColor.withOpacity(.5)),
//          ),
//        ),
//        body:  Center(
//          child:  DropdownButton<Item>(
//            hint:  Text("Select item"),
//            value: selectedUser,
//            onChanged: (Item Value) {
//              setState(() {
//                selectedUser = Value;
//              });
//            },
//            items: users.map((Item user) {
//              return  DropdownMenuItem<Item>(
//                value: user,
//                child: Row(
//                  children: <Widget>[
//                    user.icon,
//                    SizedBox(width: 10,),
//                    Text(
//                      user.name,
//                      style:  TextStyle(color: Colors.black),
//                    ),
//                  ],
//                ),
//              );
//            }).toList(),
//          ),
//        ),
//      ),
//    );
//  }
//}






//class MyHomePage2 extends StatefulWidget {
//  @override
//  _MyHomePage2State createState() => _MyHomePage2State();
//}
//
//class _MyHomePage2State extends State<MyHomePage2> {
//  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//  final TextEditingController controller = TextEditingController();
//  String initialCountry = 'NG';
//  PhoneNumber number = PhoneNumber(isoCode: 'NG');
//
//  @override
//  Widget build(BuildContext context) {
//    return Form(
//      key: formKey,
//      child: Container(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            InternationalPhoneNumberInput(
//              onInputChanged: (PhoneNumber number) {
//                print(number.phoneNumber);
//              },
//              onInputValidated: (bool value) {
//                print(value);
//              },
//              selectorConfig: SelectorConfig(
//                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//              ),
//              ignoreBlank: false,
//              autoValidateMode: AutovalidateMode.disabled,
//              selectorTextStyle: TextStyle(color: Colors.black),
//              initialValue: number,
//              textFieldController: controller,
//              formatInput: false,
//              keyboardType:
//              TextInputType.numberWithOptions(signed: true, decimal: true),
//              inputBorder: OutlineInputBorder(),
//              onSaved: (PhoneNumber number) {
//                print('On Saved: $number');
//              },
//            ),
//            ElevatedButton(
//              onPressed: () {
//                formKey.currentState.validate();
//              },
//              child: Text('Validate'),
//            ),
//            ElevatedButton(
//              onPressed: () {
//                getPhoneNumber('+15417543010');
//              },
//              child: Text('Update'),
//            ),
//            ElevatedButton(
//              onPressed: () {
//                formKey.currentState.save();
//              },
//              child: Text('Save'),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  void getPhoneNumber(String phoneNumber) async {
//    PhoneNumber number =
//    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');
//
//    setState(() {
//      this.number = number;
//    });
//  }
//
//  @override
//  void dispose() {
//    controller?.dispose();
//    super.dispose();
//  }
//}

