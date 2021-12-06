import 'package:almajidoud/Bloc/WishList_Bloc/wishlist_bloc.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWishList extends StatefulWidget {
  bool favourite_status;
  final Color color;
  final int product_id;
  var qty;
  BuildContext context;
  CustomWishList(
      {this.favourite_status = false,
      this.color,
      this.product_id,
      this.qty,
      this.context});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomFauvourite_State();
  }
}

class CustomFauvourite_State extends State<CustomWishList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: translator.activeLanguageCode == 'ar'
            ? Alignment.topLeft
            : Alignment.topRight,
        height: StaticData.get_height(context) * .04,
        width: StaticData.get_width(context) * .7,
        child: (widget.favourite_status)
            ? IconButton(
                icon: Icon(
                  Icons.favorite,
                  size: width(context) * 0.05,
                  color: widget.color,
                ),
                onPressed: (StaticData.vistor_value == 'visitor')
                    ? () {
                  customAnimatedPushNavigation(context,SignInScreen());
                }
                    : () async {
                        await wishlist_bloc.add(removeFromWishListEvent(
                          wishlist_item_id: widget.product_id,
                        ));
                        setState(() {
                          widget.favourite_status = !widget.favourite_status;
                          wishlist_bloc.add(getAllWishList_click());
                        });
                      },
              )
            : IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  size: StaticData.get_width(context) * .04,
                  color: widget.color,
                ),
                onPressed: (StaticData.vistor_value == 'visitor')
                    ? () {
                  customAnimatedPushNavigation(context,SignInScreen());
                }
                    : () {
                        wishlist_bloc.add(AddToWishListEvent(
                            product_id: widget.product_id,
                            context: widget.context,
                            qty: widget.qty));
                        setState(() {
                          widget.favourite_status = !widget.favourite_status;
                        });
                      },
              ));
  }
}
