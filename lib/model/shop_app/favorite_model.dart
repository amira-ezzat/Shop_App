class FavoritesModel {
  late bool status;
  String? message; // Change Null to String?

  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late int currentPage;
  late List<FavoriteData> data;
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late String? nextPageUrl; // Change Null to String?
  late String path;
  late int perPage;
  late String? prevPageUrl; // Change Null to String?
  late int to;
  late int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = <FavoriteData>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(FavoriteData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavoriteData {
  late int id;
  late Product product;

  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = (json['product'] != null ? Product.fromJson(json['product']) : null)!;
  }
}

class Product {
  int id = 0;
  dynamic price = 0;
  dynamic oldPrice = 0;
  dynamic discount = 0;
  String image = '';
  String name = '';
  String description = '';

  Product({required this.id,this.price,this.oldPrice,this.discount,required this.image,required this.name,required this.description});
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
