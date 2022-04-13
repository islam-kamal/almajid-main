import 'package:almajidoud/Base/network-mappers.dart';

class ProductReviewModel extends BaseMappable{
  int? id;
  String? title;
  String? detail;
  String? nickname;
  List<Ratings>? ratings;
  String? reviewEntity;
  int? reviewType;
  int? reviewStatus;
  String? createdAt;
  int? entityPkValue;
  int? storeId;
  List<int>? stores;
  String? message;
  String? trace;
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
        this.message, this.trace,
        this.stores});

  ProductReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    nickname = json['nickname'];
    if (json['ratings'] != null) {
      ratings = [];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
    reviewEntity = json['review_entity'];
    reviewType = json['review_type'];
    reviewStatus = json['review_status'];
    createdAt = json['created_at'];
    entityPkValue = json['entity_pk_value'];
    storeId = json['store_id'];
    stores = json['stores'].cast<int>();
    message = json['message'];
    trace = json['trace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['nickname'] = this.nickname;
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    data['review_entity'] = this.reviewEntity;
    data['review_type'] = this.reviewType;
    data['review_status'] = this.reviewStatus;
    data['created_at'] = this.createdAt;
    data['entity_pk_value'] = this.entityPkValue;
    data['store_id'] = this.storeId;
    data['stores'] = this.stores;
    data['message'] = this.message;
    data['trace'] = this.trace;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    nickname = json['nickname'];
    if (json['ratings'] != null) {
      ratings = [];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
    reviewEntity = json['review_entity'];
    reviewType = json['review_type'];
    reviewStatus = json['review_status'];
    createdAt = json['created_at'];
    entityPkValue = json['entity_pk_value'];
    storeId = json['store_id'];
    stores = json['stores'].cast<int>();
    message = json['message'];
    trace = json['trace'];
    return ProductReviewModel(
      trace: trace,
      message: message,
      id: id,
      title: title,
      storeId: storeId,
      createdAt: createdAt,
      detail: detail,
      entityPkValue: entityPkValue,
      nickname: nickname,
      ratings: ratings,
      reviewEntity: reviewEntity,
      reviewStatus: reviewStatus,
      stores: stores,
      reviewType: reviewType
    );
  }
}

class Ratings {
  int? voteId;
  int? ratingId;
  String? ratingName;
  int? percent;
  int? value;

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