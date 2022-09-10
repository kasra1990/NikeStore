import 'package:nike_flutter/features/root/home/domain/entities/home_data_entity.dart';

class SliderModel extends SliderEntity {
  SliderModel({String? id, String? productId, String? image})
      : super(id: id, productId: productId, image: image);

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
        id: json['id'], productId: json['productId'], image: json['image']);
  }

  static List<SliderModel>? parseJsonArray(List<dynamic> jsonArray) {
    final List<SliderModel> sliders = [];
    for (var json in jsonArray) {
      sliders.add(SliderModel.fromJson(json));
    }
    return sliders;
  }
}
