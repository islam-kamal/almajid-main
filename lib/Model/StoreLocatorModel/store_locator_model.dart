import 'package:almajidoud/Base/network-mappers.dart';

class StoreLocatorModel extends BaseMappable {
  var id;
  var name;
  var country;
  var city;
  var zip;
  var address;
  var status;
  var lat;
  var lng;
  var photo;
  var marker;
  var position;
  var state;
  var description;
  var phone;
  var email;
  var website;
  var category;
  var actionsSerialized;
  var storeImg;
  var stores;
  var schedule;
  var markerImg;
  var showSchedule;
  var urlKey;
  var metaTitle;
  var metaDescription;
  var metaRobots;
  var shortDescription;
  var canonicalUrl;
  var conditionType;
  var curbsideEnabled;
  var curbsideConditionsText;
  var scheduleString;
  var markerUrl;
  var popupHtml;
  List<Attributes>? attributes;
  var scheduleArray;

  StoreLocatorModel(
      {this.id,
        this.name,
        this.country,
        this.city,
        this.zip,
        this.address,
        this.status,
        this.lat,
        this.lng,
        this.photo,
        this.marker,
        this.position,
        this.state,
        this.description,
        this.phone,
        this.email,
        this.website,
        this.category,
        this.actionsSerialized,
        this.storeImg,
        this.stores,
        this.schedule,
        this.markerImg,
        this.showSchedule,
        this.urlKey,
        this.metaTitle,
        this.metaDescription,
        this.metaRobots,
        this.shortDescription,
        this.canonicalUrl,
        this.conditionType,
        this.curbsideEnabled,
        this.curbsideConditionsText,
        this.scheduleString,
        this.markerUrl,
        this.popupHtml,
        this.attributes,
        this.scheduleArray});

  StoreLocatorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    city = json['city'];
    zip = json['zip'];
    address = json['address'];
    status = json['status'];
    lat = json['lat'];
    lng = json['lng'];
    photo = json['photo'];
    marker = json['marker'];
    position = json['position'];
    state = json['state'];
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    category = json['category'];
    actionsSerialized = json['actions_serialized'];
    storeImg = json['store_img'];
    stores = json['stores'];
    schedule = json['schedule'];
    markerImg = json['marker_img'];
    showSchedule = json['show_schedule'];
    urlKey = json['url_key'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaRobots = json['meta_robots'];
    shortDescription = json['short_description'];
    canonicalUrl = json['canonical_url'];
    conditionType = json['condition_type'];
    curbsideEnabled = json['curbside_enabled'];
    curbsideConditionsText = json['curbside_conditions_text'];
    scheduleString = json['schedule_string'];
    markerUrl = json['marker_url'];
    popupHtml = json['popup_html'];
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    scheduleArray = json['schedule_array'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['address'] = this.address;
    data['status'] = this.status;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['photo'] = this.photo;
    data['marker'] = this.marker;
    data['position'] = this.position;
    data['state'] = this.state;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['website'] = this.website;
    data['category'] = this.category;
    data['actions_serialized'] = this.actionsSerialized;
    data['store_img'] = this.storeImg;
    data['stores'] = this.stores;
    data['schedule'] = this.schedule;
    data['marker_img'] = this.markerImg;
    data['show_schedule'] = this.showSchedule;
    data['url_key'] = this.urlKey;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_robots'] = this.metaRobots;
    data['short_description'] = this.shortDescription;
    data['canonical_url'] = this.canonicalUrl;
    data['condition_type'] = this.conditionType;
    data['curbside_enabled'] = this.curbsideEnabled;
    data['curbside_conditions_text'] = this.curbsideConditionsText;
    data['schedule_string'] = this.scheduleString;
    data['marker_url'] = this.markerUrl;
    data['popup_html'] = this.popupHtml;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    data['schedule_array'] = this.scheduleArray;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    city = json['city'];
    zip = json['zip'];
    address = json['address'];
    status = json['status'];
    lat = json['lat'];
    lng = json['lng'];
    photo = json['photo'];
    marker = json['marker'];
    position = json['position'];
    state = json['state'];
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    category = json['category'];
    actionsSerialized = json['actions_serialized'];
    storeImg = json['store_img'];
    stores = json['stores'];
    schedule = json['schedule'];
    markerImg = json['marker_img'];
    showSchedule = json['show_schedule'];
    urlKey = json['url_key'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaRobots = json['meta_robots'];
    shortDescription = json['short_description'];
    canonicalUrl = json['canonical_url'];
    conditionType = json['condition_type'];
    curbsideEnabled = json['curbside_enabled'];
    curbsideConditionsText = json['curbside_conditions_text'];
    scheduleString = json['schedule_string'];
    markerUrl = json['marker_url'];
    popupHtml = json['popup_html'];
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    scheduleArray = json['schedule_array'];
    return StoreLocatorModel(
      description: description,phone: phone,id: id,actionsSerialized: actionsSerialized,address: address
           ,  attributes: attributes,canonicalUrl: canonicalUrl , category: category,city: city,conditionType: conditionType,
    country: country,curbsideConditionsText: curbsideConditionsText,curbsideEnabled: curbsideEnabled,email: email,lat: lat,lng: lng,
    marker: marker,markerImg: markerImg,metaDescription: metaDescription,markerUrl: markerUrl,metaRobots: metaRobots,
    metaTitle: metaTitle,name: name,photo: photo,popupHtml: popupHtml,position: position,schedule: schedule,scheduleArray: scheduleArray,scheduleString: scheduleString,shortDescription: shortDescription,
    showSchedule: showSchedule,state: state,status: status,storeImg: storeImg,stores: stores,urlKey: urlKey,website: website,zip: zip,);
  }
}

class Attributes{
  var id;
  var name;
  Attributes({this.id,this.name});
  Attributes.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}