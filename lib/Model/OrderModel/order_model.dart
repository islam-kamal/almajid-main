import 'package:almajidoud/Base/network-mappers.dart';

class AllOrdersModel extends BaseMappable{
  List<OrderItems>? items;
  SearchCriteria? searchCriteria;
  var totalCount;
  var message;
  AllOrdersModel({this.items, this.searchCriteria, this.totalCount,this.message});

  AllOrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new OrderItems.fromJson(v));
      });
    }
    searchCriteria = json['search_criteria'] != null
        ? new SearchCriteria.fromJson(json['search_criteria'])
        : null;
    totalCount = json['total_count'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.searchCriteria != null) {
      data['search_criteria'] = this.searchCriteria!.toJson();
    }
    data['total_count'] = this.totalCount;
    data['message'] = this.message;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new OrderItems.fromJson(v));
      });
    }
    searchCriteria = json['search_criteria'] != null
        ? new SearchCriteria.fromJson(json['search_criteria'])
        : null;
    totalCount = json['total_count'];
    message = json['message'];
    return AllOrdersModel(message: message,totalCount: totalCount,searchCriteria: searchCriteria,items: items);
  }
}

class OrderItems {
  var baseCurrencyCode;
  var baseDiscountAmount;
  var baseGrandTotal;
  var baseDiscountTaxCompensationAmount;
  var baseShippingAmount;
  var baseShippingDiscountAmount;
  var baseShippingDiscountTaxCompensationAmnt;
  var baseShippingInclTax;
  var baseShippingTaxAmount;
  var baseSubtotal;
  var baseSubtotalInclTax;
  var baseTaxAmount;
  var baseTotalDue;
  var baseToGlobalRate;
  var baseToOrderRate;
  var billingAddressId;
  var createdAt;
  var customerEmail;
  var customerFirstname;
  var customerGroupId;
  var customerId;
  var customerIsGuest;
  var customerLastname;
  var customerNoteNotify;
  var discountAmount;
  var entityId;
  var globalCurrencyCode;
  var grandTotal;
  var discountTaxCompensationAmount;
  var incrementId;
  var isVirtual;
  var orderCurrencyCode;
  var protectCode;
  var quoteId;
  var remoteIp;
  var shippingAmount;
  var shippingDescription;
  var shippingDiscountAmount;
  var shippingDiscountTaxCompensationAmount;
  var shippingInclTax;
  var shippingTaxAmount;
  var state;
  var status;
  var storeCurrencyCode;
  var storeId;
  var storeName;
  var storeToBaseRate;
  var storeToOrderRate;
  var subtotal;
  var subtotalInclTax;
  var taxAmount;
  var totalDue;
  var totalItemCount;
  var totalQtyOrdered;
  var updatedAt;
  var weight;
  var xForwardedFor;
  List<Items>? items;
  BillingAddress? billingAddress;
  Payment? payment;
  List<StatusHistories>? statusHistories;
  ExtensionAttributes? extensionAttributes;

  OrderItems(
      {this.baseCurrencyCode,
        this.baseDiscountAmount,
        this.baseGrandTotal,
        this.baseDiscountTaxCompensationAmount,
        this.baseShippingAmount,
        this.baseShippingDiscountAmount,
        this.baseShippingDiscountTaxCompensationAmnt,
        this.baseShippingInclTax,
        this.baseShippingTaxAmount,
        this.baseSubtotal,
        this.baseSubtotalInclTax,
        this.baseTaxAmount,
        this.baseTotalDue,
        this.baseToGlobalRate,
        this.baseToOrderRate,
        this.billingAddressId,
        this.createdAt,
        this.customerEmail,
        this.customerFirstname,
        this.customerGroupId,
        this.customerId,
        this.customerIsGuest,
        this.customerLastname,
        this.customerNoteNotify,
        this.discountAmount,
        this.entityId,
        this.globalCurrencyCode,
        this.grandTotal,
        this.discountTaxCompensationAmount,
        this.incrementId,
        this.isVirtual,
        this.orderCurrencyCode,
        this.protectCode,
        this.quoteId,
        this.remoteIp,
        this.shippingAmount,
        this.shippingDescription,
        this.shippingDiscountAmount,
        this.shippingDiscountTaxCompensationAmount,
        this.shippingInclTax,
        this.shippingTaxAmount,
        this.state,
        this.status,
        this.storeCurrencyCode,
        this.storeId,
        this.storeName,
        this.storeToBaseRate,
        this.storeToOrderRate,
        this.subtotal,
        this.subtotalInclTax,
        this.taxAmount,
        this.totalDue,
        this.totalItemCount,
        this.totalQtyOrdered,
        this.updatedAt,
        this.weight,
        this.xForwardedFor,
        this.items,
        this.billingAddress,
        this.payment,
        this.statusHistories,
        this.extensionAttributes});

