import 'package:rxdart/rxdart.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/client/address_model.dart';
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
  Stream<String> get  email =>  email_controller.stream.transform(email_validator);
  Stream<String> get  phone =>  phone_controller.stream.transform(phone_validator);
  Stream<String> get  street =>  street_controller.stream.transform(input_text_validator);


  BehaviorSubject<AddressModel> _address_details_subject = new BehaviorSubject<AddressModel>();
  get address_details_subject{
    return _address_details_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is GuestAddAdressEvent){
      yield Loading(model: null,indicator: 'GuestAddAdress');
      var response = await shipmentAddressRepository.add_addresses(
        context: event.context
      );
      print("response : ${response}");
      if(response.message == null){
        yield Done(model:response,indicator: 'GuestAddAdress');
      }else {
        yield ErrorLoading(model: response,indicator: 'GuestAddAdress');
      }
    }
    else if(event is AddNewAdressEvent){
      yield Loading(model: null,indicator: 'AddNewAdress');
      var response = await shipmentAddressRepository.add_new_address(
          context: event.context
      );
      if(response.message == null){
        yield Done(model:response,indicator: 'AddNewAdress');
      }else {
        yield ErrorLoading(model: response,indicator: 'AddNewAdress');
      }
    }

    else if(event is AddressDetailsEvent){
      yield Loading();
      var response = await shipmentAddressRepository.get_addresss_details(
        address_id: event.address_id
      );
      if(response.message == null){
        _address_details_subject.sink.add(response);
        yield Done(model: response, indicator: 'address_detials');
      }else{
        yield ErrorLoading(model: response, indicator: 'address_detials');
      }
    }
    else if (event is GetAllAddressesEvent) {
      yield Loading(indicator: 'GetAllAddressesEvent');
      final response = await shipmentAddressRepository.get_all_saved_addresses(context: event.context);

      if (response.isEmpty ) {
        yield ErrorLoading(indicator: 'GetAllAddressesEvent');

      } else {
        yield Done(indicator: 'GetAllAddressesEvent');

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