import 'package:almajidoud/Repository/PaymentRepo/payment_repository.dart';
import 'package:almajidoud/utils/file_export.dart';

import 'package:rxdart/rxdart.dart';

class PaymentBloc extends Bloc<AppEvent,AppState> with Validator{
  PaymentBloc(AppState initialState) : super(initialState);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is PayByCreditCardEvent) {
      yield Loading(indicator: 'credit_card');
      final response = await paymentRepository.pay_by_credit_card(
         order_id: event.order_id,
        card_id: event.card_id,
        cvv: event.cvv,
        amount: event.amount,
      );
      if (response.status == true) {
        yield Done(model: response,indicator: 'credit_card');
      } else if (response.status == false) {
        yield ErrorLoading(model: response,indicator: 'credit_card');
      }
    }
  }

}

PaymentBloc paymentBloc = new PaymentBloc(null);