import 'package:rxdart/rxdart.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/client/address_model.dart';
import 'package:almajidoud/Repository/ShippmentAdressRepo/shipment_address_repository.dart';
class ShipmentAddressBloc extends Bloc<AppEvent,AppState> with Validator{

  ShipmentAddressBloc():super(Start()){
    on<GuestAddAdressEvent>(_onGuestAddAdress);
    on<AddressDetailsEvent>(_onAddressDetails);
    on<GetAllAddressesEvent>(_onGetAllAddresses);
    on<AddClientAdressEvent>(_onAddClientAdress);
    on<EditClientAdressEvent>(_onEditClientAdress);
  }



  final frist_name_controller = BehaviorSubject<String>();
  final last_name_controller = BehaviorSubject<String>();
  final email_controller = BehaviorSubject<String>();
  final phone_controller = BehaviorSubject<String>();
  final street_controller = BehaviorSubject<String>();
  final Neighbourhood_controller = BehaviorSubject<String>();

  Function(String) get frist_name_change => frist_name_controller.sink.add;
  Function(String) get last_name_change  => last_name_controller.sink.add;
  Function(String) get email_change  => email_controller.sink.add;
  Function(String) get phone_change  => phone_controller.sink.add;
  Function(String) get street_change  => street_controller.sink.add;
  Function(String) get Neighbourhood_change  => Neighbourhood_controller.sink.add;

  Stream<String> get frist_name => frist_name_controller.stream.transform(input_text_validator);
  Stream<String> get last_name => last_name_controller.stream.transform(input_text_validator);
  Stream<String> get  email =>  email_controller.stream.transform(email_validator);
  Stream<String> get  phone =>  phone_controller.stream.transform(phone_validator);
  Stream<String> get  street =>  street_controller.stream.transform(input_text_validator);
  Stream<String> get  Neighbourhood =>  Neighbourhood_controller.stream.transform(input_text_validator);

  BehaviorSubject<AddressModel> _address_details_subject = new BehaviorSubject<AddressModel>();
  get address_details_subject{
    return _address_details_subject;
  }


  Future<void> _onGuestAddAdress(GuestAddAdressEvent event, Emitter<AppState> emit) async {
    try{
      emit(Loading());
      var response = await shipmentAddressRepository.add_addresses(
          context: event.context
      );
      if(response?.message == null){
        emit(Done(model:response,indicator: 'GuestAddAdress'));
      }else {
        emit(ErrorLoading(model: response,indicator: 'GuestAddAdress'));
      }
    }catch(e){
      emit(
        ErrorLoading(message: "Failed to fetch data. Is your device online ?",
        ),
      );
    }
  }

  Future<void> _onAddressDetails(AddressDetailsEvent event , Emitter<AppState> emit)async{
    emit(Loading());
    var response = await shipmentAddressRepository.get_addresss_details(
        address_id: event.address_id
    );
    if(response.message == null){
      _address_details_subject.sink.add(response);
      emit( Done(model: response, indicator: 'address_detials'));
    }else{
      emit( ErrorLoading(model: response, indicator: 'address_detials'));
    }
  }

  Future<void> _onGetAllAddresses(GetAllAddressesEvent event , Emitter<AppState> emit)async{
    emit( Loading(indicator: 'GetAllAddressesEvent'));
    final response = await shipmentAddressRepository.get_all_saved_addresses(context: event.context);
    if (response == null ) {
      emit(  ErrorLoading(indicator: 'GetAllAddressesEvent'));
    } else {
      emit(  Done(general_model:response ,indicator: 'GetAllAddressesEvent'));

    }
  }

  Future<void> _onAddClientAdress(AddClientAdressEvent event , Emitter<AppState>  emit)async{
    emit( Loading(model: null,indicator: 'AddClientAdressEvent'));
    var response = await shipmentAddressRepository.add_client_address(
        context: event.context
    );
    if(response?.message == null){
      emit(  Done(model:response,indicator: 'AddClientAdressEvent'));
    }else {
      emit(  ErrorLoading(model: response,indicator: 'AddClientAdressEvent'));
    }
  }

  Future<void> _onEditClientAdress(EditClientAdressEvent event , Emitter<AppState> emit)async{
    emit( Loading(model: null,indicator: 'EditClientAdressEvent'));
    var response = await shipmentAddressRepository.edit_client_address(
        context: event.context
    );
    if(response?.message == null){
      emit( Done(model:response,indicator: 'EditClientAdressEvent'));
    }else {
      emit( ErrorLoading(model: response,indicator: 'EditClientAdressEvent'));
    }
  }


  @override
  void dispose() async{
    frist_name_controller.close();
    last_name_controller.close();

  }


}
final shipmentAddressBloc = new ShipmentAddressBloc();