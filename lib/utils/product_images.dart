import 'package:almajidoud/Base/urls.dart';

class ProductImages{
  static String getProductImageUrlByName({ imageName}) {
    print("imageName : ${imageName}");
    return '${Urls.BASE_URL}/pub/media/catalog/product/$imageName';
  }
}