import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/features/root/product/presentation/bloc/product_bloc.dart';

import '../../../../../core/utils/nike_color.dart';
import '../../../../../core/utils/size_config.dart';

/// manage sized row UI
class ProductSizes extends StatelessWidget {
  const ProductSizes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productSizes = ["40", "41", "41.5", "42", "42.5"];
    String selectedProductSize = productSizes[0];
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: ((previous, current) {
        if (current is ProductChangShoesSize) {
          selectedProductSize = current.productSize;
          return true;
        } else {
          return false;
        }
      }),
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var size in productSizes)
              _productSizes(
                  size: size,
                  selected: selectedProductSize == size,
                  onClick: () {
                    context.read<ProductBloc>().add(ProductSetShoesSize(size));
                  })
          ],
        );
      },
    );
  }

  ///single size icon
  Widget _productSizes(
      {required String size,
      required bool selected,
      required Function() onClick}) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        width: getWidth(0.13),
        height: getWidth(0.13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: NikeColor.mainColor, width: 1),
          color: selected ? NikeColor.mainColor : Colors.white,
        ),
        child: Text(size,
            style: TextStyle(
                fontSize: getFontSize(0.02),
                color: selected ? Colors.white : NikeColor.mainColor)),
      ),
    );
  }
}
