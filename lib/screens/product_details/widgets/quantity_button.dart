import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';

class  QuantityButton extends StatefulWidget{
  var quantity;
  QuantityButton({this.quantity});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuantityButtonState();
  }

}
class QuantityButtonState extends State<QuantityButton>{
  var qty=1;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(
              right: width(context) * .05, left: width(context) * .05),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: mainColor, width: 2),
                borderRadius: BorderRadius.circular(8)),
            width: width(context) * .4,
            height: isLandscape(context)
                ? 2 * height(context) * .06
                : height(context) * .06,
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      height: 5,
                      minWidth: StaticData.get_width(context) * 0.15,
                      onPressed: () {
                        setState(() {
                          if (qty <= 1) {
                            errorDialog(
                              context: context,
                              text:
                              "لقد نفذت الكمية من هذا المنتج",
                            );
                          } else {
                            setState(() {
                              qty--;
                              StaticData.product_qty = qty;
                            });
                          }
                        });
                      },
                      textColor: Colors.white,
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: blackColor,
                      ),

                    ),
                    quantity(),
                    MaterialButton(
                      height: 5,
                      minWidth:
                      StaticData.get_width(context) *
                          0.15,
                      onPressed: () {
                        setState(() {
                          if (qty == widget.quantity) {
                            errorDialog(
                              context: context,
                              text:
                              "لا يمكنك تخطى الكمية المتاحة",
                            );
                          } else {
                            setState(() {
                              qty++;
                              StaticData.product_qty = qty;

                            });
                          }
                        });
                      },
                      textColor: greyColor,
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: blackColor,
                      ),

                    ),

                  ],
                )),
          ),
        ),
      ],
    );
  }
  Widget quantity() {
    return Text(
      '${qty}',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

}
