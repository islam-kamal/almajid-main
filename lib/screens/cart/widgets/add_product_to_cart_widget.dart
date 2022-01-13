import 'package:almajidoud/Bloc/WishList_Bloc/wishlist_bloc.dart';
import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProductToCartWidget extends StatefulWidget {
  var product_quantity, product_sku, instock_status,btn_width,btn_height,text_size ,
      home_shape , product_image , product_id , add_wishlist_to_cart ;
  GlobalKey<ScaffoldState> scaffoldKey;

  AddProductToCartWidget(
      {this.product_quantity,
      this.product_sku,
      this.instock_status,
      this.scaffoldKey,
      this.btn_width,
      this.btn_height,
        this.text_size,
        this.home_shape = true,
        this.product_image,
        this.product_id,
        this.add_wishlist_to_cart = false
      });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddProductToCartWidgetState();
  }
}

class AddProductToCartWidgetState extends State<AddProductToCartWidget>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  bool isLoading = false;
  bool _isLoading = false;

  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartBloc, AppState>(
      bloc: shoppingCartBloc,
      builder: (context, state) {
        if (state is ProductLoading &&
            state.indicator == 'detail_add_to_cart') {
          if (widget.product_sku == state.sku) {
            _isLoading = true;
          } else {
            _isLoading = false;
          }
        } else if (state is ErrorLoadingProduct &&
            state.indicator == 'detail_add_to_cart' &&
            widget.product_sku == state.sku) {
          _isLoading = false;
          var data = state.model as AddCartModel;
          Fluttertoast.showToast(
              msg: '${data.message}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0);

          state = null;
        } else if (state is DoneProductAdded &&
            state.indicator == 'detail_add_to_cart' &&
            widget.product_sku == state.sku) {
          _isLoading = false;
          Fluttertoast.showToast(
              msg: translator.translate("product added suceesfully to cart" ),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }

        return _isLoading
            ? CircularProgressIndicator()
            : Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4),
                child: StaggerAnimation(
                  buttonController: _loginButtonController.view,
                  btn_height: widget.btn_height,
                  btn_width: widget.btn_width,
                  text_size: widget.text_size,
                  image: "assets/icons/right-arrow.png",
                  titleButton: "Add TO Cart",
                  home_shape: widget.home_shape,

                  //    isResetScreen:false,
                  onTap: widget.instock_status == false
                      ? () {
                          Flushbar(
                            messageText: Container(
                              width: StaticData.get_width(context) * 0.7,
                              child: Wrap(
                                children: [
                                  Text(
                                    translator.translate(
                                        "There is no quantity of this product in stock"),
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: whiteColor),
                                  ),
                                ],
                              ),
                            ),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: redColor,
                            flushbarStyle: FlushbarStyle.FLOATING,
                            duration: Duration(seconds: 3),
                          )..show(widget.scaffoldKey.currentState.context);
                        }
                      : ()async {
                    if(widget.add_wishlist_to_cart){
                      wishlist_bloc.add(AddToCarFromWishListEvent(
                          context: context, qty: 1,
                          wishlist_product_id: widget.product_id)
                      );
                    }else{
                      shoppingCartBloc.add(AddProductToCartEvent(
                          context: context,
                          product_quantity: widget.product_quantity,
                          product_sku: widget.product_sku,
                          indictor: 'detail_add_to_cart'));
                    }


                        },
                ),
              );
      },
    );
  }
}
