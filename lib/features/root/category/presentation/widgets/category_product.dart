import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_flutter/core/api/entities/product_entity.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/features/root/product/presentation/pages/product_screen.dart';

import '../../../../../core/utils/nike_color.dart';

//Single product of category
class CategoryProduct extends StatelessWidget {
  final ProductEntity product;

  const CategoryProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: getHeight(0.01),
        bottom: getHeight(0.01),
      ),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
          Navigator.of(context)
              .pushNamed(ProductScreen.routeName, arguments: product);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                  imageUrl: product.image1!,
                  key: UniqueKey(),
                  alignment: Alignment.center,
                  width: getWidth(0.5),
                  height: getHeight(0.24),
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(
                        color: NikeColor.mainImageColor,
                      )),
            ),
            Positioned(
                top: getHeight(0.015),
                left: getWidth(0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name!,
                        style: TextStyle(fontSize: getFontSize(0.012))),
                    SizedBox(height: getHeight(0.005)),
                    Text(product.gender!,
                        style: TextStyle(fontSize: getFontSize(0.012))),
                  ],
                )),
            Positioned(
                bottom: getHeight(0.02),
                left: getWidth(0.025),
                child: Text(
                  "\$${product.price}",
                  style: TextStyle(fontSize: getFontSize(0.012)),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/heart_icon.svg'),
                  onPressed: () {},
                ))
          ],
        ),
      ),
    );
  }
}
