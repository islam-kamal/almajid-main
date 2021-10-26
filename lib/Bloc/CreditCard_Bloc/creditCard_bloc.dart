import 'package:almajidoud/Model/CreditCardModel/credit_card_list_model.dart';
import 'package:almajidoud/Repository/CreditCardRepo/credit_card_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardBloc extends Bloc<AppEvent,AppState> with Validator{
  CreditCardBloc(AppState initialState) : super(initialState);

  final holder_name_controller = BehaviorSubject<String>();
  final number_controller = BehaviorSubject<String>();
  final exp_year_controller = BehaviorSubject<String>();
  final exp_month_controller = BehaviorSubject<String>();

  Function(String) get holder_name_change => holder_name_controller.sink.add;
  Function(String) get number_change  => number_controller.sink.add;
  Function(String) get exp_year_change  => exp_year_controller.sink.add;
  Function(String) get exp_month_change  => exp_month_controller.sink.add;


  Stream<String> get holder_name => holder_name_controller.stream.transform(username_validator);
  Stream<String> get number => number_controller.stream.transform(credit_card_number_validator);
  Stream<String> get exp_year => exp_year_controller.stream.transform(credit_card_exp_year_validator);
  Stream<String> get exp_month => exp_month_controller.stream.transform(credit_card_exp_month_validator);


  final BehaviorSubject<CreditCardListModel> _credit_card_list_subject = BehaviorSubject<CreditCardListModel>();
  @override
  get credit_card_list_subject {
    return _credit_card_list_subject;
  }

  @override
  void drainStream() {
    _credit_card_list_subject.value = null;
  }

  void get_credit_card_list() async{
    var response =await creditCard_repository.getCreditCardList();
    print('------------(response)---- : ${response}');
    _credit_card_list_subject.sink.add(response);
  }



  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is click){
      yield Loading(model: null);
      var response = await creditCard_repository.add_user_credit_card(
         holder_name: holder_name_controller.value,
          number: number_controller.value,
          exp_month: exp_month_controller.value,
          exp_year: exp_year_controller.value,
          default_card:await sharedPreferenceManager.readInteger(CachingKey.DEFAULT_CREDIT_CARD) ,
      );
      if(response.status ==true){
        yield Done(model:response);
      }else if (response.status == false){
        yield ErrorLoading(model: response);
      }
    }else if(event is updateCreditCard){
      yield Loading(model: null,indicator: 'update_card');
      var response = await creditCard_repository.update_user_credit_card(
          card_id: event.card_id,
        holder_name: holder_name_controller.value,
        number: number_controller.value,
        exp_month: exp_month_controller.value,
        exp_year: exp_year_controller.value,
        default_card:await sharedPreferenceManager.readInteger(CachingKey.DEFAULT_CREDIT_CARD) ,
      );
      if(response.status ==true){
        yield Done(model:response,indicator: 'update_card');
      }else if (response.status == false){
        yield ErrorLoading(model: response,indicator: 'update_card');
      }
    }else if(event is getAllCreditCard_click){
      yield Loading();
      var response =await creditCard_repository.getCreditCardList();
      if(response.status==true){
        _credit_card_list_subject.sink.add(response);
        yield  Done(model: response);

      }else{
        yield   ErrorLoading(model: response);
      }

    }
  }


  @override
  void dispose() async{
    holder_name_controller?.close();
    number_controller?.close();
    exp_year_controller?.close();
    exp_month_controller?.close();
    await _credit_card_list_subject.drain();
    _credit_card_list_subject.close();
  }


}

final creditCard_bloc = CreditCardBloc(null);