import 'package:almajidoud/Repository/PaymentRepo/payment_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class PaymentBloc extends Bloc<AppEvent, AppState> with Validator{
  PaymentBloc(AppState initialState) : super(initialState);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {

    if(event is StcSendVerificationCodeEvent){
      yield Loading();
      final response = await payment_repository.stc_pay_genertate_otp(
          context: event.context,
          phone_number: event.phone
      );
      if (response?.result != null) {
        yield Done(model: response,);
      }else{
        yield ErrorLoading(model: response,);
      }
    }

  }
}

PaymentBloc paymentBloc = new PaymentBloc(null!);
