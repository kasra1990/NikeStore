import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_flutter/core/api/entities/product_entity.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/features/root/product/presentation/widgets/product_sizes.dart';

/// Single Product page
class ProductBody extends StatefulWidget {
  final ProductEntity product;

  const ProductBody({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                  imageUrl: widget.product.image1!,
                  key: UniqueKey(),
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                        color: NikeColor.mainImageColor,
                      )),
            ),
            expandedHeight: getHeight(0.4),
            foregroundColor: NikeColor.mainColor,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/heart_icon.svg'))
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                  left: getWidth(0.05),
                  right: getWidth(0.06),
                  top: getHeight(0.025)),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, color: Colors.black.withOpacity(0.1))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.gender!,
                      style: TextStyle(
                          fontSize: getFontSize(0.017),
                          color: Colors.black.withOpacity(0.5))),
                  SizedBox(height: getHeight(0.01)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.name!,
                          style: TextStyle(
                              fontSize: getFontSize(0.02),
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text("\$${widget.product.price}",
                          style: TextStyle(
                              fontSize: getFontSize(0.02),
                              fontWeight: FontWeight.bold,
                              color: Colors.black))
                    ],
                  ),
                  SizedBox(height: getHeight(0.04)),
                  Text("Sizes",
                      style: TextStyle(
                          fontSize: getFontSize(0.02), color: Colors.black)),
                  SizedBox(height: getHeight(0.02)),
                  const ProductSizes(),
                  SizedBox(height: getHeight(0.03)),
                  Text("Description",
                      style: TextStyle(
                          fontSize: getFontSize(0.02), color: Colors.black)),
                  SizedBox(height: getHeight(0.01)),
                  Text(
                    widget.product.description!,
                    style: TextStyle(
                        height: getHeight(0.002),
                        color: Colors.black.withOpacity(0.5)),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: getHeight(0.085))
                ],
              ),
            ),
          ),
        ],
      ),
      Positioned(bottom: 0, child: _opaqueUI())
    ]);
  }

  /// opaque UI for bottom of screen behind addToCart button
  Widget _opaqueUI() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: getHeight(0.081),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.white, Colors.white.withOpacity(0.7)])),
    );
  }
}
