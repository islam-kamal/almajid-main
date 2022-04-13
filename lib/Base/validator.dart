import 'dart:async';

import 'dart:math';

import 'package:almajidoud/Repository/AuthenticationRepo/authentication_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

mixin Validator {
  var username_validator = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (username.length < 1) {
      sink.addError(translator.translate("username is incorrect"));
    } else {
      sink.add(username);
    }
  });

  var firstname_validator = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
        if (username.length < 1) {
          sink.addError(translator.translate("first name is incorrect"));
        } else {
          sink.add(username);
        }
      });
  var lastname_validator = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
        if (username.length < 1) {
          sink.addError(translator.translate("last name is incorrect"));
        } else {
          sink.add(username);
        }
      });

  var phone_validator = StreamTransformer<String, String>.fromHandlers(
      handleData: (phone, sink) async {
    Pattern pattern = r'^(009665|009715|00965|9665|9715|\+9665||\+9715|\+9655|05|5)(5|0|3|6|4|9|1|8|7|2)([0-9]{7})?$';
      RegExp regex = new RegExp(pattern.toString());
      if (!regex.hasMatch(phone) || phone.length < 8)
        sink.addError(translator.translate("phone is incorrect!"));
      else {
        if (!phone.startsWith(RegExp(
            r'(009665|009715|00965|9665|9715|\+9665||\+9715|\+965|05|5)'))) {
          if (MyApp.app_location == "sa") {
            phone = "00966" + phone;
          } else if (MyApp.app_location == "kw") {
            phone = "00965" + phone;
          } else if (MyApp.app_location == "uae") {
            phone = "00971" + phone;
          }
        }
        sink.add(phone);
      }
  });

  var email_validator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(email)) {
      sink.addError(translator.translate("email is incorrect!"));
    } else {
      sink.add(email);
    }
  });

  var password_validator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length < 8 || password.isEmpty) {
      sink.addError(translator.translate("password is incorrect"));
    } else {
      sink.add(password);
    }
  });

  var code_validator =
      StreamTransformer<String, String>.fromHandlers(handleData: (code, sink) {
    if (code.length < 4) {
      sink.addError(translator.translate("otp code is incorrect"));
    } else {
      sink.add(code);
    }
  });

  var input_number_validator =
      StreamTransformer<String, String>.fromHandlers(handleData: (input, sink) {
    if (input.length < 1) {
      sink.addError(translator.translate("input is incorrect"));
    } else {
      sink.add(input);
    }
  });

  var input_text_validator =
      StreamTransformer<String, String>.fromHandlers(handleData: (text, sink) {
    if (text.length < 1) {
      sink.addError(translator.translate("input is incorrect"));
    } else {
      sink.add(text);
    }
  });

  var credit_card_number_validator =
      StreamTransformer<String, String>.fromHandlers(handleData: (input, sink) {
    if (input.length < 16) {
      sink.addError('رقم البطاقة الائتمانية غير صحيح');
    } else {
      sink.add(input);
    }
  });
}
