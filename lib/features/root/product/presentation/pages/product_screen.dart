import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nike_flutter/core/api/entities/product_entity.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/nike_notifiers.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/pages/sign_in_screen.dart';
import 'package:nike_flutter/features/root/product/presentation/bloc/product_bloc.dart';
import 'package:nike_flutter/features/root/product/presentation/widgets/product_body.dart';

class ProductScreen extends StatefulWidget {
  final ProductEntity product;
  static const String routeName = "prosuct_screen";
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        /// show SnackBar when added product successfully
        if (state is ProductAddedSuccess) {
          NikeNotifiers.cartRefreshNotifier.value = true;

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.model.message!)));
        }

        /// show SnackBar when added product faild
        if (state is ProductError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }

        /// go to login page when user not login
        if (state is ProductUserNotLogin) {
          Navigator.of(context).pushNamed(SignInScreen.routeName);
        }
      },
      child: _productUI(),
    ));
  }

  /// prodcuct UI screen
  Widget _productUI() {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          width: getWidth(0.9),
          child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                context
                    .read<ProductBloc>()
                    .add(ProductAddToCart(widget.product.id!));
              },
              foregroundColor: Colors.white,
              backgroundColor: NikeColor.mainColor,
              icon: SvgPicture.asset("assets/icons/buy_icon.svg",
                  color: Colors.white),
              label: const Text("Add To Cart"))),
      body: ProductBody(product: widget.product),
    );
  }
}
