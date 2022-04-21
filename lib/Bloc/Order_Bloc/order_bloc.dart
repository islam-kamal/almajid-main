
import 'package:almajidoud/Model/OrderModel/order_model.dart';
import 'package:almajidoud/Repository/OrderRepo/order_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';


class OrderBloc extends Bloc<AppEvent, AppState> {

  OrderBloc():super(Start()){
    on<CreateOrderEvent>(_onCreateOrder);
    on<GetAllOrderEvent>(_onGetAllOrder);
  }

  BehaviorSubject<AllOrdersModel?> _all_orders_subject = new BehaviorSubject<AllOrdersModel>();
  get all_orders_subject{
    return _all_orders_subject;
  }

  Future<void> _onCreateOrder(CreateOrderEvent event , Emitter<AppState> emit)async{
    final quoteId =  StaticData.vistor_value == 'visitor'?
    await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE)
        :await sharedPreferenceManager.readString(CachingKey.CART_QUOTE);
    emit( Loading(indicator: 'CreateOrder-$quoteId'));
    final response = await StaticData.vistor_value == 'visitor'?   orderRepository.create_guest_order(
      context: event.context,
    ) : orderRepository.create_client_order(
      context: event.context,
    );

    if (response == null) {
      emit( ErrorLoading(indicator: 'CreateOrder-$quoteId'));
    } else {
      var order_id;
      await  response.then((value){order_id = value;});
      if(order_id == null){
        // yield ErrorLoading(indicator: 'CreateOrder-$quoteId');
        customAnimatedPushNavigation(event.context!, SubmitFaieldScreen(
          reason: translator.translate("There is no enough balance"),
          faield_type: 'PaymentFailed',

        ));

      }else{
        emit( Done(indicator: 'CreateOrder-$quoteId',general_value: order_id));
      }

    }
  }

  Future<void> _onGetAllOrder(GetAllOrderEvent event , Emitter<AppState> emit)async{
    emit( Loading());
    final response = await orderRepository.get_all_orders(
        user_email: await sharedPreferenceManager.readString(CachingKey.EMAIL)
    );
    // final response = await orderRepository.getPayFortSettings();

    if (response.message != null) {
      emit( ErrorLoading());
    } else {
      _all_orders_subject.sink.add(response);
      emit( Done());
    }
  }


}


OrderBloc orderBloc = new OrderBloc();
