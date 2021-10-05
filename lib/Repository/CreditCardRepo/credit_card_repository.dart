import 'dart:convert';

import 'package:almajidoud/Model/CreditCardModel/credit_card_list_model.dart';
import 'package:almajidoud/Model/CreditCardModel/credit_card_model.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';

class CardCardRepository {

  Future<CreditCardModel> add_user_credit_card({var holder_name, var number , var exp_year , var exp_month, var default_card})async{
    print("default : ${default_card}");
    FormData formData=FormData.fromMap({
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      "holder_name" : holder_name,
      "number" : number,
      "exp_year" :  exp_year,
      "exp_month" :  exp_month,
      "default_card" : default_card
    });
    return NetworkUtil.internal().post(CreditCardModel(), Urls.ADD_CREDIT_CARD,body: formData);
  }

  Future<CreditCardListModel> getCreditCardList() async{
    Map<String, String> headers = {
      'token': await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
    };
    return NetworkUtil.internal().get(CreditCardListModel(), Urls.GET_ALL_CREDIT_CARD, headers: headers);
  }

  Future<CreditCardModel> delete_user_credit_card({List<int> id})async{
    FormData formData=FormData.fromMap({
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      "ids" : json.encode(id),

    });
    return NetworkUtil.internal().post(CreditCardModel(), Urls.DELETE_CREDIT_CARD,body: formData);
  }

  Future<CreditCardModel> update_user_credit_card(
      {var card_id, var holder_name, var number , var exp_year , var exp_month ,var default_card})async{
    FormData formData=FormData.fromMap({
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      "holder_name" : holder_name,
      "number" : number,
      "exp_year" :  exp_year,
      "exp_month" :  exp_month,
      "default_card" : default_card
    });
    return NetworkUtil.internal().post(CreditCardModel(), Urls.UPDATE_CREDIT_CARD + '/${card_id}',body: formData);
  }
}
final creditCard_repository = CardCardRepository();