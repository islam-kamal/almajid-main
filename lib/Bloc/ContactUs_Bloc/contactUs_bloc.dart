
import 'package:almajidoud/Model/ContactUsModel/contactUs_model.dart';
import 'package:almajidoud/Repository/ContactUsRepo/contactUs_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class ContactUsBloc extends Bloc<AppEvent,AppState> with Validator{
  ContactUsBloc(AppState initialState) : super(initialState);

  final name_controller = BehaviorSubject<String>();
  final phone_controller = BehaviorSubject<String>();
  final email_controller = BehaviorSubject<String>();
  final subject_controller = BehaviorSubject<String>();
  final message_controller = BehaviorSubject<String>();

  Function(String) get name_change => name_controller.sink.add;
  Function(String) get phone_change  => phone_controller.sink.add;
  Function(String) get email_change => email_controller.sink.add;
  Function(String) get subject_change => subject_controller.sink.add;
  Function(String) get message_change => message_controller.sink.add;

  Stream<String> get name => name_controller.stream.transform(username_validator);
  Stream<String> get phone => phone_controller.stream.transform(phone_validator);
  Stream<String> get email => email_controller.stream.transform(email_validator);
  Stream<String> get subject => subject_controller.stream.transform(input_text_validator);
  Stream<String> get message => message_controller.stream.transform(input_text_validator);


  BehaviorSubject<ContactUsModel> _complains_subject = new BehaviorSubject<ContactUsModel>();
  get complains_subject {
    return _complains_subject;
  }
  void drainStream() {
    _complains_subject.value = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email_controller?.close();
    name_controller?.close();
    phone_controller?.close();
    subject_controller?.close();
    message_controller?.close();
  }


  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is click){
      yield Loading(model: null,indicator: 'make-complain');
      final response = await contactUsRepository.send_contact_message(
        name: name_controller.value ?? await sharedPreferenceManager.readString(CachingKey.USER_NAME),
        email: email_controller.value ?? await sharedPreferenceManager.readString(CachingKey.EMAIL),
        phone: phone_controller.value ?? await sharedPreferenceManager.readString(CachingKey.MOBILE_NUMBER),
        subject: subject_controller.value,
        message: message_controller.value
      );
      if(response.status == true){
        yield Done(model:response,indicator: 'make-complain');
      }else if (response.status == false){
        yield ErrorLoading(model: response,indicator: 'make-complain');
      }

    }else if(event is getAllComplain){
      print("----------- get-com 1");
      yield Loading(model: null);
      final response = await contactUsRepository.get_user_complains();
      print("----------- get-com 2");
      print("----------- get-com response : ${response.data}");
      if(response.status == true){
        _complains_subject.sink.add(response);
        print("----------- get-com 3");
        print("-----------  _complains_subject : ${ _complains_subject}");
        yield Done(model: response);
      }else if (response.status == false){
        print("----------- get-com 4");
        yield ErrorLoading(model: response);
      }

    }
  }

}

ContactUsBloc contactUsBloc = new ContactUsBloc(null);