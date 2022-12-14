import 'dart:io';

import 'package:almajidoud/Base/shared_preference_manger.dart';
import 'package:almajidoud/Repository/AuthenticationRepo/authentication_repository.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/utils/colors.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
class UpdateProfile extends StatefulWidget {

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  TextEditingController? _phoneController;
  String? _firstName = '';
  String? _lastName = '';
  String? _userName = '';
  String? _email;
  String? _phoneNumber;
  final _formKey = GlobalKey<FormState>();
  bool? _isLoading = false;


  @override
  void initState() {
    _getUseData();
    super.initState();
  }

  void _getUseData() async {
    _email = await sharedPreferenceManager.readString(CachingKey.EMAIL);
    _userName = await sharedPreferenceManager.readString(CachingKey.USER_NAME);
    if(_userName !=''){
      List<String> fullName = _userName!.split(' ');
      _firstName = fullName[0];
      _lastName = fullName[1];
      _firstNameController = new TextEditingController(text: _firstName);
      _lastNameController = new TextEditingController(text: _lastName);
    }
    _phoneNumber = await sharedPreferenceManager.readString(CachingKey.MOBILE_NUMBER);

    _phoneController = new TextEditingController(text: _phoneNumber);
    setState(() {});
  }



  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        final _token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
        final result = await  AuthenticationRepository.updateUserProfile(firstName: _firstName,lastName: _lastName,
        email: _email,phone:_phoneNumber,token: _token);
        if(result){
          // save the new info
          await sharedPreferenceManager.writeData(CachingKey.USER_NAME, _firstName! +' '+ _lastName!);
          await sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, _phoneNumber);
          Fluttertoast.showToast(
              msg: "account updated successfully".tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }else{
          List<String> fullName = _userName!.split(' ');
          _firstName = fullName[0];
          _lastName = fullName[1];
          Fluttertoast.showToast(
              msg: "something went wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        Navigator.of(context).pop({'full_name':_firstName! + ' ' +  _lastName!});

      } catch (error) {
        errorDialog(context: context, text: 'something went wrong');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
      child: Scaffold(

      body:  Directionality(
        textDirection: translator.activeLanguageCode =='ar'? TextDirection.rtl : TextDirection.ltr,
        child:     SingleChildScrollView(
        child: Column(
          children: [
            ScreenAppBar(
              right_icon: 'cart',
              category_name: "Update Profile".tr(),
              screen: CustomCircleNavigationBar(page_index: 4,),

            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        key: ValueKey('first_name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return  "Please enter".tr()+' ' + "First Name".tr();
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_lastNameFocusNode),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                            labelText: "First Name".tr(),
                            fillColor: whiteColor
                        ),
                        onSaved: (value) {
                          _firstName = value;
                        },
                        controller: _firstNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        key: ValueKey('last_name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter".tr()+' ' + "Last Name".tr();
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_phoneNumberFocusNode),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(Icons.person),
                            labelText: "Last Name".tr(),
                            fillColor: whiteColor),
                        onSaved: (value) {
                          _lastName = value;
                        },
                        controller: _lastNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        key: ValueKey('phone number'),
                        focusNode: _phoneNumberFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter".tr()+' ' + "Phone".tr();
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: _submitForm,
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly
                          ,FilteringTextInputFormatter.deny(RegExp(r'^0+')),],

                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(Icons.phone_android),
                            labelText: "Phone".tr(),
                            fillColor: whiteColor),
                        onSaved: (value) {
                          _phoneNumber = value;
                        },
                        controller: _phoneController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child:    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 10),
                          _isLoading!
                              ? CircularProgressIndicator(

                          )
                              : InkWell(
                              onTap: _submitForm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: mainColor)
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Update".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: mainColor,
                                          fontSize: 17),

                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Feather.user,
                                      size: 18,
                                      color: mainColor,
                                    )
                                  ],
                                ),
                              )
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),)
                )) );
  }

  Widget leadingWidget() {
    return IconButton(icon: Icon(Icons.arrow_back_ios),
      color: mainColor,
      onPressed: () {
        Navigator.canPop(context)?Navigator.pop(context):null;
      },);

  }

  @override
  void dispose() {
    _lastNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }
}
