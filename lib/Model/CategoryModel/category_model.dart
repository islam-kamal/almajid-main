import 'package:almajidoud/Base/network-mappers.dart';

/*
class CategoryModel extends BaseMappable {
  List<Items> items;
  SearchCriteria searchCriteria;
  int totalCount;

  CategoryModel({this.items, this.searchCriteria, this.totalCount});

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
    return CategoryModel(
        items: items, searchCriteria: searchCriteria, totalCount: totalCount);
  }
}

class Items {
  int id;
  int parentId;
  String name;
  int position;
  int level;
  String children;
  String createdAt;
  String updatedAt;
  String path;
  List<AvaliableSortBy> availableSortBy;
  bool includeInMenu;
  List<CustomAttributes> customAttributes;
  bool isActive;

  Items(
      {this.id,
      this.parentId,
      this.name,
      this.position,
      this.level,
      this.children,
      this.createdAt,
      this.updatedAt,
      this.path,
      this.availableSortBy,
      this.includeInMenu,
      this.customAttributes,
      this.isActive});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    position = json['position'];
    level = json['level'];
    children = json['children'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    path = json['path'];
    if (json['available_sort_by'] != null) {
      availableSortBy = new List<Null>();
      json['available_sort_by'].forEach((v) {
        availableSortBy.add(new AvaliableSortBy.fromJson(v));
      });
    }
    includeInMenu = json['include_in_menu'];
    if (json['custom_attributes'] != null) {
      customAttributes = new List<CustomAttributes>();
      json['custom_attributes'].forEach((v) {
        customAttributes.add(new CustomAttributes.fromJson(v));
      });
    }
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['position'] = this.position;
    data['level'] = this.level;
    data['children'] = this.children;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['path'] = this.path;
    if (this.availableSortBy != null) {
      data['available_sort_by'] =
          this.availableSortBy.map((v) => v.toJson()).toList();
    }
    data['include_in_menu'] = this.includeInMenu;
    if (this.customAttributes != null) {
      data['custom_attributes'] =
          this.customAttributes.map((v) => v.toJson()).toList();
    }
    data['is_active'] = this.isActive;
    return data;
  }
}

class CustomAttributes {
  String attributeCode;
  String value;

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
  int pageSize;

  SearchCriteria({this.filterGroups, this.pageSize});

  SearchCriteria.fromJson(Map<String, dynamic> json) {
    if (json['filter_groups'] != null) {
      filterGroups = new List<FilterGroups>();
      json['filter_groups'].forEach((v) {
        filterGroups.add(new FilterGroups.fromJson(v));
      });
    }
    pageSize = json['page_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filterGroups != null) {
      data['filter_groups'] = this.filterGroups.map((v) => v.toJson()).toList();
    }
    data['page_size'] = this.pageSize;
    return data;
  }
}

class AvaliableSortBy {
  AvaliableSortBy();

  AvaliableSortBy.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {}
}

class FilterGroups {
  FilterGroups();

  FilterGroups.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {}
}
*/


class CategoryModel extends BaseMappable{
  int id;
  int parentId;
  String name;
  bool isActive;
  int position;
  int level;
  int productCount;
  List<ChildrenData> childrenData;

  CategoryModel(
      {this.id,
        this.parentId,
        this.name,
        this.isActive,
        this.position,
        this.level,
        this.productCount,
        this.childrenData});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    productCount = json['product_count'];
    if (json['children_data'] != null) {
      childrenData = new List<ChildrenData>();
      json['children_data'].forEach((v) {
        childrenData.add(new ChildrenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['product_count'] = this.productCount;
    if (this.childrenData != null) {
      data['children_data'] = this.childrenData.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    productCount = json['product_count'];
    if (json['children_data'] != null) {
      childrenData = new List<ChildrenData>();
      json['children_data'].forEach((v) {
        childrenData.add(new ChildrenData.fromJson(v));
      });
    }
    return CategoryModel(id: id,childrenData: childrenData,isActive: isActive,
        level: level,name: name,parentId: parentId,position: position,productCount: productCount);
  }
}

class ChildrenData {
  int id;
  int parentId;
  String name;
  bool isActive;
  int position;
  int level;
  int productCount;
  List<CategoryChildrenData> childrenData;

  ChildrenData(
      {this.id,
        this.parentId,
        this.name,
        this.isActive,
        this.position,
        this.level,
        this.productCount,
        this.childrenData});

  ChildrenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    productCount = json['product_count'];
    if (json['children_data'] != null) {
      childrenData = new List<CategoryChildrenData>();
      json['children_data'].forEach((v) {
        childrenData.add(new CategoryChildrenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['product_count'] = this.productCount;
    if (this.childrenData != null) {
      data['children_data'] = this.childrenData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryChildrenData {
  int id;
  int parentId;
  String name;
  bool isActive;
  int position;
  int level;
  int productCount;
  List<SubCategoryChildrenData> childrenData;

  CategoryChildrenData(
      {this.id,
        this.parentId,
        this.name,
        this.isActive,
        this.position,
        this.level,
        this.productCount,
        this.childrenData});

  CategoryChildrenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    productCount = json['product_count'];
    if (json['children_data'] != null) {
      childrenData = new List<Null>();
      json['children_data'].forEach((v) {
        childrenData.add(new SubCategoryChildrenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['product_count'] = this.productCount;
    if (this.childrenData != null) {
      data['children_data'] = this.childrenData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryChildrenData {
  int id;
  int parentId;
  String name;
  bool isActive;
  int position;
  int level;
  int productCount;
  List<SubCategoryChildrenData> childrenData;

  SubCategoryChildrenData(
      {this.id,
        this.parentId,
        this.name,
        this.isActive,
        this.position,
        this.level,
        this.productCount,
        this.childrenData});

  SubCategoryChildrenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    position = json['position'];
    level = json['level'];
    productCount = json['product_count'];
    if (json['children_data'] != null) {
      childrenData = new List<SubCategoryChildrenData>();
      json['children_data'].forEach((v) {
        childrenData.add(new SubCategoryChildrenData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['position'] = this.position;
    data['level'] = this.level;
    data['product_count'] = this.productCount;
    if (this.childrenData != null) {
      data['children_data'] = this.childrenData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
