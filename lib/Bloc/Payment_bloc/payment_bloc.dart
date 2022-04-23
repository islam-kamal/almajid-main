import 'package:almajidoud/Repository/PaymentRepo/payment_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class PaymentBloc extends Bloc<AppEvent, AppState> with Validator{

  PaymentBloc():super(Start()){
    on<StcSendVerificationCodeEvent>(_onStcSendVerificationCode);
  }

  Future<void> _onStcSendVerificationCode(StcSendVerificationCodeEvent event , Emitter<AppState> emit)async{
    emit( Loading());
    final response = await payment_repository.stc_pay_genertate_otp(
        context: event.context,
        phone_number: event.phone
    );
    print("response : ${response}");
    if (response?.result != null) {
      emit(  Done(model: response,));
    }else{
      emit(  ErrorLoading(model: response,));
    }
  }

}

PaymentBloc paymentBloc = new PaymentBloc();
