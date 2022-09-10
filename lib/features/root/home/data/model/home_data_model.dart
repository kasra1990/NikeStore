import 'package:nike_flutter/features/root/home/domain/entities/home_data_entity.dart';

import 'slider_model.dart';
import '../../../../../core/api/models/product_model.dart';

class HomeDataModel extends HomeDataEntity {
  HomeDataModel(
      {List<SliderModel>? sliders,
      List<ProductModel>? newArrivals,
      List<ProductModel>? mostPopular})
      : super(
            sliders: sliders,
            newArrivals: newArrivals,
            mostPopular: mostPopular);

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
        sliders: SliderModel.parseJsonArray(json['slider']),
        newArrivals: ProductModel.parseJsonArray(json['newArrivals']),
        mostPopular: ProductModel.parseJsonArray(json['mostPopular']));
  }
}
