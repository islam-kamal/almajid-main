import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class LanguageBloc extends Bloc<AppEvent,AppState>{
  LanguageBloc(AppState initialState) : super(initialState);

  final _lang_controller = BehaviorSubject<String>();

  Function(String) get setLanguage => _lang_controller.sink.add;

  String get lang => _lang_controller.stream.value;


  @override
  Stream<AppState> mapEventToState(AppEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}

LanguageBloc languageBloc = new LanguageBloc(null!);