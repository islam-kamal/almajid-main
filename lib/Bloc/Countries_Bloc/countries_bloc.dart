import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';
import 'package:almajidoud/Model/CountriesModel/countries_model.dart';
import 'package:almajidoud/Repository/CountriesRepo/countries_repoistory.dart';
class CountriesBloc extends Bloc<AppEvent, AppState> with Validator{
  CountriesBloc(AppState initialState) : super(initialState);

  BehaviorSubject<List<CountriesModel>> _countries_subject = new BehaviorSubject<List<CountriesModel>>();
  get countries_subject {
    return _countries_subject;
  }

  void drainStream() {
    _countries_subject.value = null;
  }
  void get_countries() async{
    var response =await countriesRepository.getCountriesList(
    );
    print('countries--- response : ${response}');
    _countries_subject.sink.add(response);
  }

  //chosse aqar  value from radio button in bottom sheet
  final country_radio_value = BehaviorSubject<int>();
  BehaviorSubject<int> get country_radio_choosed_value  => country_radio_value;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is getAllCountries) {
      yield Loading();
      final response = await countriesRepository.getCountriesList();
      if (response != null) {
        _countries_subject.sink.add(response);
        yield Done(general_model: response);
      } else if (response == null) {
        yield ErrorLoading(general_model: response);
      }
    }
  }
}

CountriesBloc countriesBloc = new CountriesBloc(null);
