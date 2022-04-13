import 'package:almajidoud/Base/network-mappers.dart';

class GuestShipmentAddressModel extends BaseMappable{
  List<PaymentMethods>? paymentMethods;
  Totals? totals;
  String? message;
  Parameters? parameters;
  GuestShipmentAddressModel({this.paymentMethods, this.totals,this.message,this.parameters});

  GuestShipmentAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['payment_methods'] != null) {
      paymentMethods = [];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(new PaymentMethods.fromJson(v));
      });
    }
    totals =
    json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentMethods != null) {
      data['payment_methods'] =
          this.paymentMethods!.map((v) => v.toJson()).toList();
    }
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }

    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    if (json['payment_methods'] != null) {
      paymentMethods = [];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(new PaymentMethods.fromJson(v));
      });
    }
    totals =
    json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    return GuestShipmentAddressModel(paymentMethods: paymentMethods,totals: totals,message: message,parameters: parameters);
  }
}

class PaymentMethods {
  var code;
  var title;

  PaymentMethods({this.code, this.title});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    return data;
  }
}

class Totals {
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

  Totals(
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
        this.totalSegments});

  Totals.fromJson(Map<String, dynamic> json) {
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
      items = [];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['total_segments'] != null) {
      totalSegments = [];
      json['total_segments'].forEach((v) {
        totalSegments!.add(new TotalSegments.fromJson(v));
      });
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
  var name;
  var extensionAttributes;

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
        this.name,
      this.extensionAttributes});

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
    name = json['name'];
    extensionAttributes = json['extension_attributes'];
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
    data['name'] = this.name;
    return data;
  }
}

class TotalSegments {
  var code;
  var title;
  var value;
  ExtensionAttributes? extensionAttributes;
  var area;

  TotalSegments(
      {this.code, this.title, this.value, this.extensionAttributes, this.area});

  TotalSegments.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    value = json['value'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    data['value'] = this.value;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes!.toJson();
    }
    data['area'] = this.area;
    return data;
  }
}

class ExtensionAttributes {
  List<TaxGrandtotalDetails>? taxGrandtotalDetails;

  ExtensionAttributes({this.taxGrandtotalDetails});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    if (json['tax_grandtotal_details'] != null) {
      taxGrandtotalDetails = [];
      json['tax_grandtotal_details'].forEach((v) {
        taxGrandtotalDetails!.add(new TaxGrandtotalDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.taxGrandtotalDetails != null) {
      data['tax_grandtotal_details'] =
          this.taxGrandtotalDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaxGrandtotalDetails {
  var amount;
  List<Rates>? rates;
  var groupId;

  TaxGrandtotalDetails({this.amount, this.rates, this.groupId});

  TaxGrandtotalDetails.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    if (json['rates'] != null) {
      rates = [];
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
  String? fieldName;
  String? fieldValue;

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