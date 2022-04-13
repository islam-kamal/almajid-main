class WishlistItemModel {
  var id;
  var qty;
  Product? product;

  WishlistItemModel({this.id, this.qty, this.product});

  WishlistItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  var id;
  var sku;
  var name;
  var attributeSetId;
  var price;
  var status;
  var visibility;
  var typeId;
  var createdAt;
  var updatedAt;
  List<ProductLinks>? productLinks;
  List<TierPrices>? tierPrices;
  List<CustomAttributes>? customAttributes;

  Product(
      {this.id,
        this.sku,
        this.name,
        this.attributeSetId,
        this.price,
        this.status,
        this.visibility,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.productLinks,
        this.tierPrices,
        this.customAttributes});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    attributeSetId = json['attribute_set_id'];
    price = json['price'];
    status = json['status'];
    visibility = json['visibility'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['product_links'] != null) {
      productLinks = [];
      json['product_links'].forEach((v) {
        productLinks!.add(new ProductLinks.fromJson(v));
      });
    }
    if (json['tier_prices'] != null) {
      tierPrices = [];
      json['tier_prices'].forEach((v) {
        tierPrices!.add(new TierPrices.fromJson(v));
      });
    }
    if (json['custom_attributes'] != null) {
      customAttributes = [];
      json['custom_attributes'].forEach((v) {
        customAttributes!.add(new CustomAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['attribute_set_id'] = this.attributeSetId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productLinks != null) {
      data['product_links'] = this.productLinks!.map((v) => v.toJson()).toList();
    }
    if (this.tierPrices != null) {
      data['tier_prices'] = this.tierPrices!.map((v) => v.toJson()).toList();
    }
    if (this.customAttributes != null) {
      data['custom_attributes'] =
          this.customAttributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductLinks {
  var sku;
  var linkType;
  var linkedProductSku;
  var linkedProductType;
  var position;

  ProductLinks(
      {this.sku,
        this.linkType,
        this.linkedProductSku,
        this.linkedProductType,
        this.position});

  ProductLinks.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    linkType = json['link_type'];
    linkedProductSku = json['linked_product_sku'];
    linkedProductType = json['linked_product_type'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['link_type'] = this.linkType;
    data['linked_product_sku'] = this.linkedProductSku;
    data['linked_product_type'] = this.linkedProductType;
    data['position'] = this.position;
    return data;
  }
}

class CustomAttributes {
  var attributeCode;
  var value;

  CustomAttributes({this.attributeCode, this.value});

  CustomAttributes.fromJson(Map<String, dynamic> json) {
    attributeCode = json['attribute_code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_code'] = this.attributeCode;
    data['value'] = this.value;
    return data;
  }
}
class TierPrices{
  var field;
  var direction;

  TierPrices({this.field, this.direction});

  TierPrices.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['direction'] = this.direction;
    return data;
  }
}
