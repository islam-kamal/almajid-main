import 'package:almajidoud/Model/OrdersModel/coupon_model.dart';
import 'package:almajidoud/Model/OrdersModel/order_model.dart';
import 'package:almajidoud/Repository/OrderRepo/order_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:rxdart/rxdart.dart';

class OrderBloc extends Bloc<AppEvent, AppState> {
  OrderBloc(AppState initialState) : super(initialState);

  BehaviorSubject<OrderModel> _user_orders_subject = BehaviorSubject<OrderModel>();
  get user_orders_subject {
    return _user_orders_subject;
  }


  BehaviorSubject<CouponModel> _invoice_summery_subject = BehaviorSubject<CouponModel>();
  get invoice_summery_subject {
    return _invoice_summery_subject;
  }


  final radio_value = BehaviorSubject<String>();
  BehaviorSubject<String> get radio_choosed_value => radio_value;
  selectRadioValue(String value) {
    radio_value.add(value);
    StaticData.order_status = radio_value.value;
    print("status : ${StaticData.order_status}");
  }

  dispose(){
    radio_choosed_value.value=null;
  }
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is UserOrdersEvent) {
      yield Loading();
      final response = await orderRepository.get_user_orders();
      if (response.status == true) {
        _user_orders_subject.sink.add(response);
        yield Done(model: response);
      } else if (response.status == false) {
        yield ErrorLoading(response);
      }
    }else  if (event is MakeOrderEvent) {
      yield Loading( indicator: 'make_order');
      final response = await orderRepository.make_order(
        payment_method_id: event.payment_method_id,
        location_id: event.location_id,
//        card_id:  await sharedPreferenceManager.readInteger(CachingKey.CARD_ID),
        delivery_time: event.selected_delivery_time,
        coupon: event.cupon,
        delivery_date: event.selected_delivery_date,
        products: event.product_ids,
        qty: event.products_quantity
      );
      if (response.status == true) {
        yield Done(model: response, indicator: 'make_order');
      } else if (response.status == false) {
        yield ErrorLoading(response, indicator: 'make_order');
      }
    }else  if (event is ApplyCouponEvent) {
      yield Loading(indicator: 'apply_coupon');
      final response = await orderRepository.applyCoupon(
          coupon: event.cupon,
          products: event.product_ids,
          qty: event.products_quantity
      );
      if (response.status == true) {

        _invoice_summery_subject.sink.add(response);
        yield Done(model: response, indicator: 'apply_coupon');
      } else if (response.status == false) {
        yield ErrorLoading(response, indicator: 'apply_coupon');
      }
    }




  }
  }


OrderBloc orderBloc = new OrderBloc(null);
