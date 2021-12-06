import 'package:rxdart/rxdart.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Repository/ShippmentAdressRepo/shipment_address_repository.dart';
class ShipmentAddressBloc extends Bloc<AppEvent,AppState> with Validator{
  ShipmentAddressBloc(AppState initialState) : super(initialState);

  final frist_name_controller = BehaviorSubject<String>();
  final last_name_controller = BehaviorSubject<String>();
  final email_controller = BehaviorSubject<String>();
  final phone_controller = BehaviorSubject<String>();
  final street_controller = BehaviorSubject<String>();


  Function(String) get frist_name_change => frist_name_controller.sink.add;
  Function(String) get last_name_change  => last_name_controller.sink.add;
  Function(String) get email_change  => email_controller.sink.add;
  Function(String) get phone_change  => phone_controller.sink.add;
  Function(String) get street_change  => street_controller.sink.add;

  Stream<String> get frist_name => frist_name_controller.stream.transform(input_text_validator);
  Stream<String> get last_name => last_name_controller.stream.transform(input_text_validator);
  Stream<String> get  email =>  email_controller.stream.transform(input_text_validator);
  Stream<String> get  phone =>  phone_controller.stream.transform(input_number_validator);
  Stream<String> get  street =>  street_controller.stream.transform(input_text_validator);








  /* void get_addresses_list() async{
    var response =await address_repository.getAddressList();
    print('------------(response)---- : ${response}');
    _address_list_subject.sink.add(response);
  }*/

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is GuestAddAdressEvent){
      yield Loading(model: null);
      var response = await shipmentAddressRepository.add_addresses(
        context: event.context
      );
      print("shippment response : $response");
      if(response.message == null){
        yield Done(model:response);
      }else {
        yield ErrorLoading(model: response);
      }
    }
    else if(event is AddNewAdressEvent){
      yield Loading(model: null);
      var response = await shipmentAddressRepository.add_new_address(
          context: event.context
      );
      print("shippment response : $response");
      if(response.message == null){
        yield Done(model:response,indicator: 'AddNewAdress');
      }else {
        yield ErrorLoading(model: response,indicator: 'AddNewAdress');
      }
    }
  }

  @override
  void dispose() async{
    frist_name_controller?.close();
    last_name_controller?.close();

  }


}
final shipmentAddressBloc = new ShipmentAddressBloc(null);