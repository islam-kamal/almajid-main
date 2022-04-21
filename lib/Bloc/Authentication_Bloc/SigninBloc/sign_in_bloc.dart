import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/auth/get_started_screen.dart';
import 'package:almajidoud/screens/auth/sing_in_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';


class SigninBloc extends Bloc<AppEvent,AppState> with Validator {

    SigninBloc():super(Start()){
      on<click>(_onClick);
      on<UserInfoClick>(_onUserInfo);
    }


    final email_controller = BehaviorSubject<String?>();
    final password_controller = BehaviorSubject<String?>();

    Function(String?) get email_change => email_controller.sink.add;
    Function(String?) get password_change => password_controller.sink.add;

    Stream<String?> get email => email_controller.stream.transform(email_validator);
    Stream<String?> get password => password_controller.stream.transform(password_validator);

    Stream<bool?> get submit_check => Rx.combineLatest2(email, password, (a, b) => true);


    Future<void> _onClick(click event , Emitter<AppState> emit)async{
      emit( Loading(model: null));
      var response = await AuthenticationRepository.signIn(
          context: event.context,
          email: email_controller.value,
          password:  password_controller.value);
      sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN,response);
      if(response != null){
        emit( Done(general_value: response));

      }else{
        emit( ErrorLoading());

      }
    }

    Future<void> _onUserInfo(UserInfoClick event , Emitter<AppState> emit)async{
      emit( Loading(model: null));
      var response = await AuthenticationRepository.get_user_info(
        token: event.token,
      );
      if(response != null){
        sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.firstname! +' '+ response.lastname! );
        sharedPreferenceManager.writeData(CachingKey.CUSTOMER_ID, response.id );
        sharedPreferenceManager.writeData(CachingKey.EMAIL, response.email );
        final mobileElement = response.customAttributes!.firstWhere((element) => element.attributeCode == 'mobile_number');
        sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, mobileElement.value );
        await _updateUserToken(customerId: response.id);
        emit( Done(model:response));
      }else{
        emit( ErrorLoading(model: response));
      }
    }

  @override
  void dispose() {
    // TODO: implement dispose
    email_controller.close();
    password_controller.close();

  }

   _updateUserToken({int? customerId}) async{
    //get the current device token
    String? deviceToken  = await FirebaseMessaging.instance.getToken();
    await AuthenticationRepository.updateDeviceToken(customerId: customerId,deviceToken: deviceToken);
  }



}
final signIn_bloc = SigninBloc();