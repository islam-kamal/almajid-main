import 'package:almajidoud/utils/file_export.dart';

class SortModel extends BaseMappable{
  bool? status;
  int? code;
  String? msg;
  Data? data;

  SortModel({this.status, this.code, this.msg, this.data});

  SortModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    return SortModel(status: status,msg: msg,code: code,data: data);
  }
}

class Data {
  List<Products>? products;
  Meta? meta;

  Data({this.products, this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}


class Products {
  var id;
  var name;
  var description;
  var unit;
  var unitPackage;
  var quantity;
  var price;
  var priceAfterDiscount;
  var discount;
  var savedAmount;
  var flavor;
  var shape;
  var unitSize;
  var overallSize;
  var unitPrice;
  var cover;
  var notes;
  var sizeId;
  var brandId;
  Size? size;
  Brand? brand;
  var code;
  var mostSelling;
  var numberArrangementUnitsSameItem;
  var countRates;
  var totalRate;
  var inFavorite;
  SubCategory? subCategory;
  List<Files>? files;
  List<Rates>? rates;
  CreateDates? createDates;
  UpdateDates? updateDates;

  Products(
      {this.id,
        this.name,
        this.description,
        this.unit,
        this.unitPackage,
        this.quantity,
        this.price,
        this.priceAfterDiscount,
        this.discount,
        this.savedAmount,
        this.flavor,
        this.shape,
        this.unitSize,
        this.overallSize,
        this.unitPrice,
        this.cover,
        this.notes,
        this.sizeId,
        this.brandId,
        this.size,
        this.brand,
        this.code,
        this.mostSelling,
        this.numberArrangementUnitsSameItem,
        this.countRates,
        this.totalRate,
        this.inFavorite,
        this.subCategory,
        this.files,
        this.rates,
        this.createDates,
        this.updateDates});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    unit = json['unit'];
    unitPackage = json['unit_package'];
    quantity = json['quantity'];
    price = json['price'];
    priceAfterDiscount = json['price_after_discount'];
    discount = json['discount'];
    savedAmount = json['saved_amount'];
    flavor = json['flavor'];
    shape = json['shape'];
    unitSize = json['unit_size'];
    overallSize = json['overall_size'];
    unitPrice = json['unit_price'];
    cover = json['cover'];
    notes = json['notes'];
    sizeId = json['size_id'];
    brandId = json['brand_id'];
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    code = json['code'];
    mostSelling = json['most_selling'];
    numberArrangementUnitsSameItem = json['number_arrangement_units_same_item'];
    countRates = json['count_rates'];
    totalRate = json['total_rate'];
    inFavorite = json['in_favorite'];
    subCategory = json['sub_category'] != null
        ? new SubCategory.fromJson(json['sub_category'])
        : null;
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    if (json['rates'] != null) {
      rates = [];
      json['rates'].forEach((v) {
        rates!.add(new Rates.fromJson(v));
      });
    }
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['unit_package'] = this.unitPackage;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['price_after_discount'] = this.priceAfterDiscount;
    data['discount'] = this.discount;
    data['saved_amount'] = this.savedAmount;
    data['flavor'] = this.flavor;
    data['shape'] = this.shape;
    data['unit_size'] = this.unitSize;
    data['overall_size'] = this.overallSize;
    data['unit_price'] = this.unitPrice;
    data['cover'] = this.cover;
    data['notes'] = this.notes;
    data['size_id'] = this.sizeId;
    data['brand_id'] = this.brandId;
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['code'] = this.code;
    data['most_selling'] = this.mostSelling;
    data['number_arrangement_units_same_item'] =
        this.numberArrangementUnitsSameItem;
    data['count_rates'] = this.countRates;
    data['total_rate'] = this.totalRate;
    data['in_favorite'] = this.inFavorite;
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.toJson();
    }
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.rates != null) {
      data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    }
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}

class Size {
  int? id;
  String? name;
  int? active;
  String? nameAr;
  String? nameEn;
  CreateDates? createDates;
  UpdateDates? updateDates;

  Size(
      {this.id,
        this.name,
        this.active,
        this.nameAr,
        this.nameEn,
        this.createDates,
        this.updateDates});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['active'] = this.active;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  int? active;
  String? nameAr;
  String? nameEn;
  CreateDates? createDates;
  UpdateDates? updateDates;

  Brand(
      {this.id,
        this.name,
        this.active,
        this.nameAr,
        this.nameEn,
        this.createDates,
        this.updateDates});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['active'] = this.active;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}


class SubCategory {
  var id;
  var name;
  var cover;
  Category? category;
  CreateDates? createDates;
  UpdateDates? updateDates;

  SubCategory(
      {this.id,
        this.name,
        this.cover,
        this.category,
        this.createDates,
        this.updateDates});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.cover;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}

class Category {
  var id;
  var name;
  var cover;
  List<SubCategory>? subCategory;
  CreateDates? createDates;
  UpdateDates? updateDates;

  Category(
      {this.id,
        this.name,
        this.cover,
        this.subCategory,
        this.createDates,
        this.updateDates});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    if (json['sub_category'] != null) {
      subCategory = [];
      json['sub_category'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.cover;
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}


class CreateDates {
  var createdAtHuman;

  CreateDates({this.createdAtHuman});

  CreateDates.fromJson(Map<String, dynamic> json) {
    createdAtHuman = json['created_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at_human'] = this.createdAtHuman;
    return data;
  }
}

class UpdateDates {
  String? updatedAtHuman;

  UpdateDates({this.updatedAtHuman});

  UpdateDates.fromJson(Map<String, dynamic> json) {
    updatedAtHuman = json['updated_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at_human'] = this.updatedAtHuman;
    return data;
  }
}

class Files {
  int? id;
  String? url;
  CreateDates? createDates;
  UpdateDates? updateDates;

  Files({this.id, this.url, this.createDates, this.updateDates});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}

class Rates {
  var id;
  var value;
  var productQuality;
  var deliveryTime;
  var usingExperiences;
  var comment;
  var product;
  var userId;
  User? user;
  CreateDates? createDates;
  UpdateDates? updateDates;

  Rates(
      {this.id,
        this.value,
        this.productQuality,
        this.deliveryTime,
        this.usingExperiences,
        this.comment,
        this.product,
        this.userId,
        this.user,
        this.createDates,
        this.updateDates});

  Rates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    productQuality = json['product_quality'];
    deliveryTime = json['delivery_time'];
    usingExperiences = json['using_experiences'];
    comment = json['comment'];
    product = json['product'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['product_quality'] = this.productQuality;
    data['delivery_time'] = this.deliveryTime;
    data['using_experiences'] = this.usingExperiences;
    data['comment'] = this.comment;
    data['product'] = this.product;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}

class User {
  var id;
  var name;
  var email;
  var phone;
  var type;
  var promoCode;
  var address;
  var rewardPoint;
  var walletBalance;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.type,
        this.promoCode,
        this.address,
        this.rewardPoint,
        this.walletBalance});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    promoCode = json['promo_code'];
    address = json['address'];
    rewardPoint = json['reward_point'];
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['promo_code'] = this.promoCode;
    data['address'] = this.address;
    data['reward_point'] = this.rewardPoint;
    data['wallet_balance'] = this.walletBalance;
    return data;
  }
}

class Meta {
  var total;
  var currentPage;
  var lastPage;

  Meta({this.total, this.currentPage, this.lastPage});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currentPage = json['currentPage'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['currentPage'] = this.currentPage;
    data['lastPage'] = this.lastPage;
    return data;
  }
}