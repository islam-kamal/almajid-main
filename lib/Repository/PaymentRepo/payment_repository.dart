
import 'package:almajidoud/Model/PaymentModel/credit_card_pay_model.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';



class PaymentRepository{


  Future<CreditCardPayModel> pay_by_credit_card({int card_id,String amount, int order_id,String cvv})async{
    FormData formData=FormData.fromMap({
      'token' :  await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      "card_id" : card_id,
      "cvv" : cvv,
      "amount":amount,
      "order_id" : order_id
    });

    return NetworkUtil.internal().post(CreditCardPayModel(), Urls.CREDIT_CARD_PAY,body: formData);
  }

/*  Future<void> hyperpay_payment({ int amount, int user_id, int order_id, BuildContext context}) async {
    print('payment 1');
    Dio dio = new Dio();
    var token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'token': token,
    };
    try {
      FormData _formData = FormData.fromMap({
        'token': token,
        'amount': '${amount}',
        'user_id': '${user_id}',
        'order_id': '${order_id}',
      });
      print('payment 2');
      final response = await dio.post('https://eazyhyper.wothoq.co/api/user/payments/PayUrl',
          data: _formData,
      );
      print('payment response : ${response}');
      print('payment 3');
      if (response.data['status']) {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=> PaymentWebView(
              url: response.data['data'],
            )));
      } else {
        errorDialog(context: context, text: response.data['msg']);

      }
    } catch (e) {
      print('payment 11');
      print('getPaymentResponse errorr');
      errorDialog(context: context, text: e.toString());
    }
  }*/


}

PaymentRepository paymentRepository = new PaymentRepository();