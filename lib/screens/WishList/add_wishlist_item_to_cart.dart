import 'package:almajidoud/Bloc/WishList_Bloc/wishlist_bloc.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddWishlistItemToCart extends StatefulWidget{
  var product_id ;
  AddWishlistItemToCart({this.product_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddWishlistItemToCartState();
  }

}
class AddWishlistItemToCartState extends State<AddWishlistItemToCart> with TickerProviderStateMixin{
  bool _isLoading = false;
  late AnimationController _loginButtonController;
  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ShoppingCartBloc, AppState>(
      bloc: shoppingCartBloc,
      builder: (context, state) {
        if (state is WishListToCartLoading &&
            state.indicator == 'add_wishlist_item_to_cart') {
          if (widget.product_id == state.id) {
            _isLoading = true;
          } else {
            _isLoading = false;
          }
        } else if (state is ErrorLoadingWishListToCart &&
            state.indicator == 'add_wishlist_item_to_cart' &&
            widget.product_id == state.id) {
          _isLoading = false;
          Fluttertoast.showToast(
              msg: translator.translate(
                  "The wishlist item does not exist."),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0);

          state = null!;
        } else if (state is DoneWishListToCartAdded &&
            state.indicator == 'add_wishlist_item_to_cart' &&
            widget.product_id == state.id) {
          _isLoading = false;
          wishlist_bloc.add(getAllWishList_click());

          Fluttertoast.showToast(
              msg:   translator.translate(
                  "product added suceesfully to cart"),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        return _isLoading
            ? CircularProgressIndicator(
        )
            : Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(4),
          child: StaggerAnimation(
            buttonController: _loginButtonController,
            btn_height:  width(context) * .08,
            btn_width: width(context) * .45,
            text_size: 0.017,
            image: "assets/icons/right-arrow.png",
            titleButton: "Add TO Cart",
            home_shape: false,

            //    isResetScreen:false,
            onTap:()async {
              wishlist_bloc.add(AddToCarFromWishListEvent(
                  context: context, qty: 1,
                  wishlist_product_id: widget.product_id)
              );
            },
          ),
        );
      },
    );

  }

}
