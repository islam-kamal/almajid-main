import 'package:almajidoud/Base/network-mappers.dart';


class CartDetailsModel extends BaseMappable{
  var grandTotal;
  var baseGrandTotal;
  var subtotal;
  var baseSubtotal;
  var discountAmount;
  var baseDiscountAmount;
  var subtotalWithDiscount;
  var baseSubtotalWithDiscount;
  var shippingAmount;
  var baseShippingAmount;
  var shippingDiscountAmount;
  var baseShippingDiscountAmount;
  var taxAmount;
  var baseTaxAmount;
  var weeeTaxAppliedAmount;
  var shippingTaxAmount;
  var baseShippingTaxAmount;
  var subtotalInclTax;
  var shippingInclTax;
  var baseShippingInclTax;
  var baseCurrencyCode;
  var quoteCurrencyCode;
  var itemsQty;
  List<Items>? items;
  List<TotalSegments>? totalSegments;
  var message;
  Parameters? parameters;
  CartDetailsModel(
      {this.grandTotal,
        this.baseGrandTotal,
        this.subtotal,
        this.baseSubtotal,
        this.discountAmount,
        this.baseDiscountAmount,
        this.subtotalWithDiscount,
        this.baseSubtotalWithDiscount,
        this.shippingAmount,
        this.baseShippingAmount,
        this.shippingDiscountAmount,
        this.baseShippingDiscountAmount,
        this.taxAmount,
        this.baseTaxAmount,
        this.weeeTaxAppliedAmount,
        this.shippingTaxAmount,
        this.baseShippingTaxAmount,
        this.subtotalInclTax,
        this.shippingInclTax,
        this.baseShippingInclTax,
        this.baseCurrencyCode,
        this.quoteCurrencyCode,
        this.itemsQty,
        this.items,
        this.totalSegments,
      this.message,
        this.parameters
      });

