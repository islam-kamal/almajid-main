
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
      print("vistor type : ${StaticData.vistor_value }");
      yield Loading(indicator: 'CreateOrder');
     final response = await StaticData.vistor_value == 'visitor'?   orderRepository.create_guest_order(
        context: event.context,
      ) : orderRepository.create_client_order(
        context: event.context,
      );
      print("create_order response : ${response}");

      if (response == null) {
        print("create_order ErrorLoading");
        yield ErrorLoading(indicator: 'CreateOrder');
      } else {
        print("create_order Done");
        yield Done(indicator: 'CreateOrder');
      }
    }
    else if (event is GetAllOrderEvent) {
      yield Loading();
      final response = await orderRepository.get_all_orders(
       user_email: await sharedPreferenceManager.readString(CachingKey.EMAIL)
      );
     // final response = await orderRepository.getPayFortSettings();

      print("GetAllOrder response : ${response}");
     if (response.message != null) {
        print("GetAllOrder ErrorLoading");
        yield ErrorLoading();
      } else {
        print("GetAllOrder Done");
        _all_orders_subject.sink.add(response);
        print("&&&&&&&77");
        yield Done();
      }
    }
  }
}


OrderBloc orderBloc = new OrderBloc(null);
