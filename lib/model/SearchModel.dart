import 'ProductData.dart';

class SearchModel {
  bool? status;
  Data? data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =Data.fromJson(json['data']);
  }

}

class Data {
  List<Product> data=[];



  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data.add( ProductSearch.fromJson(v));
    });

  }
}

class ProductSearch extends Product{
  ProductSearch.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['id'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
  }

}
