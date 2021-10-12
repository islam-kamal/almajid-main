import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  void dispose() {}
}

class ForgetPasswordBloc extends Bloc<AppEvent, AppState>
    with Validator
    implements BaseBloc {
  final AuthenticationRepository _authenticationRepository;
  ForgetPasswordBloc(this._authenticationRepository) : super(Start());
  SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  final mobile_controller = BehaviorSubject<String>();
  Function(String) get mobile_change => mobile_controller.sink.add;
  Stream<String> get mobile =>
      mobile_controller.stream.transform(phone_validator);

  final code_controller = BehaviorSubject<String>();
  Function(String) get code_change => code_controller.sink.add;
  Stream<String> get code => code_controller.stream.transform(code_validator);

  final password_controller = BehaviorSubject<String>();
  Function(String) get password_change => password_controller.sink.add;
  Stream<String> get password =>
      password_controller.stream.transform(password_validator);

  final confirm_password_controller = BehaviorSubject<String>();
  Function(String) get confirm_password_change =>
      confirm_password_controller.sink.add;
  Stream<String> get confirm_password =>
      confirm_password_controller.stream.transform(password_validator);

  final country_code_controller = BehaviorSubject<String>();
  Function(String) get country_code_change => country_code_controller.sink.add;
  Stream<String> get country_code => country_code_controller.stream.transform(input_text_validator);

  Stream<bool> get submit_check => Rx.combineLatest2(confirm_password, password, (a, b) => true);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    String user_phone;
    //send otp Api handle
    if (event is sendOtpClick) {
      yield Loading(model: null);
     // print(mobile_controller.value);
      var response = await AuthenticationRepository.sendVerificationCode(event.phone,event.route);
      if (response.success == "true") {
        sharedPreferenceManager.writeData(
            CachingKey.FORGET_PASSWORD_PHONE, event.phone);
        yield Done(model: response);
      } else {
        yield ErrorLoading(response);
      }
    }
    //check otp Api handle
    else if (event is checkOtpClick) {
      yield Loading(model: null, indicator: 'checkOtpClick');
      await sharedPreferenceManager
          .readString(CachingKey.FORGET_PASSWORD_PHONE)
          .then((value) => user_phone = value);
      var response = await AuthenticationRepository.checkOtpCode(
          user_phone, event.otp_code,event.route);
      if (response.success == "true") {
        sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.token);
      yield Done(model: response, indicator: 'checkOtpClick');
      } else {
        yield ErrorLoading(response);
      }
    }
    //resend otp Api hamdle
    else if (event is resendOtpClick) {
      yield Loading(model: null, indicator: 'resendOtpClick');
      await sharedPreferenceManager.readString(CachingKey.FORGET_PASSWORD_PHONE).then((value) => user_phone = value);
      var response = await AuthenticationRepository.resendOtp( user_phone,event.route);

      if (response.success == "true") {
        yield Done(model: response, indicator: 'resendOtpClick');
      } else {
        yield ErrorLoading(response);
      }
    }

    else if (event is changePasswordClick) {
      yield Loading(model: null);
      print('password : ${password_controller.value}');
      print('confirm_password : ${confirm_password_controller.value}');
      await sharedPreferenceManager
          .readString(CachingKey.FORGET_PASSWORD_PHONE)
          .then((value) => user_phone = value);
      var response;
      if(password_controller.value != confirm_password_controller.value){
        yield ErrorLoading(response,message: translator.translate("Passwords are not identical"));

      }else{
         response = await AuthenticationRepository.changePassword(user_phone, password_controller.value, );
        print("reset response : ${response.succeess}");

         if (response.succeess == "true") {
           yield Done(model: response);
         } else {
           yield ErrorLoading(response);
         }
      }

    }

  }

  @override
  void dispose() {
    mobile_controller?.close();
    code_controller?.close();
  }
}

final forgetPassword_bloc = new ForgetPasswordBloc(null);
