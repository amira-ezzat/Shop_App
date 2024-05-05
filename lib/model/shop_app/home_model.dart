import 'dart:convert';
import 'dart:core';
import 'dart:core';
class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<bannerModel> banners=[];
  List<productModel> products=[];
  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element) {
      final banner = bannerModel.fromJson(element);
      banners.add(banner);
    });
    json['products'].forEach((element) {
      final product = productModel.fromJson(element);
      products.add(product);
    });

  }
}
class bannerModel {
  int id=0;
  String image='';
  bannerModel.fromJson(Map<String, dynamic> json)
  {
    id=json['id'] ;
    image=json['image'];
  }
}
class productModel {
  int id=0;
  dynamic price=0;
  dynamic oldPrice=0;
  dynamic discount=0;
  String image='';
  String name='' ;
  bool inFavorites =false  ;
  bool inCart = false;
  productModel.fromJson(Map<String, dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
  }
}
