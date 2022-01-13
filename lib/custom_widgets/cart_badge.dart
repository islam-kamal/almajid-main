import 'package:almajidoud/Bloc/Shopping_Cart_Bloc/shopping_cart_bloc.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CartBadge extends StatefulWidget {
  final Color iconColor;

  CartBadge({this.iconColor = Colors.white});

  @override
  _CartBadgeState createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {
  bool _isLoading = false;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartBloc, AppState>(
      bloc: shoppingCartBloc,
      builder: (context, state) {
        if (state is Loading) {
          _isLoading = true;
        } else if (state is Done) {
          var data = state.model as CartDetailsModel;
          if (data.message?.isEmpty != null || data.items ==null) {
            _count = 0;
          } else {
            _count = data.items.length;
          }
        }

        return _isLoading
            ? CircularProgressIndicator()
            : InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => CartScreen()));
                },
                child: Badge(
                  badgeColor: cartBadgeColor,
                  animationType: BadgeAnimationType.slide,
                  toAnimate: true,
                  position: BadgePosition.topEnd(top: 5, end: 7),
                  badgeContent: Text(
                    _count.toString(),
                    style: TextStyle(color: mainColor),
                  ),
                  child: IconButton(
                    icon: Icon(
                      MaterialCommunityIcons.cart,
                      color: widget.iconColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => CartScreen()));
                    },
                  ),
                ),
              );
      },
    );
  }
}
