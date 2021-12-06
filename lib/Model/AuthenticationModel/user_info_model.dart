import 'package:almajidoud/Base/network-mappers.dart';

class UserInfoModel extends BaseMappable {
  int id;
  int groupId;
  String createdAt;
  String updatedAt;
  String createdIn;
  String email;
  String firstname;
  String lastname;
  int storeId;
  int websiteId;
  List<Addresses> addresses;
  int disableAutoGroupChange;
  ExtensionAttributes extensionAttributes;
  List<CustomAttributes> customAttributes;
  String message;
  Parameters parameters;
  String trace;
  UserInfoModel(
      {this.id,
        this.groupId,
        this.createdAt,
        this.updatedAt,
        this.createdIn,
        this.email,
        this.firstname,
        this.lastname,
        this.storeId,
        this.websiteId,
        this.addresses,
        this.disableAutoGroupChange,
        this.extensionAttributes,
        this.customAttributes,
        this.message,
        this.parameters,
        this.trace});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdIn = json['created_in'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    storeId = json['store_id'];
    websiteId = json['website_id'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    disableAutoGroupChange = json['disable_auto_group_change'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    if (json['custom_attributes'] != null) {
      customAttributes = new List<CustomAttributes>();
      json['custom_attributes'].forEach((v) {
        customAttributes.add(new CustomAttributes.fromJson(v));
      });
    }
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    trace = json['trace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_in'] = this.createdIn;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['store_id'] = this.storeId;
    data['website_id'] = this.websiteId;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    data['disable_auto_group_change'] = this.disableAutoGroupChange;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes.toJson();
    }
    if (this.customAttributes != null) {
      data['custom_attributes'] =
          this.customAttributes.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    if (this.parameters != null) {
      data['parameters'] = this.parameters.toJson();
    }
    data['trace'] = this.trace;

    return data;

  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdIn = json['created_in'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    storeId = json['store_id'];
    websiteId = json['website_id'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    disableAutoGroupChange = json['disable_auto_group_change'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    if (json['custom_attributes'] != null) {
      customAttributes = new List<CustomAttributes>();
      json['custom_attributes'].forEach((v) {
        customAttributes.add(new CustomAttributes.fromJson(v));
      });
    }
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    trace = json['trace'];
    print("11111111-1111111111111111");
    if(message == null){
      print("2222222-222222222");

      return UserInfoModel(
          storeId: storeId,
          email: email,
          addresses: addresses,
          createdAt: createdAt,
          createdIn: createdIn,
          customAttributes: customAttributes,
          disableAutoGroupChange: disableAutoGroupChange,
          extensionAttributes: extensionAttributes,
          firstname: firstname,
          groupId: groupId,
          id: id,
          lastname: lastname,
          updatedAt: updatedAt,
          websiteId: websiteId
      );

    }else{
      print("333333333-3333333333333");

      return UserInfoModel(message: message,trace: trace,parameters: parameters);
    }
  }
}

class ExtensionAttributes {
  bool isSubscribed;

  ExtensionAttributes({this.isSubscribed});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    isSubscribed = json['is_subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_subscribed'] = this.isSubscribed;
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

class Addresses {
  bool isSubscribed;

  Addresses({this.isSubscribed});

  Addresses.fromJson(Map<String, dynamic> json) {
    isSubscribed = json['is_subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_subscribed'] = this.isSubscribed;
    return data;
  }
}


class Parameters {
  String resources;

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