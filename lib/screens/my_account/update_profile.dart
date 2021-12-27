import 'dart:io';

import 'package:almajidoud/Base/shared_preference_manger.dart';
import 'package:almajidoud/Repository/AuthenticationRepo/authentication_repository.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:nb_utils/nb_utils.dart';

class UpdateProfile extends StatefulWidget {

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _phoneController;
  String _firstName = '';
  String _lastName = '';
  String _userName = '';
  String _email;
  String _phoneNumber;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;


  @override
  void initState() {
    _getUseData();
    super.initState();
  }

  void _getUseData() async {
    _email = await sharedPreferenceManager.readString(CachingKey.EMAIL);
    _userName = await sharedPreferenceManager.readString(CachingKey.USER_NAME);
    if(_userName !=''){
      List<String> fullName = _userName.split(' ');
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
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      try {
        final _token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
        final result = await  AuthenticationRepository.updateUserProfile(firstName: _firstName,lastName: _lastName,
        email: _email,phone:_phoneNumber,token: _token);
        if(result){
          // save the new info
          await sharedPreferenceManager.writeData(CachingKey.USER_NAME, _firstName +' '+ _lastName);
          await sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, _phoneNumber);
          toasty(context, "account updated successfully ", bgColor:  Colors.green, textColor: Colors.white, gravity: ToastGravity.BOTTOM);
        }else{
          List<String> fullName = _userName.split(' ');
          _firstName = fullName[0];
          _lastName = fullName[1];
          toasty(context, "something went wrong ", bgColor:  Colors.redAccent, textColor: Colors.white, gravity: ToastGravity.BOTTOM);
        }
        Navigator.of(context).pop({'full_name':_firstName + ' ' +  _lastName});

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
    return Scaffold(
      appBar:  AppBar(
        title: Text('Update Profile',style: TextStyle(color: Colors.black),),
        // Center the title in AppBar with setting center title property to true.
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: leadingWidget(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
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
                              if (value.isEmpty) {
                                return 'first name cannot be null';
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
                                labelText: 'First name',
                                fillColor: Theme.of(context).backgroundColor),
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
                              if (value.isEmpty) {
                                return 'last name cannot be null';
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
                                labelText: 'Last name',
                                fillColor: Theme.of(context).backgroundColor),
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
                              if (value.isEmpty) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: _submitForm,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.phone_android),
                                labelText: 'Phone number ex: 00966xxx or 00965xx',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _phoneNumber = value;
                            },
                            controller: _phoneController,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                            _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(color: Colors.black12),
                                      ),
                                    )),
                                    onPressed: _submitForm,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Update',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Feather.user,
                                          size: 18,
                                        )
                                      ],
                                    )),
                            SizedBox(width: 20),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget leadingWidget() {
    return BackButton(
      color: mainColor,
      onPressed: () {
        Navigator.canPop(context)?Navigator.pop(context):null;
      },
    );
  }

  @override
  void dispose() {
    _lastNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }
}
