
import 'package:almajidoud/Bloc/Authentication_Bloc/ForgetPasswordBloc/forget_password_bloc.dart';
import 'package:almajidoud/Helper/app_event.dart';
import 'package:almajidoud/Helper/app_state.dart';
import 'package:almajidoud/Repository/AuthenticationRepo/authentication_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:bloc/bloc.dart';

class LogoutBloc extends Bloc<AppEvent,AppState> implements BaseBloc{
  final AuthenticationRepository _authenticationRepository;
  LogoutBloc(this._authenticationRepository):super(Start());
  SharedPreferenceManager sharedPreferenceManager =SharedPreferenceManager();
  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is logoutClick){
      yield Loading(model: null);
      var response = await AuthenticationRepository.logout(await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
      if(response.success ==true){
        yield Done(model: response);
        switch(await sharedPreferenceManager.readString(CachingKey.SOCIAL_LOGIN_TYPE)){
          case 'email':
            sharedPreferenceManager.removeData(CachingKey.AUTH_TOKEN);
            sharedPreferenceManager.removeData(CachingKey.MOBILE_NUMBER);
            sharedPreferenceManager.removeData(CachingKey.EMAIL);
            sharedPreferenceManager.removeData(CachingKey.USER_NAME);
            sharedPreferenceManager.removeData(CachingKey.FORGET_PASSWORD_PHONE);
            sharedPreferenceManager.removeData(CachingKey.USER_ID);
            print("Email logout");
            break;
          case 'facebook':

            break;
          case 'twitter':

            break;
          case 'phone':
            break;
          case 'fingerprint':
            sharedPreferenceManager.removeData(CachingKey.AUTH_TOKEN);
            sharedPreferenceManager.removeData(CachingKey.MOBILE_NUMBER);
            sharedPreferenceManager.removeData(CachingKey.EMAIL);
            sharedPreferenceManager.removeData(CachingKey.USER_NAME);
            sharedPreferenceManager.removeData(CachingKey.FORGET_PASSWORD_PHONE);
            sharedPreferenceManager.removeData(CachingKey.USER_ID);
            break;

        }


      }else{
        yield ErrorLoading(model: response);
      }
    /*  switch(await sharedPreferenceManager.readString(CachingKey.SOCIAL_LOGIN_TYPE)){

       case 'facebook':
          FirebaseAuth auth ;
          FacebookLogin fbLogin ;
          fbLogin = new FacebookLogin();
          auth = FirebaseAuth.instance;
          await auth.signOut();
          await fbLogin.logOut();
       print("facebook logout");

          break;
        case 'email':

         break;

      }*/

    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
  }

}

final logout_bloc = LogoutBloc(null);