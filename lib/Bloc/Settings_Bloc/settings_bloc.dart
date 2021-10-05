import 'package:almajidoud/Model/SettingsModel/settings_model.dart';
import 'package:almajidoud/Repository/SettingsRepo/settings_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc extends Bloc<AppEvent,AppState> with Validator{

  SettingsBloc(AppState initialState) : super(initialState);
  BehaviorSubject<SettingsModel> _app_settings_subject = BehaviorSubject<SettingsModel>();

  get app_settings_subject  {
    return _app_settings_subject;
  }


  final app_link_controller = BehaviorSubject<String>();
  Function(String) get app_link_change => app_link_controller.sink.add;
  Stream<String> get app_link => app_link_controller.stream.transform(input_text_validator);


  @override
  Stream<AppState> mapEventToState(AppEvent event)async* {
    if(event is AppSettingsEvent){
      yield Loading();
      final response = await settingsRepository.get_app_settings();
      if (response.status == true) {
        _app_settings_subject.sink.add(response);
        app_link_controller.sink.add(response.data.email);
        yield Done(model: response);
      } else if (response.status == false) {
        yield ErrorLoading(response);
      }

    }
  }

}
SettingsBloc settingsBloc = SettingsBloc(null);