import 'package:almajidoud/utils/urls.dart';

class ProductImages{
  static String getProductImageUrlByName({ imageName}) {
    return '${Urls.BASE_URL}/pub/media/catalog/product/$imageName';
  }
}