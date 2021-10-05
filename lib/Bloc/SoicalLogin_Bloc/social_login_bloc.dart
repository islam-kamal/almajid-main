import 'package:almajidoud/Model/SocialLoginModel/social_login_model.dart';
import 'package:almajidoud/Repository/SocialLoginRepo/soical_login_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class SocialLoginBloc extends Bloc<AppEvent,AppState> with Validator{
  SocialLoginBloc(AppState initialState) : super(initialState);




  final BehaviorSubject<SocialLoginModel> _social_login_subject = BehaviorSubject<SocialLoginModel>();
  @override
  get social_login_subject {
    return _social_login_subject;
  }

  @override
  void drainStream() {
    _social_login_subject.value = null;
  }



  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is SocialLoginEvent){
      yield Loading(model: null);
      var response = await socialLoginRepo.social_login_func(
         name: event.name,
        email: event.email,
        provider: event.provider,
        provider_id: event.provider_id,
        firebase_token: event.firebase_token
      );
      print("social login response : ${response}");
      if(response.status ==true){
        yield Done(model:response);
        print("facebook 1");
        sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data.accessToken);
        print("provider : ${response.data.provider}");
        sharedPreferenceManager.writeData(CachingKey.SOCIAL_LOGIN_TYPE, response.data.provider);
        sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data.name);
        sharedPreferenceManager.writeData(CachingKey.EMAIL, response.data.email);
        sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.data.phone);
        print("facebook 2");
      }else if (response.status == false){
        yield ErrorLoading(response);
      }
    }
  }


  @override
  void dispose() async{
    drainStream();
  }


}

final socialLogin_bloc = SocialLoginBloc(null);