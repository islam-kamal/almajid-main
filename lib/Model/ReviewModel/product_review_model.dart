import 'package:almajidoud/Base/network-mappers.dart';

class ProductReviewModel extends BaseMappable {
  var id;
  var title;
  var detail;
  var nickname;
  List<Ratings> ratings;
  var reviewEntity;
  var reviewType;
  var reviewStatus;
  var createdAt;
  var entityPkValue;
  var storeId;
  List<int> stores;

  ProductReviewModel(
      {this.id,
        this.title,
        this.detail,
        this.nickname,
        this.ratings,
        this.reviewEntity,
        this.reviewType,
        this.reviewStatus,
        this.createdAt,
        this.entityPkValue,
        this.storeId,
        this.stores});

  ProductReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    nickname = json['nickname'];
    if (json['ratings'] != null) {
      ratings = new List<Ratings>();
      json['ratings'].forEach((v) {
        ratings.add(new Ratings.fromJson(v));
      });
    }
    reviewEntity = json['review_entity'];
    reviewType = json['review_type'];
    reviewStatus = json['review_status'];
    createdAt = json['created_at'];
    entityPkValue = json['entity_pk_value'];
    storeId = json['store_id'];
    stores = json['stores'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['nickname'] = this.nickname;
    if (this.ratings != null) {
      data['ratings'] = this.ratings.map((v) => v.toJson()).toList();
    }
    data['review_entity'] = this.reviewEntity;
    data['review_type'] = this.reviewType;
    data['review_status'] = this.reviewStatus;
    data['created_at'] = this.createdAt;
    data['entity_pk_value'] = this.entityPkValue;
    data['store_id'] = this.storeId;
    data['stores'] = this.stores;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    nickname = json['nickname'];
    if (json['ratings'] != null) {
      ratings = new List<Ratings>();
      json['ratings'].forEach((v) {
        ratings.add(new Ratings.fromJson(v));
      });
    }
    reviewEntity = json['review_entity'];
    reviewType = json['review_type'];
    reviewStatus = json['review_status'];
    createdAt = json['created_at'];
    entityPkValue = json['entity_pk_value'];
    storeId = json['store_id'];
    stores = json['stores'].cast<int>();

      return ProductReviewModel(id: id,createdAt: createdAt,storeId: storeId,title: title,detail: detail,
          entityPkValue: entityPkValue,nickname: nickname,ratings: ratings,reviewEntity: reviewEntity,
          reviewStatus: reviewStatus,reviewType: reviewType,stores: stores);


  }
}

class Ratings {
  var voteId;
  var ratingId;
  var ratingName;
  var percent;
  var value;

  Ratings(
      {this.voteId, this.ratingId, this.ratingName, this.percent, this.value});

  Ratings.fromJson(Map<String, dynamic> json) {
    voteId = json['vote_id'];
    ratingId = json['rating_id'];
    ratingName = json['rating_name'];
    percent = json['percent'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_id'] = this.voteId;
    data['rating_id'] = this.ratingId;
    data['rating_name'] = this.ratingName;
    data['percent'] = this.percent;
    data['value'] = this.value;
    return data;
  }
}