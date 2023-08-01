abstract class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  late bool inFavorites;
  Product.fromJson(Map<String, dynamic> json) ;
}