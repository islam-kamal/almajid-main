
import 'package:almajidoud/Model/OrderMode/order_model.dart';
import 'package:almajidoud/Repository/OrderRepo/order_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';


class OrderBloc extends Bloc<AppEvent, AppState> {
  OrderBloc(AppState initialState) : super(initialState);

  BehaviorSubject<AllOrdersModel> _all_orders_subject = new BehaviorSubject<AllOrdersModel>();
  get all_orders_subject{
    return _all_orders_subject;
  }
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is CreateOrderEvent) {
      final quoteId =  StaticData.vistor_value == 'visitor'?
      await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE)
          :await sharedPreferenceManager.readString(CachingKey.CART_QUOTE);
      yield Loading(indicator: 'CreateOrder-$quoteId');
     final response = await StaticData.vistor_value == 'visitor'?   orderRepository.create_guest_order(
        context: event.context,
      ) : orderRepository.create_client_order(
        context: event.context,
      );

      if (response == null) {
        yield ErrorLoading(indicator: 'CreateOrder-$quoteId');
      } else {
        var order_id;
        print("response.toString() : ${response.toString()}");
      await  response.then((value){order_id = value;});
      if(order_id == null){
       // yield ErrorLoading(indicator: 'CreateOrder-$quoteId');
        customAnimatedPushNavigation(event.context, SubmitFaieldScreen(
          reason: translator.translate("There is no enough balance"),
          faield_type: 'PaymentFailed',

        ));

      }else{
        yield Done(indicator: 'CreateOrder-$quoteId',general_value: order_id);
      }

      }
    }
    else if (event is GetAllOrderEvent) {
      yield Loading();
      final response = await orderRepository.get_all_orders(
       user_email: await sharedPreferenceManager.readString(CachingKey.EMAIL)
      );
     // final response = await orderRepository.getPayFortSettings();

     if (response.message != null) {
        yield ErrorLoading();
      } else {
        _all_orders_subject.sink.add(response);
        yield Done();
      }
    }
  }

}


OrderBloc orderBloc = new OrderBloc(null);