  CartDetailsModel.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'];
    baseGrandTotal = json['base_grand_total'];
    subtotal = json['subtotal'];
    baseSubtotal = json['base_subtotal'];
    discountAmount = json['discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    subtotalWithDiscount = json['subtotal_with_discount'];
    baseSubtotalWithDiscount = json['base_subtotal_with_discount'];
    shippingAmount = json['shipping_amount'];
    baseShippingAmount = json['base_shipping_amount'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    taxAmount = json['tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    weeeTaxAppliedAmount = json['weee_tax_applied_amount'];
    shippingTaxAmount = json['shipping_tax_amount'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    subtotalInclTax = json['subtotal_incl_tax'];
    shippingInclTax = json['shipping_incl_tax'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseCurrencyCode = json['base_currency_code'];
    quoteCurrencyCode = json['quote_currency_code'];
    itemsQty = json['items_qty'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['total_segments'] != null) {
      totalSegments = <TotalSegments>[];
      json['total_segments'].forEach((v) {
        totalSegments!.add(new TotalSegments.fromJson(v));
      });
      message = json['message'];
      parameters = json['parameters'] != null
          ? new Parameters.fromJson(json['parameters'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grand_total'] = this.grandTotal;
    data['base_grand_total'] = this.baseGrandTotal;
    data['subtotal'] = this.subtotal;
    data['base_subtotal'] = this.baseSubtotal;
    data['discount_amount'] = this.discountAmount;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['subtotal_with_discount'] = this.subtotalWithDiscount;
    data['base_subtotal_with_discount'] = this.baseSubtotalWithDiscount;
    data['shipping_amount'] = this.shippingAmount;
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['shipping_discount_amount'] = this.shippingDiscountAmount;
    data['base_shipping_discount_amount'] = this.baseShippingDiscountAmount;
    data['tax_amount'] = this.taxAmount;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['weee_tax_applied_amount'] = this.weeeTaxAppliedAmount;
    data['shipping_tax_amount'] = this.shippingTaxAmount;
    data['base_shipping_tax_amount'] = this.baseShippingTaxAmount;
    data['subtotal_incl_tax'] = this.subtotalInclTax;
    data['shipping_incl_tax'] = this.shippingInclTax;
    data['base_shipping_incl_tax'] = this.baseShippingInclTax;
    data['base_currency_code'] = this.baseCurrencyCode;
    data['quote_currency_code'] = this.quoteCurrencyCode;
    data['items_qty'] = this.itemsQty;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.totalSegments != null) {
      data['total_segments'] =
          this.totalSegments!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'];
    baseGrandTotal = json['base_grand_total'];
    subtotal = json['subtotal'];
    baseSubtotal = json['base_subtotal'];
    discountAmount = json['discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    subtotalWithDiscount = json['subtotal_with_discount'];
    baseSubtotalWithDiscount = json['base_subtotal_with_discount'];
    shippingAmount = json['shipping_amount'];
    baseShippingAmount = json['base_shipping_amount'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    taxAmount = json['tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    weeeTaxAppliedAmount = json['weee_tax_applied_amount'];
    shippingTaxAmount = json['shipping_tax_amount'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    subtotalInclTax = json['subtotal_incl_tax'];
    shippingInclTax = json['shipping_incl_tax'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseCurrencyCode = json['base_currency_code'];
    quoteCurrencyCode = json['quote_currency_code'];
    itemsQty = json['items_qty'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['total_segments'] != null) {
      totalSegments = <TotalSegments>[];
      json['total_segments'].forEach((v) {
        totalSegments!.add(new TotalSegments.fromJson(v));
      });
      message = json['message'];
      parameters = json['parameters'] != null
          ? new Parameters.fromJson(json['parameters'])
          : null;
    }
    return CartDetailsModel(
        items: items,
        baseCurrencyCode: baseCurrencyCode,
        baseDiscountAmount: baseDiscountAmount,
        baseGrandTotal: baseGrandTotal,
        baseShippingDiscountAmount: baseShippingDiscountAmount,
        baseShippingAmount: baseDiscountAmount,
        baseShippingInclTax: baseShippingInclTax,
        baseShippingTaxAmount: baseShippingTaxAmount,
        baseSubtotal: baseSubtotal,
        baseTaxAmount: baseTaxAmount,
        baseSubtotalWithDiscount: baseSubtotalWithDiscount,
        discountAmount: discountAmount,
        grandTotal: grandTotal,
        itemsQty: itemsQty,
        quoteCurrencyCode: quoteCurrencyCode,
        shippingAmount: shippingAmount,
        shippingDiscountAmount: shippingDiscountAmount,
        shippingInclTax: shippingInclTax,
        shippingTaxAmount: shippingTaxAmount,
        subtotal: subtotal,
        subtotalInclTax: shippingInclTax,
        subtotalWithDiscount: subtotalWithDiscount,
        taxAmount: taxAmount,
        totalSegments: totalSegments,
        weeeTaxAppliedAmount: weeeTaxAppliedAmount,
        message: message,
        parameters: parameters);
  }
}

class Items {
  var itemId;
  var price;
  var basePrice;
  var qty;
  var rowTotal;
  var baseRowTotal;
  var rowTotalWithDiscount;
  var taxAmount;
  var baseTaxAmount;
  var taxPercent;
  var discountAmount;
  var baseDiscountAmount;
  var discountPercent;
  var priceInclTax;
  var basePriceInclTax;
  var rowTotalInclTax;
  var baseRowTotalInclTax;
  var options;
  var weeeTaxAppliedAmount;
  var weeeTaxApplied;
  ExtensionAttributes? extensionAttributes;
  var name;

  Items(
      {this.itemId,
        this.price,
        this.basePrice,
        this.qty,
        this.rowTotal,
        this.baseRowTotal,
        this.rowTotalWithDiscount,
        this.taxAmount,
        this.baseTaxAmount,
        this.taxPercent,
        this.discountAmount,
        this.baseDiscountAmount,
        this.discountPercent,
        this.priceInclTax,
        this.basePriceInclTax,
        this.rowTotalInclTax,
        this.baseRowTotalInclTax,
        this.options,
        this.weeeTaxAppliedAmount,
        this.weeeTaxApplied,
        this.extensionAttributes,
        this.name});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    price = json['price'];
    basePrice = json['base_price'];
    qty = json['qty'];
    rowTotal = json['row_total'];
    baseRowTotal = json['base_row_total'];
    rowTotalWithDiscount = json['row_total_with_discount'];
    taxAmount = json['tax_amount'];
    baseTaxAmount = json['base_tax_amount'];
    taxPercent = json['tax_percent'];
    discountAmount = json['discount_amount'];
    baseDiscountAmount = json['base_discount_amount'];
    discountPercent = json['discount_percent'];
    priceInclTax = json['price_incl_tax'];
    basePriceInclTax = json['base_price_incl_tax'];
    rowTotalInclTax = json['row_total_incl_tax'];
    baseRowTotalInclTax = json['base_row_total_incl_tax'];
    options = json['options'];
    weeeTaxAppliedAmount = json['weee_tax_applied_amount'];
    weeeTaxApplied = json['weee_tax_applied'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['price'] = this.price;
    data['base_price'] = this.basePrice;
    data['qty'] = this.qty;
    data['row_total'] = this.rowTotal;
    data['base_row_total'] = this.baseRowTotal;
    data['row_total_with_discount'] = this.rowTotalWithDiscount;
    data['tax_amount'] = this.taxAmount;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['tax_percent'] = this.taxPercent;
    data['discount_amount'] = this.discountAmount;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['discount_percent'] = this.discountPercent;
    data['price_incl_tax'] = this.priceInclTax;
    data['base_price_incl_tax'] = this.basePriceInclTax;
    data['row_total_incl_tax'] = this.rowTotalInclTax;
    data['base_row_total_incl_tax'] = this.baseRowTotalInclTax;
    data['options'] = this.options;
    data['weee_tax_applied_amount'] = this.weeeTaxAppliedAmount;
    data['weee_tax_applied'] = this.weeeTaxApplied;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes!.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class ExtensionAttributes {
  var productSku;
  var productImage;

  ExtensionAttributes({this.productSku, this.productImage});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    productSku = json['product_sku'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_sku'] = this.productSku;
    data['product_image'] = this.productImage;
    return data;
  }
}

class TotalSegments {
  var code;
  var title;
  var value;
 // ExtensionAttributes extensionAttributes;
  var area;

  TotalSegments(
      {this.code, this.title, this.value,  this.area});

  TotalSegments.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    value = json['value'];

    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    data['value'] = this.value;

    data['area'] = this.area;
    return data;
  }
}

class TaxGrandtotalDetails {
  double? amount;
  List<Rates>? rates;
  int? groupId;

  TaxGrandtotalDetails({this.amount, this.rates, this.groupId});

  TaxGrandtotalDetails.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    if (json['rates'] != null) {
      rates = <Rates>[];
      json['rates'].forEach((v) {
        rates!.add(new Rates.fromJson(v));
      });
    }
    groupId = json['group_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    if (this.rates != null) {
      data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    }
    data['group_id'] = this.groupId;
    return data;
  }
}

class Rates {
  var percent;
  var title;

  Rates({this.percent, this.title});

  Rates.fromJson(Map<String, dynamic> json) {
    percent = json['percent'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['percent'] = this.percent;
    data['title'] = this.title;
    return data;
  }
}
class Parameters {
  var fieldName;
  var fieldValue;

  Parameters({this.fieldName, this.fieldValue});

  Parameters.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
    fieldValue = json['fieldValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    data['fieldValue'] = this.fieldValue;
    return data;
  }
}