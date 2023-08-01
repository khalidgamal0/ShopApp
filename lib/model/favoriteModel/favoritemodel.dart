import '../ProductData.dart';

class FavoriteModel{
  bool? status;
  FavoriteDataModel? data;
  FavoriteModel.fromjson(Map<String,dynamic>json){
    status=json['status'];
    data=FavoriteDataModel.fromjson(json['data']);
  }
}
class FavoriteDataModel{
  int? current_page;
 List<DataModel>data=[];
  FavoriteDataModel.fromjson(Map<String,dynamic>json){
    current_page=json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromjson(element));
    });
  }
}
class DataModel{
  int? id;
  Product? product;

  DataModel.fromjson(Map<String,dynamic>json){
    id = json['id'];
    product = ProductFavorite.fromJson(json['product']);
  }
}
class ProductFavorite extends Product{

  ProductFavorite.fromJson(Map<String,dynamic>json) : super.fromJson(json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}