class Product {
  var prod_id;
  var prod_name;
  var prod_pricture;
  var prod_discount;
  var prod_price;
  var prod_chossed_quantity;
  var prod_main_quantity;
  var prod_price_after_discount;
  var prod_cart_status;
  var prod_order_status;

  Product({
    this.prod_id,
    this.prod_name,
    this.prod_pricture,
    this.prod_discount,
    this.prod_price,
    this.prod_chossed_quantity,
    this.prod_main_quantity,
    this.prod_price_after_discount,
    this.prod_cart_status,
    this.prod_order_status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : prod_id,
      'name': prod_name,
      'discount': prod_discount,
      'picture': prod_pricture,
      'price': prod_price,
      'chossed_quantity': prod_chossed_quantity,
      'main_quantity': prod_main_quantity,
      'price_after_discount':prod_price_after_discount,
      'cart_status':prod_cart_status,
      'order_status':prod_order_status,


    };
  }
}
