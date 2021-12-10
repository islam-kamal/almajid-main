import 'dart:async';

import 'package:almajidoud/Bloc/WishList_Bloc/wishlist_bloc.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomWishList extends StatefulWidget {
  final Color color;
  final int product_id;
  var qty;
  Widget screen;
  BuildContext context;
  GlobalKey<ScaffoldState> scafffoldKey;

  CustomWishList({this.color, this.product_id, this.qty, this.context,this.screen,this.scafffoldKey});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomFauvourite_State();
  }
}

class CustomFauvourite_State extends State<CustomWishList> {
  List<int> fav_salon_id;
  List<int> wishlist_id;
  List<Map> wishlist_items;
  @override
  void initState() {
    fav_salon_id = [];
    wishlist_id = [];
    wishlist_items = [];

    super.initState();
  }

  void get_wishlist_ids()async{

    wishlist_items = await sharedPreferenceManager.getListOfMaps('wishlist_data_ids');


  }
  @override
  Widget build(BuildContext context) {
    if (StaticData.vistor_value == 'visitor') {
      fav_salon_id = [];
    } else {
      wishlist_items.forEach((element) {
        element.keys.forEach((k) {
          wishlist_id.add(int.parse(k));
        });

        element.values.forEach((v) {
          fav_salon_id.add(v);
        });
      });

    }


    return  Container(
        alignment: translator.activeLanguageCode == 'ar'
            ? Alignment.topLeft
            : Alignment.topRight,
        height: StaticData.get_height(context) * .04,
        width: StaticData.get_width(context) * .7,
        child:  fav_salon_id.contains(widget.product_id)
            ? IconButton(
                icon: Icon(
                  Icons.favorite,
                  size: width(context) * 0.05,
                  color: widget.color,
                ),
                onPressed: (StaticData.vistor_value == 'visitor')
                    ? () {
                        customAnimatedPushNavigation(context, SignInScreen());
                      }
                    : () async{
                var item_id= wishlist_id[fav_salon_id.indexOf(widget.product_id)]  ;
                print("item_id : :: ${item_id}");
                  await wishlist_bloc.add(removeFromWishListEvent(
                    wishlist_item_id: item_id,

                  ));
                  await wishlist_bloc.add(getAllWishList_click(
                    context: context,
                    scafffoldKey: widget.scafffoldKey
                  ));


                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContextcontext) => widget.screen));
                 setState(()  {

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
                        customAnimatedPushNavigation(context, SignInScreen());
                      }
                    : ()async {
                  wishlist_bloc.add(AddToWishListEvent(
                      product_id: widget.product_id,
                      context: widget.context,
                      qty: widget.qty));
                  await wishlist_bloc.add(getAllWishList_click(
                      context: context,
                      scafffoldKey: widget.scafffoldKey
                  ));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContextcontext) => widget.screen));
                  setState(()  {

                        });
                      },
              ));
  }
}
