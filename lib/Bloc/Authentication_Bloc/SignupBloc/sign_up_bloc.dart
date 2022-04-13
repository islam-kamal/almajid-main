import 'dart:async';

import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends Bloc<AppEvent,AppState> with Validator{
  final AuthenticationRepository _authenticationRepository;
  SignUpBloc(this._authenticationRepository) : super(Start());

  final fristname_controller = BehaviorSubject<String>();
  final mobile_controller = BehaviorSubject<String>();
  final email_controller = BehaviorSubject<String>();
  final password_controller = BehaviorSubject<String>();
  final lastname_controller = BehaviorSubject<String>();

  Function(String) get fristname_change => fristname_controller.sink.add;
  Function(String) get mobile_change  => mobile_controller.sink.add;
  Function(String) get email_change => email_controller.sink.add;
  Function(String) get password_change => password_controller.sink.add;
  Function(String) get lastname_change => lastname_controller.sink.add;

  Stream<String> get fristname => fristname_controller.stream.transform(firstname_validator);
  Stream<String> get mobile => mobile_controller.stream.transform(phone_validator);
  Stream<String> get email => email_controller.stream.transform(email_validator);
  Stream<String> get password => password_controller.stream.transform(password_validator);
  Stream<String> get lastname => lastname_controller.stream.transform(lastname_validator);

  Stream<bool> get submitCheck => Rx.combineLatest5(fristname, mobile, email, password,lastname ,(a, b, c, d,e) => true);


  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is click){
      yield Loading(model: null);
      var response = await AuthenticationRepository.signUp(
        firstname:   fristname_controller.value,
        mobile: StaticData.country_code + mobile_controller.value,
        email: email_controller.value,
        password: password_controller.value,
        lastname:  lastname_controller.value,
      );
      if(response.success == "true" ){
        sharedPreferenceManager.writeData(CachingKey.USER_NAME, fristname_controller.value);
        sharedPreferenceManager.writeData(CachingKey.FORGET_PASSWORD_PHONE, StaticData.country_code +mobile_controller.value);
        sharedPreferenceManager.writeData(CachingKey.EMAIL,email_controller.value);
        StaticData.user_mobile_number = StaticData.country_code +mobile_controller.value;
        yield Done(model:response);
      }
      else if (response.success == "false"){
        yield ErrorLoading(model: response);
      }

    }

  }

  @override
  void dispose() {
    fristname_controller?.close();
    mobile_controller?.close();
    email_controller?.close();
    password_controller?.close();
  }


}

SignUpBloc signUpBloc = new SignUpBloc(null!);


