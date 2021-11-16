import 'package:almajidoud/Base/network-mappers.dart';

class AddCartModel extends BaseMappable{
  int itemId;
  String sku;
  int qty;
  String name;
  int price;
  String productType;
  String quoteId;

  AddCartModel(
      {this.itemId,
        this.sku,
        this.qty,
        this.name,
        this.price,
        this.productType,
        this.quoteId});

  AddCartModel.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    sku = json['sku'];
    qty = json['qty'];
    name = json['name'];
    price = json['price'];
    productType = json['product_type'];
    quoteId = json['quote_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['price'] = this.price;
    data['product_type'] = this.productType;
    data['quote_id'] = this.quoteId;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    sku = json['sku'];
    qty = json['qty'];
    name = json['name'];
    price = json['price'];
    productType = json['product_type'];
    quoteId = json['quote_id'];
    return AddCartModel(sku: sku,name: name,price: price,itemId: itemId,productType: productType,qty: qty,quoteId: quoteId);
  }


}