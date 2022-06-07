import 'package:almajidoud/utils/file_export.dart';

class CartProvider extends ChangeNotifier{
  double? cart_grand_total = 0.0;
  void update_cart_grand_total({double? grand}){
    cart_grand_total = grand;
    notifyListeners();
  }
}