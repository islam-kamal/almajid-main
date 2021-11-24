import 'package:almajidoud/utils/file_export.dart';

class AddProductToCartWidget extends StatefulWidget{
  var product_quantity , product_sku;
  AddProductToCartWidget({this.product_quantity,this.product_sku});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddProductToCartWidgetState();
  }

}

class AddProductToCartWidgetState extends State<AddProductToCartWidget> with TickerProviderStateMixin{
  AnimationController _loginButtonController;
  bool isLoading = false;
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
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: StaggerAnimation(
        //   titleButton: translator.translate("Send") ,
        buttonController: _loginButtonController.view,
        btn_height: width(context) * .13,
        image: "assets/icons/right-arrow.png",
        titleButton: "Add TO Cart",
        //    isResetScreen:false,
        onTap: () {
          shoppingCartBloc.add(AddProductToCartEvent(
              context: context,
              product_quantity: widget.product_quantity,
              product_sku: widget.product_sku));
        },
      ),
    );
  }

}