import 'package:nike_flutter/core/api/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {String? id,
      String? name,
      String? image1,
      String? image2,
      String? image3,
      String? image4,
      String? gender,
      String? price,
      String? description,
      String? visited,
      String? dateCreated,
      int? favorite})
      : super(
            id: id,
            name: name,
            image1: image1,
            image2: image2,
            image3: image3,
            image4: image4,
            gender: gender,
            price: price,
            description: description,
            visited: visited,
            dateCreated: dateCreated,
            favorite: favorite);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        image1: json['image1'],
        image2: json['image2'],
        image3: json['image3'],
        image4: json['image4'],
        gender: json['gender'],
        price: json['price'],
        description: json['description'],
        visited: json['visited'],
        dateCreated: json['date_create'],
        favorite: json['favorite']);
  }

  static List<ProductModel> parseJsonArray(List<dynamic> jsonArray) {
    final List<ProductModel> products = [];
    for (var json in jsonArray) {
      products.add(ProductModel.fromJson(json));
    }
    return products;
  }
}
