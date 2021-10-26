import 'package:almajidoud/Repository/Profile%20Repo/profile_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc extends Bloc<AppEvent,AppState> with Validator{
  ProfileBloc(AppState initialState) : super(initialState);
  final old_password_controller = BehaviorSubject<String>();
  final new_password_controller = BehaviorSubject<String>();
  final confirm_password_controller = BehaviorSubject<String>();
  final profile_name_controller = BehaviorSubject<String>();
  final profile_email_controller = BehaviorSubject<String>();
  final profile_phone_controller = BehaviorSubject<String>();

  Function(String) get old_password_change => old_password_controller.sink.add;
  Function(String) get new_password_change => new_password_controller.sink.add;
  Function(String) get confirm_password_change => confirm_password_controller.sink.add;
  Function(String) get profile_name_change => profile_name_controller.sink.add;
  Function(String) get profile_email_change => profile_email_controller.sink.add;
  Function(String) get profile_phone_change => profile_phone_controller.sink.add;

  Stream<String> get old_password => old_password_controller.stream.transform(password_validator);
  Stream<String> get new_password => new_password_controller.stream.transform(password_validator);
  Stream<String> get confirm_password => confirm_password_controller.stream.transform(password_validator);
  Stream<String> get profile_name => profile_name_controller.stream.transform(input_text_validator);
  Stream<String> get profile_email => profile_email_controller.stream.transform(email_validator);
  Stream<String> get profile_phone => profile_phone_controller.stream.transform(phone_validator);
  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is click){
      yield Loading();
      var response = await profile_repository.editMyProfilePasswordFunc(
        new_password: new_password_controller.value,
        password_confirmation:  confirm_password_controller.value,
      );
      print('editMyProfilePassword response : ${response}');
      if(response.status ==true){
        yield Done(model:response);
      }else if (response.status == false){
        yield ErrorLoading(model: response);
        print('response status : ${response.status}');

      }

    }else if( event is profileClick){
      yield Loading();
      var response = await profile_repository.editMyProfileFunc(
        name: profile_name_controller.value,
        email: profile_email_controller.value,
        phone: profile_phone_controller.value,
      );
      print('editMyProfile response : ${response}');
      if(response.status ==true){
        yield Done(model:response);
        sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data.name);
        sharedPreferenceManager.writeData(CachingKey.EMAIL, response.data.email);
        sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.data.phone);
      }else if (response.status == false){
        yield ErrorLoading(model: response);
        print('response status : ${response.status}');

      }
    }
  }
  @override
  void dispose() {
    old_password_controller?.close();
    new_password_controller?.close();
    confirm_password_controller?.close();
    profile_name_controller?.close();
    profile_email_controller?.close();
    profile_phone_controller?.close();
  }

}
final profile_bloc = ProfileBloc(null);