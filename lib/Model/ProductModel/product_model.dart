import 'package:almajidoud/utils/file_export.dart';
import 'package:intl/intl.dart';



class ProductModel  extends BaseMappable {
  List<Items> items;
  SearchCriteria searchCriteria;
  int totalCount;
  var message;
  Parameters parameters;
  var trace;
  ProductModel({this.items, this.searchCriteria, this.totalCount,this.message,this.parameters,this.trace});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    searchCriteria = json['search_criteria'] != null
        ? new SearchCriteria.fromJson(json['search_criteria'])
        : null;
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.searchCriteria != null) {
      data['search_criteria'] = this.searchCriteria.toJson();
    }
    data['total_count'] = this.totalCount;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    searchCriteria = json['search_criteria'] != null
        ? new SearchCriteria.fromJson(json['search_criteria'])
        : null;
    totalCount = json['total_count'];
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    trace = json['trace'];
    return ProductModel(totalCount: totalCount,searchCriteria: searchCriteria,items: items,
        message:message, parameters :parameters , trace : trace
    );
  }
}

class Items {
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
  var weight;
  ExtensionAttributes extensionAttributes;
  List<ProductLinks> productLinks;
  List<Options> options;
  List<MediaGalleryEntries> mediaGalleryEntries;
  List<TierPrices> tierPrices;
  List<CustomAttributes> customAttributes;

  Items(
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
        this.weight,
        this.extensionAttributes,
        this.productLinks,
        this.options,
        this.mediaGalleryEntries,
        this.tierPrices,
        this.customAttributes});

  Items.fromJson(Map<String, dynamic> json) {
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
    weight = json['weight'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    if (json['product_links'] != null) {
      productLinks = new List<ProductLinks>();
      json['product_links'].forEach((v) {
        productLinks.add(new ProductLinks.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = new List<Null>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    if (json['media_gallery_entries'] != null) {
      mediaGalleryEntries = new List<MediaGalleryEntries>();
      json['media_gallery_entries'].forEach((v) {
        mediaGalleryEntries.add(new MediaGalleryEntries.fromJson(v));
      });
    }
    if (json['tier_prices'] != null) {
      tierPrices = new List<Null>();
      json['tier_prices'].forEach((v) {
        tierPrices.add(new TierPrices.fromJson(v));
      });
    }
    if (json['custom_attributes'] != null) {
      customAttributes = new List<CustomAttributes>();
      json['custom_attributes'].forEach((v) {
        customAttributes.add(new CustomAttributes.fromJson(v));
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
    data['weight'] = this.weight;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes.toJson();
    }
    if (this.productLinks != null) {
      data['product_links'] = this.productLinks.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    if (this.mediaGalleryEntries != null) {
      data['media_gallery_entries'] =
          this.mediaGalleryEntries.map((v) => v.toJson()).toList();
    }
    if (this.tierPrices != null) {
      data['tier_prices'] = this.tierPrices.map((v) => v.toJson()).toList();
    }
    if (this.customAttributes != null) {
      data['custom_attributes'] =
          this.customAttributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExtensionAttributes {
  List<int> websiteIds;
  List<CategoryLinks> categoryLinks;
  List<Reviews> reviews;

  ExtensionAttributes({this.websiteIds, this.categoryLinks, this.reviews});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    websiteIds = json['website_ids'].cast<int>();
    if (json['category_links'] != null) {
      categoryLinks = new List<CategoryLinks>();
      json['category_links'].forEach((v) {
        categoryLinks.add(new CategoryLinks.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['website_ids'] = this.websiteIds;
    if (this.categoryLinks != null) {
      data['category_links'] =
          this.categoryLinks.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryLinks {
  var position;
  var categoryId;

  CategoryLinks({this.position, this.categoryId});

  CategoryLinks.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Reviews {
  var reviewId;
  var createdAt;
  var entityId;
  var entityPkValue;
  var statusId;
  var detailId;
  var title;
  var detail;
  var nickname;
  var customerId;
  var entityCode;

  Reviews(
      {this.reviewId,
        this.createdAt,
        this.entityId,
        this.entityPkValue,
        this.statusId,
        this.detailId,
        this.title,
        this.detail,
        this.nickname,
        this.customerId,
        this.entityCode});

  Reviews.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    createdAt = json['created_at'];
    entityId = json['entity_id'];
    entityPkValue = json['entity_pk_value'];
    statusId = json['status_id'];
    detailId = json['detail_id'];
    title = json['title'];
    detail = json['detail'];
    nickname = json['nickname'];
    customerId = json['customer_id'];
    entityCode = json['entity_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['created_at'] = this.createdAt;
    data['entity_id'] = this.entityId;
    data['entity_pk_value'] = this.entityPkValue;
    data['status_id'] = this.statusId;
    data['detail_id'] = this.detailId;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['nickname'] = this.nickname;
    data['customer_id'] = this.customerId;
    data['entity_code'] = this.entityCode;
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

class MediaGalleryEntries {
  var id;
  var mediaType;
  var label;
  var position;
  var disabled;
  List<String> types;
  var file;

  MediaGalleryEntries(
      {this.id,
        this.mediaType,
        this.label,
        this.position,
        this.disabled,
        this.types,
        this.file});

  MediaGalleryEntries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    label = json['label'];
    position = json['position'];
    disabled = json['disabled'];
    types = json['types'].cast<String>();
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['media_type'] = this.mediaType;
    data['label'] = this.label;
    data['position'] = this.position;
    data['disabled'] = this.disabled;
    data['types'] = this.types;
    data['file'] = this.file;
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

class SearchCriteria {
  List<FilterGroups> filterGroups;
  List<SortOrders> sortOrders;
  var pageSize;
  var currentPage;

  SearchCriteria(
      {this.filterGroups, this.sortOrders, this.pageSize, this.currentPage});

  SearchCriteria.fromJson(Map<String, dynamic> json) {
    if (json['filter_groups'] != null) {
      filterGroups = new List<FilterGroups>();
      json['filter_groups'].forEach((v) {
        filterGroups.add(new FilterGroups.fromJson(v));
      });
    }
    if (json['sort_orders'] != null) {
      sortOrders = new List<SortOrders>();
      json['sort_orders'].forEach((v) {
        sortOrders.add(new SortOrders.fromJson(v));
      });
    }
    pageSize = json['page_size'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filterGroups != null) {
      data['filter_groups'] = this.filterGroups.map((v) => v.toJson()).toList();
    }
    if (this.sortOrders != null) {
      data['sort_orders'] = this.sortOrders.map((v) => v.toJson()).toList();
    }
    data['page_size'] = this.pageSize;
    data['current_page'] = this.currentPage;
    return data;
  }
}

class FilterGroups {
  List<Filters> filters;

  FilterGroups({this.filters});

  FilterGroups.fromJson(Map<String, dynamic> json) {
    if (json['filters'] != null) {
      filters = new List<Filters>();
      json['filters'].forEach((v) {
        filters.add(new Filters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filters != null) {
      data['filters'] = this.filters.map((v) => v.toJson()).toList();
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

class SortOrders {
  var field;
  var direction;

  SortOrders({this.field, this.direction});

  SortOrders.fromJson(Map<String, dynamic> json) {
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
class Options{
  var field;
  var direction;

  Options({this.field, this.direction});

  Options.fromJson(Map<String, dynamic> json) {
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

class Parameters {
  var resources;

  Parameters({this.resources});

  Parameters.fromJson(Map<String, dynamic> json) {
    resources = json['resources'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resources'] = this.resources;
    return data;
  }
}