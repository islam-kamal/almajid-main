import 'package:almajidoud/Base/network-mappers.dart';

class GuestCartDetailsModel extends BaseMappable {
  int? id;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  bool? isVirtual;
  int? itemsCount;
  int? itemsQty;
  Customer? customer;
  BillingAddress? billingAddress;
  String? reservedOrderId;
  int? origOrderId;
  Currency? currency;
  bool? customerIsGuest;
  bool? customerNoteNotify;
  int? customerTaxClassId;
  int? storeId;
  ExtensionAttributes? extensionAttributes;

  GuestCartDetailsModel(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.isVirtual,
        this.itemsCount,
        this.itemsQty,
        this.customer,
        this.billingAddress,
        this.reservedOrderId,
        this.origOrderId,
        this.currency,
        this.customerIsGuest,
        this.customerNoteNotify,
        this.customerTaxClassId,
        this.storeId,
        this.extensionAttributes});

  GuestCartDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    isVirtual = json['is_virtual'];
    itemsCount = json['items_count'];
    itemsQty = json['items_qty'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    reservedOrderId = json['reserved_order_id'];
    origOrderId = json['orig_order_id'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    customerIsGuest = json['customer_is_guest'];
    customerNoteNotify = json['customer_note_notify'];
    customerTaxClassId = json['customer_tax_class_id'];
    storeId = json['store_id'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['is_virtual'] = this.isVirtual;
    data['items_count'] = this.itemsCount;
    data['items_qty'] = this.itemsQty;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    data['reserved_order_id'] = this.reservedOrderId;
    data['orig_order_id'] = this.origOrderId;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    data['customer_is_guest'] = this.customerIsGuest;
    data['customer_note_notify'] = this.customerNoteNotify;
    data['customer_tax_class_id'] = this.customerTaxClassId;
    data['store_id'] = this.storeId;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes!.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    isVirtual = json['is_virtual'];
    itemsCount = json['items_count'];
    itemsQty = json['items_qty'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    reservedOrderId = json['reserved_order_id'];
    origOrderId = json['orig_order_id'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    customerIsGuest = json['customer_is_guest'];
    customerNoteNotify = json['customer_note_notify'];
    customerTaxClassId = json['customer_tax_class_id'];
    storeId = json['store_id'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    return GuestCartDetailsModel(
        id: id,itemsQty: itemsQty,createdAt: createdAt,storeId: storeId,updatedAt: updatedAt,
        isActive:isActive,extensionAttributes: extensionAttributes,billingAddress: billingAddress,currency: currency,
        customer: customer,customerIsGuest: customerIsGuest,customerNoteNotify: customerNoteNotify,
        customerTaxClassId: customerTaxClassId, isVirtual: isVirtual,itemsCount: itemsCount,
        origOrderId: origOrderId,reservedOrderId: reservedOrderId);
  }
}

class Customer {
  String? email;
  String? firstname;
  String? lastname;

  Customer({this.email, this.firstname, this.lastname});

  Customer.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}

class BillingAddress {
  int? id;
  String? region;
  int? regionId;
  String? regionCode;
  String? countryId;
  List<String>? street;
  String? telephone;
  String? postcode;
  String? city;
  String? firstname;
  String? lastname;
  String? email;
  int? sameAsBilling;
  int? saveInAddressBook;

  BillingAddress(
      {this.id,
        this.region,
        this.regionId,
        this.regionCode,
        this.countryId,
        this.street,
        this.telephone,
        this.postcode,
        this.city,
        this.firstname,
        this.lastname,
        this.email,
        this.sameAsBilling,
        this.saveInAddressBook});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    region = json['region'];
    regionId = json['region_id'];
    regionCode = json['region_code'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    sameAsBilling = json['same_as_billing'];
    saveInAddressBook = json['save_in_address_book'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    data['region_code'] = this.regionCode;
    data['country_id'] = this.countryId;
    data['street'] = this.street;
    data['telephone'] = this.telephone;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['same_as_billing'] = this.sameAsBilling;
    data['save_in_address_book'] = this.saveInAddressBook;
    return data;
  }
}

class Currency {
  String? globalCurrencyCode;
  String? baseCurrencyCode;
  String? storeCurrencyCode;
  String? quoteCurrencyCode;
  int? storeToBaseRate;
  int? storeToQuoteRate;
  int? baseToGlobalRate;
  int? baseToQuoteRate;

  Currency(
      {this.globalCurrencyCode,
        this.baseCurrencyCode,
        this.storeCurrencyCode,
        this.quoteCurrencyCode,
        this.storeToBaseRate,
        this.storeToQuoteRate,
        this.baseToGlobalRate,
        this.baseToQuoteRate});

  Currency.fromJson(Map<String, dynamic> json) {
    globalCurrencyCode = json['global_currency_code'];
    baseCurrencyCode = json['base_currency_code'];
    storeCurrencyCode = json['store_currency_code'];
    quoteCurrencyCode = json['quote_currency_code'];
    storeToBaseRate = json['store_to_base_rate'];
    storeToQuoteRate = json['store_to_quote_rate'];
    baseToGlobalRate = json['base_to_global_rate'];
    baseToQuoteRate = json['base_to_quote_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['global_currency_code'] = this.globalCurrencyCode;
    data['base_currency_code'] = this.baseCurrencyCode;
    data['store_currency_code'] = this.storeCurrencyCode;
    data['quote_currency_code'] = this.quoteCurrencyCode;
    data['store_to_base_rate'] = this.storeToBaseRate;
    data['store_to_quote_rate'] = this.storeToQuoteRate;
    data['base_to_global_rate'] = this.baseToGlobalRate;
    data['base_to_quote_rate'] = this.baseToQuoteRate;
    return data;
  }
}

class ExtensionAttributes {
  AmAcartQuoteEmail? amAcartQuoteEmail;

  ExtensionAttributes({this.amAcartQuoteEmail});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    amAcartQuoteEmail = json['am_acart_quote_email'] != null
        ? new AmAcartQuoteEmail.fromJson(json['am_acart_quote_email'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amAcartQuoteEmail != null) {
      data['am_acart_quote_email'] = this.amAcartQuoteEmail!.toJson();
    }
    return data;
  }
}

class AmAcartQuoteEmail {
  int? quoteEmailId;
  int? quoteId;

  AmAcartQuoteEmail({this.quoteEmailId, this.quoteId});

  AmAcartQuoteEmail.fromJson(Map<String, dynamic> json) {
    quoteEmailId = json['quote_email_id'];
    quoteId = json['quote_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote_email_id'] = this.quoteEmailId;
    data['quote_id'] = this.quoteId;
    return data;
  }
}