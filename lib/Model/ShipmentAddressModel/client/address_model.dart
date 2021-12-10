
import 'package:almajidoud/Base/network-mappers.dart';

class AddressModel extends BaseMappable{
  var id;
  var customerId;
  Region region;
  var regionId;
  var countryId;
  List<String> street;
  var telephone;
  var postcode;
  var city;
  var firstname;
  var lastname;
  String message;
  Parameters parameters;
  AddressModel(
      {this.id,
        this.customerId,
        this.region,
        this.regionId,
        this.countryId,
        this.street,
        this.telephone,
        this.postcode,
        this.city,
        this.firstname,
        this.lastname,this.message,this.parameters});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    regionId = json['region_id'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    data['region_id'] = this.regionId;
    data['country_id'] = this.countryId;
    data['street'] = this.street;
    data['telephone'] = this.telephone;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    regionId = json['region_id'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    return AddressModel(parameters: parameters,message: message,customerId: customerId,id: id,lastname: lastname,
    firstname: firstname,city: city,countryId: countryId,postcode: postcode,region: region,regionId: regionId,
    street: street,telephone: telephone);
  }
}

class Region {
  var regionCode;
  var region;
  var regionId;

  Region({this.regionCode, this.region, this.regionId});

  Region.fromJson(Map<String, dynamic> json) {
    regionCode = json['region_code'];
    region = json['region'];
    regionId = json['region_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_code'] = this.regionCode;
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    return data;
  }
}
class Parameters {
  String fieldName;
  Null fieldValue;

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