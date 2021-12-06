import 'package:almajidoud/Model/OffersModel/offer_model.dart';
import 'package:almajidoud/utils/file_export.dart';


class OfferRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<OfferModel> getOffersList() async{

    Map<String, String> headers = {
      'lang': translator.activeLanguageCode,
    };
    return NetworkUtil.internal().get(OfferModel(), Urls.GET_ALL_OFFERS, headers: headers);
  }
}
OfferRepository offerRepository = new OfferRepository();