class CartItemModel {
  CartItem? cartItem;

  CartItemModel({this.cartItem});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    cartItem = json['cartItem'] != null
        ? new CartItem.fromJson(json['cartItem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItem != null) {
      data['cartItem'] = this.cartItem!.toJson();
    }
    return data;
  }
}

class CartItem {
  var sku;
  var qty;
  var quoteId;

  CartItem({this.sku, this.qty, this.quoteId});

  CartItem.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    qty = json['qty'];
    quoteId = json['quote_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    data['quote_id'] = this.quoteId;
    return data;
  }
}