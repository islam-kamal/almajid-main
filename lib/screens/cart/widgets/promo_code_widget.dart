

import 'package:almajidoud/screens/cart/widgets/promo_code_alert_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';

class PromoCodeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PromoCodeWidgetState();
  }
}

class PromoCodeWidgetState extends State<PromoCodeWidget> {
  bool radioValue = false;
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.map),
                Text(translator.translate("Promo Code"),style: TextStyle(color: mainColor,fontSize: 16),)
              ],
            ),
            Text(translator.translate("Apply promo code to avail offers"),style: TextStyle(color: white_gray_color,fontSize: 10),)
          ],
        )
        ),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: radioValue,
                  activeColor: mainColor,
                  onChanged: (value) {
                    setState(() {
                      radioValue = value;
                      promoCodeAlertDialog(base_context: context);
                    });
                  },
                ),
                Text(translator.translate('Apply')),

                Checkbox(
                  value: !radioValue,
                  activeColor: mainColor,
                  onChanged: (value) {
                    setState(() {
                      radioValue = value;
                    });
                    shoppingCartBloc.add(DeletePromoCodeEvent(
                      context: context
                    ));
                  },
                ),
                Text(translator.translate('Cancel')),
              ],
            ),
        )
      ],
    );
  }
}
