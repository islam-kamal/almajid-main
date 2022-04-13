import 'dart:async';

import 'package:almajidoud/Bloc/WishList_Bloc/wishlist_bloc.dart';
import 'package:almajidoud/Repository/WishListRepo/wishlist_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomWishList extends StatefulWidget {
  final Color? color;
  final int? product_id;
  var qty;
  Widget? screen;
  BuildContext? context;
  GlobalKey<ScaffoldState>? scafffoldKey;
  bool? in_wishlist;
  CustomWishList({this.color, this.product_id, this.qty, this.context,this.screen,this.scafffoldKey,this.in_wishlist = false});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomFauvourite_State();
  }
}

class CustomFauvourite_State extends State<CustomWishList> {
  List<int>? wishlist_elements_list;
  List<int>? wishlist_id;
  bool wishlist_status = false;
  @override
  void initState() {
    wishlist_elements_list = [];
    wishlist_id = [];
    if (StaticData.vistor_value == 'visitor') {
      wishlist_elements_list = [];
    } else {
      StaticData.wishlist_items!.forEach((element) {
        element.keys.forEach((k) {
          wishlist_id!.add(int.parse(k));
        });

        element.values.forEach((v) {
          wishlist_elements_list!.add(v);
        });
      });
      if( widget.in_wishlist == true){
        wishlist_status = true;
      }else{
        wishlist_status =wishlist_elements_list!.contains(widget.product_id);
      }


    }
    super.initState();
  }
  void get_wishlist_ids()async {
    await sharedPreferenceManager.getListOfMaps('wishlist_data_ids').then((
        value) {
      StaticData.wishlist_items = value;
    });
  }
  @override
  Widget build(BuildContext context) {



    return  Container(
        alignment: translator.activeLanguageCode == 'ar'
            ? Alignment.topLeft
            : Alignment.topRight,
        height: StaticData.get_height(context) * .04,
      //  width: StaticData.get_width(context) * .7,
        child:  wishlist_status
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
                  setState(() {
                    wishlist_status = !wishlist_status;
                  });
                var item_id= wishlist_id![wishlist_elements_list!.indexOf(widget.product_id!)]  ;

                   wishlist_bloc.add(removeFromWishListEvent(
                    wishlist_item_id: item_id,
                  ));
                   wishlist_bloc.add(getAllWishList_click(
                    context: context,
                    scafffoldKey: widget.scafffoldKey
                  ));

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
                  customAnimatedPushNavigation(context, SignInScreen());}
                    : ()async {
                  setState(() {
                    wishlist_status = !wishlist_status;
                  });
                  wishlist_bloc.add(AddToWishListEvent(
                      product_id: widget.product_id,
                      context: widget.context,
                      qty: widget.qty));
                   wishlist_bloc.add(getAllWishList_click(
                      context: context,
                      scafffoldKey: widget.scafffoldKey
                  ));

                      },
              ));
  }
}
