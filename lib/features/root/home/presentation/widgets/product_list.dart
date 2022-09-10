import 'package:flutter/material.dart';
import 'package:nike_flutter/core/api/entities/product_entity.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/features/root/home/presentation/widgets/single_product.dart';

// list of products
class ProductList extends StatelessWidget {
  final String? title;
  final List<ProductEntity>? products;

  const ProductList({Key? key, required this.title, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title!, style: TextStyle(fontSize: getFontSize(0.016))),
            Text("View All", style: TextStyle(fontSize: getFontSize(0.016)))
          ],
        ),
        SizedBox(
          height: getHeight(0.24),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: products!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final product = products![index];
                return SingleProduct(index: index, product: product);
              }),
        ),
      ],
    );
  }
}
