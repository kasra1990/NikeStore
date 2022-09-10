import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/features/root/home/domain/entities/home_data_entity.dart';

/// create a single slide
class Slide extends StatelessWidget {
  final SliderEntity? banner;

  const Slide({Key? key, required this.banner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getWidth(0.03), right: getWidth(0.03)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: banner!.image!,
          width: null,
          height: null,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