  OrderItems.fromJson(Map<String, dynamic> json) {
    baseCurrencyCode = json['base_currency_code'];
    baseDiscountAmount = json['base_discount_amount'];
    baseGrandTotal = json['base_grand_total'];
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'];
    baseShippingAmount = json['base_shipping_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    baseShippingDiscountTaxCompensationAmnt =
    json['base_shipping_discount_tax_compensation_amnt'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    baseSubtotal = json['base_subtotal'];
    baseSubtotalInclTax = json['base_subtotal_incl_tax'];
    baseTaxAmount = json['base_tax_amount'];
    baseTotalDue = json['base_total_due'];
    baseToGlobalRate = json['base_to_global_rate'];
    baseToOrderRate = json['base_to_order_rate'];
    billingAddressId = json['billing_address_id'];
    createdAt = json['created_at'];
    customerEmail = json['customer_email'];
    customerFirstname = json['customer_firstname'];
    customerGroupId = json['customer_group_id'];
    customerId = json['customer_id'];
    customerIsGuest = json['customer_is_guest'];
    customerLastname = json['customer_lastname'];
    customerNoteNotify = json['customer_note_notify'];
    discountAmount = json['discount_amount'];
    entityId = json['entity_id'];
    globalCurrencyCode = json['global_currency_code'];
    grandTotal = json['grand_total'];
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'];
    incrementId = json['increment_id'];
    isVirtual = json['is_virtual'];
    orderCurrencyCode = json['order_currency_code'];
    protectCode = json['protect_code'];
    quoteId = json['quote_id'];
    remoteIp = json['remote_ip'];
    shippingAmount = json['shipping_amount'];
    shippingDescription = json['shipping_description'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    shippingDiscountTaxCompensationAmount =
    json['shipping_discount_tax_compensation_amount'];
    shippingInclTax = json['shipping_incl_tax'];
    shippingTaxAmount = json['shipping_tax_amount'];
    state = json['state'];
    status = json['status'];
    storeCurrencyCode = json['store_currency_code'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeToBaseRate = json['store_to_base_rate'];
    storeToOrderRate = json['store_to_order_rate'];
    subtotal = json['subtotal'];
    subtotalInclTax = json['subtotal_incl_tax'];
    taxAmount = json['tax_amount'];
    totalDue = json['total_due'];
    totalItemCount = json['total_item_count'];
    totalQtyOrdered = json['total_qty_ordered'];
    updatedAt = json['updated_at'];
    weight = json['weight'];
    xForwardedFor = json['x_forwarded_for'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    if (json['status_histories'] != null) {
      statusHistories = [];
      json['status_histories'].forEach((v) {
        statusHistories!.add(new StatusHistories.fromJson(v));
      });
    }
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_currency_code'] = this.baseCurrencyCode;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['base_grand_total'] = this.baseGrandTotal;
    data['base_discount_tax_compensation_amount'] =
        this.baseDiscountTaxCompensationAmount;
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['base_shipping_discount_amount'] = this.baseShippingDiscountAmount;
    data['base_shipping_discount_tax_compensation_amnt'] =
        this.baseShippingDiscountTaxCompensationAmnt;
    data['base_shipping_incl_tax'] = this.baseShippingInclTax;
    data['base_shipping_tax_amount'] = this.baseShippingTaxAmount;
    data['base_subtotal'] = this.baseSubtotal;
    data['base_subtotal_incl_tax'] = this.baseSubtotalInclTax;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['base_total_due'] = this.baseTotalDue;
    data['base_to_global_rate'] = this.baseToGlobalRate;
    data['base_to_order_rate'] = this.baseToOrderRate;
    data['billing_address_id'] = this.billingAddressId;
    data['created_at'] = this.createdAt;
    data['customer_email'] = this.customerEmail;
    data['customer_firstname'] = this.customerFirstname;
    data['customer_group_id'] = this.customerGroupId;
    data['customer_id'] = this.customerId;
    data['customer_is_guest'] = this.customerIsGuest;
    data['customer_lastname'] = this.customerLastname;
    data['customer_note_notify'] = this.customerNoteNotify;
    data['discount_amount'] = this.discountAmount;
    data['entity_id'] = this.entityId;
    data['global_currency_code'] = this.globalCurrencyCode;
    data['grand_total'] = this.grandTotal;
    data['discount_tax_compensation_amount'] =
        this.discountTaxCompensationAmount;
    data['increment_id'] = this.incrementId;
    data['is_virtual'] = this.isVirtual;
    data['order_currency_code'] = this.orderCurrencyCode;
    data['protect_code'] = this.protectCode;
    data['quote_id'] = this.quoteId;
    data['remote_ip'] = this.remoteIp;
    data['shipping_amount'] = this.shippingAmount;
    data['shipping_description'] = this.shippingDescription;
    data['shipping_discount_amount'] = this.shippingDiscountAmount;
    data['shipping_discount_tax_compensation_amount'] =
        this.shippingDiscountTaxCompensationAmount;
    data['shipping_incl_tax'] = this.shippingInclTax;
    data['shipping_tax_amount'] = this.shippingTaxAmount;
    data['state'] = this.state;
    data['status'] = this.status;
    data['store_currency_code'] = this.storeCurrencyCode;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_to_base_rate'] = this.storeToBaseRate;
    data['store_to_order_rate'] = this.storeToOrderRate;
    data['subtotal'] = this.subtotal;
    data['subtotal_incl_tax'] = this.subtotalInclTax;
    data['tax_amount'] = this.taxAmount;
    data['total_due'] = this.totalDue;
    data['total_item_count'] = this.totalItemCount;
    data['total_qty_ordered'] = this.totalQtyOrdered;
    data['updated_at'] = this.updatedAt;
    data['weight'] = this.weight;
    data['x_forwarded_for'] = this.xForwardedFor;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    if (this.statusHistories != null) {
      data['status_histories'] =
          this.statusHistories!.map((v) => v.toJson()).toList();
    }
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes!.toJson();
    }
    return data;
  }
}

class Items {
  var amountRefunded;
  var baseAmountRefunded;
  var baseDiscountAmount;
  var baseDiscountInvoiced;
  var baseDiscountTaxCompensationAmount;
  var baseOriginalPrice;
  var basePrice;
  var basePriceInclTax;
  var baseRowInvoiced;
  var baseRowTotal;
  var baseRowTotalInclTax;
  var baseTaxAmount;
  var baseTaxInvoiced;
  var createdAt;
  var discountAmount;
  var discountInvoiced;
  var discountPercent;
  var freeShipping;
  var discountTaxCompensationAmount;
  var isQtyDecimal;
  var isVirtual;
  var itemId;
  var name;
  var noDiscount;
  var orderId;
  var originalPrice;
  var price;
  var priceInclTax;
  var productId;
  var productType;
  var qtyCanceled;
  var qtyInvoiced;
  var qtyOrdered;
  var qtyRefunded;
  var qtyShipped;
  var quoteItemId;
  var rowInvoiced;
  var rowTotal;
  var rowTotalInclTax;
  var rowWeight;
  var sku;
  var storeId;
  var taxAmount;
  var taxInvoiced;
  var taxPercent;
  var updatedAt;
  var weight;
  var extensionAttributes;

  Items(
      {this.amountRefunded,
        this.baseAmountRefunded,
        this.baseDiscountAmount,
        this.baseDiscountInvoiced,
        this.baseDiscountTaxCompensationAmount,
        this.baseOriginalPrice,
        this.basePrice,
        this.basePriceInclTax,
        this.baseRowInvoiced,
        this.baseRowTotal,
        this.baseRowTotalInclTax,
        this.baseTaxAmount,
        this.baseTaxInvoiced,
        this.createdAt,
        this.discountAmount,
        this.discountInvoiced,
        this.discountPercent,
        this.freeShipping,
        this.discountTaxCompensationAmount,
        this.isQtyDecimal,
        this.isVirtual,
        this.itemId,
        this.name,
        this.noDiscount,
        this.orderId,
        this.originalPrice,
        this.price,
        this.priceInclTax,
        this.productId,
        this.productType,
        this.qtyCanceled,
        this.qtyInvoiced,
        this.qtyOrdered,
        this.qtyRefunded,
        this.qtyShipped,
        this.quoteItemId,
        this.rowInvoiced,
        this.rowTotal,
        this.rowTotalInclTax,
        this.rowWeight,
        this.sku,
        this.storeId,
        this.taxAmount,
        this.taxInvoiced,
        this.taxPercent,
        this.updatedAt,
        this.weight,
      this.extensionAttributes});

  Items.fromJson(Map<String, dynamic> json) {
    amountRefunded = json['amount_refunded'];
    baseAmountRefunded = json['base_amount_refunded'];
    baseDiscountAmount = json['base_discount_amount'];
    baseDiscountInvoiced = json['base_discount_invoiced'];
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'];
    baseOriginalPrice = json['base_original_price'];
    basePrice = json['base_price'];
    basePriceInclTax = json['base_price_incl_tax'];
    baseRowInvoiced = json['base_row_invoiced'];
    baseRowTotal = json['base_row_total'];
    baseRowTotalInclTax = json['base_row_total_incl_tax'];
    baseTaxAmount = json['base_tax_amount'];
    baseTaxInvoiced = json['base_tax_invoiced'];
    createdAt = json['created_at'];
    discountAmount = json['discount_amount'];
    discountInvoiced = json['discount_invoiced'];
    discountPercent = json['discount_percent'];
    freeShipping = json['free_shipping'];
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'];
    isQtyDecimal = json['is_qty_decimal'];
    isVirtual = json['is_virtual'];
    itemId = json['item_id'];
    name = json['name'];
    noDiscount = json['no_discount'];
    orderId = json['order_id'];
    originalPrice = json['original_price'];
    price = json['price'];
    priceInclTax = json['price_incl_tax'];
    productId = json['product_id'];
    productType = json['product_type'];
    qtyCanceled = json['qty_canceled'];
    qtyInvoiced = json['qty_invoiced'];
    qtyOrdered = json['qty_ordered'];
    qtyRefunded = json['qty_refunded'];
    qtyShipped = json['qty_shipped'];
    quoteItemId = json['quote_item_id'];
    rowInvoiced = json['row_invoiced'];
    rowTotal = json['row_total'];
    rowTotalInclTax = json['row_total_incl_tax'];
    rowWeight = json['row_weight'];
    sku = json['sku'];
    storeId = json['store_id'];
    taxAmount = json['tax_amount'];
    taxInvoiced = json['tax_invoiced'];
    taxPercent = json['tax_percent'];
    updatedAt = json['updated_at'];
    weight = json['weight'];
    extensionAttributes = json['extension_attributes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount_refunded'] = this.amountRefunded;
    data['base_amount_refunded'] = this.baseAmountRefunded;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['base_discount_invoiced'] = this.baseDiscountInvoiced;
    data['base_discount_tax_compensation_amount'] =
        this.baseDiscountTaxCompensationAmount;
    data['base_original_price'] = this.baseOriginalPrice;
    data['base_price'] = this.basePrice;
    data['base_price_incl_tax'] = this.basePriceInclTax;
    data['base_row_invoiced'] = this.baseRowInvoiced;
    data['base_row_total'] = this.baseRowTotal;
    data['base_row_total_incl_tax'] = this.baseRowTotalInclTax;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['base_tax_invoiced'] = this.baseTaxInvoiced;
    data['created_at'] = this.createdAt;
    data['discount_amount'] = this.discountAmount;
    data['discount_invoiced'] = this.discountInvoiced;
    data['discount_percent'] = this.discountPercent;
    data['free_shipping'] = this.freeShipping;
    data['discount_tax_compensation_amount'] =
        this.discountTaxCompensationAmount;
    data['is_qty_decimal'] = this.isQtyDecimal;
    data['is_virtual'] = this.isVirtual;
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['no_discount'] = this.noDiscount;
    data['order_id'] = this.orderId;
    data['original_price'] = this.originalPrice;
    data['price'] = this.price;
    data['price_incl_tax'] = this.priceInclTax;
    data['product_id'] = this.productId;
    data['product_type'] = this.productType;
    data['qty_canceled'] = this.qtyCanceled;
    data['qty_invoiced'] = this.qtyInvoiced;
    data['qty_ordered'] = this.qtyOrdered;
    data['qty_refunded'] = this.qtyRefunded;
    data['qty_shipped'] = this.qtyShipped;
    data['quote_item_id'] = this.quoteItemId;
    data['row_invoiced'] = this.rowInvoiced;
    data['row_total'] = this.rowTotal;
    data['row_total_incl_tax'] = this.rowTotalInclTax;
    data['row_weight'] = this.rowWeight;
    data['sku'] = this.sku;
    data['store_id'] = this.storeId;
    data['tax_amount'] = this.taxAmount;
    data['tax_invoiced'] = this.taxInvoiced;
    data['tax_percent'] = this.taxPercent;
    data['updated_at'] = this.updatedAt;
    data['weight'] = this.weight;
    return data;
  }
}

class BillingAddress {
  var addressType;
  var city;
  var countryId;
  var email;
  var entityId;
  var firstname;
  var lastname;
  var parentId;
  var postcode;
  var region;
  var regionCode;
  var regionId;
  List<String>? street;
  var telephone;

  BillingAddress(
      {this.addressType,
        this.city,
        this.countryId,
        this.email,
        this.entityId,
        this.firstname,
        this.lastname,
        this.parentId,
        this.postcode,
        this.region,
        this.regionCode,
        this.regionId,
        this.street,
        this.telephone});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    addressType = json['address_type'];
    city = json['city'];
    countryId = json['country_id'];
    email = json['email'];
    entityId = json['entity_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    parentId = json['parent_id'];
    postcode = json['postcode'];
    region = json['region'];
    regionCode = json['region_code'];
    regionId = json['region_id'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_type'] = this.addressType;
    data['city'] = this.city;
    data['country_id'] = this.countryId;
    data['email'] = this.email;
    data['entity_id'] = this.entityId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['parent_id'] = this.parentId;
    data['postcode'] = this.postcode;
    data['region'] = this.region;
    data['region_code'] = this.regionCode;
    data['region_id'] = this.regionId;
    data['street'] = this.street;
    data['telephone'] = this.telephone;
    return data;
  }
}

class Payment {
  var accountStatus;
  List<String>? additionalInformation;
  var amountOrdered;
  var baseAmountOrdered;
  var baseShippingAmount;
  var ccExpYear;
  var ccLast4;
  var ccSsStartMonth;
  var ccSsStartYear;
  var entityId;
  var method;
  var parentId;
  var shippingAmount;

  Payment(
      {this.accountStatus,
        this.additionalInformation,
        this.amountOrdered,
        this.baseAmountOrdered,
        this.baseShippingAmount,
        this.ccExpYear,
        this.ccLast4,
        this.ccSsStartMonth,
        this.ccSsStartYear,
        this.entityId,
        this.method,
        this.parentId,
        this.shippingAmount});

  Payment.fromJson(Map<String, dynamic> json) {
    accountStatus = json['account_status'];
    additionalInformation = json['additional_information'].cast<String>();
    amountOrdered = json['amount_ordered'];
    baseAmountOrdered = json['base_amount_ordered'];
    baseShippingAmount = json['base_shipping_amount'];
    ccExpYear = json['cc_exp_year'];
    ccLast4 = json['cc_last4'];
    ccSsStartMonth = json['cc_ss_start_month'];
    ccSsStartYear = json['cc_ss_start_year'];
    entityId = json['entity_id'];
    method = json['method'];
    parentId = json['parent_id'];
    shippingAmount = json['shipping_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_status'] = this.accountStatus;
    data['additional_information'] = this.additionalInformation;
    data['amount_ordered'] = this.amountOrdered;
    data['base_amount_ordered'] = this.baseAmountOrdered;
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['cc_exp_year'] = this.ccExpYear;
    data['cc_last4'] = this.ccLast4;
    data['cc_ss_start_month'] = this.ccSsStartMonth;
    data['cc_ss_start_year'] = this.ccSsStartYear;
    data['entity_id'] = this.entityId;
    data['method'] = this.method;
    data['parent_id'] = this.parentId;
    data['shipping_amount'] = this.shippingAmount;
    return data;
  }
}

class ExtensionAttributes {
  List<ShippingAssignments>? shippingAssignments;
  List<PaymentAdditionalInfo>? paymentAdditionalInfo;
  List<AppliedTaxes>? appliedTaxes;
  List<ItemAppliedTaxes>? itemAppliedTaxes;
  bool? convertingFromQuote;

  ExtensionAttributes(
      {this.shippingAssignments,
        this.paymentAdditionalInfo,
        this.appliedTaxes,
        this.itemAppliedTaxes,
        this.convertingFromQuote});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    if (json['shipping_assignments'] != null) {
      shippingAssignments = [];
      json['shipping_assignments'].forEach((v) {
        shippingAssignments!.add(new ShippingAssignments.fromJson(v));
      });
    }
    if (json['payment_additional_info'] != null) {
      paymentAdditionalInfo = [];
      json['payment_additional_info'].forEach((v) {
        paymentAdditionalInfo!.add(new PaymentAdditionalInfo.fromJson(v));
      });
    }
    if (json['applied_taxes'] != null) {
      appliedTaxes = [];
      json['applied_taxes'].forEach((v) {
        appliedTaxes!.add(new AppliedTaxes.fromJson(v));
      });
    }
    if (json['item_applied_taxes'] != null) {
      itemAppliedTaxes = [];
      json['item_applied_taxes'].forEach((v) {
        itemAppliedTaxes!.add(new ItemAppliedTaxes.fromJson(v));
      });
    }
    convertingFromQuote = json['converting_from_quote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippingAssignments != null) {
      data['shipping_assignments'] =
          this.shippingAssignments!.map((v) => v.toJson()).toList();
    }
    if (this.paymentAdditionalInfo != null) {
      data['payment_additional_info'] =
          this.paymentAdditionalInfo!.map((v) => v.toJson()).toList();
    }
    if (this.appliedTaxes != null) {
      data['applied_taxes'] = this.appliedTaxes!.map((v) => v.toJson()).toList();
    }
    if (this.itemAppliedTaxes != null) {
      data['item_applied_taxes'] =
          this.itemAppliedTaxes!.map((v) => v.toJson()).toList();
    }
    data['converting_from_quote'] = this.convertingFromQuote;
    return data;
  }
}

class ShippingAssignments {
  Shipping? shipping;
  List<OrderItems>? items;

  ShippingAssignments({this.shipping, this.items});

  ShippingAssignments.fromJson(Map<String, dynamic> json) {
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shipping {
  BillingAddress? address;
  String? method;
  Total? total;

  Shipping({this.address, this.method, this.total});

  Shipping.fromJson(Map<String, dynamic> json) {
    address = json['address'] != null
        ? new BillingAddress.fromJson(json['address'])
        : null;
    method = json['method'];
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['method'] = this.method;
    if (this.total != null) {
      data['total'] = this.total!.toJson();
    }
    return data;
  }
}

class Total {
  var baseShippingAmount;
  var baseShippingDiscountAmount;
  var baseShippingDiscountTaxCompensationAmnt;
  var baseShippingInclTax;
  var baseShippingTaxAmount;
  var shippingAmount;
  var shippingDiscountAmount;
  var shippingDiscountTaxCompensationAmount;
  var shippingInclTax;
  var shippingTaxAmount;

  Total(
      {this.baseShippingAmount,
        this.baseShippingDiscountAmount,
        this.baseShippingDiscountTaxCompensationAmnt,
        this.baseShippingInclTax,
        this.baseShippingTaxAmount,
        this.shippingAmount,
        this.shippingDiscountAmount,
        this.shippingDiscountTaxCompensationAmount,
        this.shippingInclTax,
        this.shippingTaxAmount});

  Total.fromJson(Map<String, dynamic> json) {
    baseShippingAmount = json['base_shipping_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    baseShippingDiscountTaxCompensationAmnt =
    json['base_shipping_discount_tax_compensation_amnt'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    shippingAmount = json['shipping_amount'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    shippingDiscountTaxCompensationAmount =
    json['shipping_discount_tax_compensation_amount'];
    shippingInclTax = json['shipping_incl_tax'];
    shippingTaxAmount = json['shipping_tax_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['base_shipping_discount_amount'] = this.baseShippingDiscountAmount;
    data['base_shipping_discount_tax_compensation_amnt'] =
        this.baseShippingDiscountTaxCompensationAmnt;
    data['base_shipping_incl_tax'] = this.baseShippingInclTax;
    data['base_shipping_tax_amount'] = this.baseShippingTaxAmount;
    data['shipping_amount'] = this.shippingAmount;
    data['shipping_discount_amount'] = this.shippingDiscountAmount;
    data['shipping_discount_tax_compensation_amount'] =
        this.shippingDiscountTaxCompensationAmount;
    data['shipping_incl_tax'] = this.shippingInclTax;
    data['shipping_tax_amount'] = this.shippingTaxAmount;
    return data;
  }
}

class PaymentAdditionalInfo {
  var key;
  var value;

  PaymentAdditionalInfo({this.key, this.value});

  PaymentAdditionalInfo.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class AppliedTaxes {
  var code;
  var title;
  var percent;
  var amount;
  var baseAmount;

  AppliedTaxes(
      {this.code, this.title, this.percent, this.amount, this.baseAmount});

  AppliedTaxes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    percent = json['percent'];
    amount = json['amount'];
    baseAmount = json['base_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    data['percent'] = this.percent;
    data['amount'] = this.amount;
    data['base_amount'] = this.baseAmount;
    return data;
  }
}

class ItemAppliedTaxes {
  var type;
  List<AppliedTaxes>? appliedTaxes;
  var itemId;

  ItemAppliedTaxes({this.type, this.appliedTaxes, this.itemId});

  ItemAppliedTaxes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['applied_taxes'] != null) {
      appliedTaxes = [];
      json['applied_taxes'].forEach((v) {
        appliedTaxes!.add(new AppliedTaxes.fromJson(v));
      });
    }
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.appliedTaxes != null) {
      data['applied_taxes'] = this.appliedTaxes!.map((v) => v.toJson()).toList();
    }
    data['item_id'] = this.itemId;
    return data;
  }
}

class SearchCriteria {
  List<FilterGroups>? filterGroups;
  var pageSize;
  var currentPage;

  SearchCriteria({this.filterGroups, this.pageSize, this.currentPage});

  SearchCriteria.fromJson(Map<String, dynamic> json) {
    if (json['filter_groups'] != null) {
      filterGroups = [];
      json['filter_groups'].forEach((v) {
        filterGroups!.add(new FilterGroups.fromJson(v));
      });
    }
    pageSize = json['page_size'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filterGroups != null) {
      data['filter_groups'] = this.filterGroups?.map((v) => v.toJson()).toList();
    }
    data['page_size'] = this.pageSize;
    data['current_page'] = this.currentPage;
    return data;
  }
}

class FilterGroups {
  List<Filters>? filters;

  FilterGroups({this.filters});

  FilterGroups.fromJson(Map<String, dynamic> json) {
    if (json['filters'] != null) {
      filters = [];
      json['filters'].forEach((v) {
        filters!.add(new Filters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filters != null) {
      data['filters'] = this.filters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Filters {
  var field;
  var value;
  var conditionType;

  Filters({this.field, this.value, this.conditionType});

  Filters.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    value = json['value'];
    conditionType = json['condition_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['value'] = this.value;
    data['condition_type'] = this.conditionType;
    return data;
  }
}

class StatusHistories{
  var field;


  StatusHistories({this.field});
  StatusHistories.fromJson(Map<String, dynamic> json) {
    field = json['field'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    return data;
  }
}