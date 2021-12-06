
import 'package:almajidoud/Repository/OrderRepo/order_repository.dart';
import 'package:almajidoud/utils/file_export.dart';


class OrderBloc extends Bloc<AppEvent, AppState> {
  OrderBloc(AppState initialState) : super(initialState);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is CreateOrderEvent) {
      print("vistor type : ${StaticData.vistor_value }");
      yield Loading();
      final response = await StaticData.vistor_value == 'visitor'?   orderRepository.create_guest_order(
        context: event.context,
      ) : orderRepository.create_client_order(
        context: event.context,
      );
      print("create_order response : ${response}");

      if (response == null) {
        print("create_order ErrorLoading");
        yield ErrorLoading();
      } else {
        print("create_order Done");
        yield Done();
      }
    }
  }
}


OrderBloc orderBloc = new OrderBloc(null);
