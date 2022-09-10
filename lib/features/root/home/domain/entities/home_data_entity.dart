import 'package:nike_flutter/core/api/entities/product_entity.dart';

class HomeDataEntity {
  final List<SliderEntity>? sliders;
  final List<ProductEntity>? newArrivals;
  final List<ProductEntity>? mostPopular;

  HomeDataEntity({this.sliders, this.newArrivals, this.mostPopular});
}

class SliderEntity {
  final String? id;
  final String? productId;
  final String? image;

  SliderEntity({this.id, this.productId, this.image});
}
