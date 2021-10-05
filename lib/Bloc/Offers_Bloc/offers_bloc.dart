import 'package:almajidoud/Model/OffersModel/offer_model.dart';
import 'package:almajidoud/Repository/OfferRepo/offer_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class OffersBloc extends Bloc<AppEvent, AppState> with Validator{
  OffersBloc(AppState initialState) : super(initialState);

  BehaviorSubject<OfferModel> _offers_subject = new BehaviorSubject<OfferModel>();
  get offers_subject {
    return _offers_subject;
  }

  BehaviorSubject<String> offer_search_controller = BehaviorSubject<String>();
  Function(String) get offer_search_change => offer_search_controller.sink.add;
  Stream<String> get offer_search => offer_search_controller.stream.transform(input_text_validator);


  void drainStream() {
    _offers_subject.value = null;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is getAllOffers) {
      yield Loading();
      final response = await offerRepository.getOffersList();
      if (response.status == true) {
        _offers_subject.sink.add(response);
        yield Done(model: response);
      } else if (response.status == false) {
        yield ErrorLoading(response);
      }
    }
  }
}

OffersBloc offersBloc = new OffersBloc(null);
