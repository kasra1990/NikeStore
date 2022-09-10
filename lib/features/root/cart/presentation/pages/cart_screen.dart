import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/nike_notifiers.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/core/widgets/error_page.dart';
import 'package:nike_flutter/core/widgets/loading.dart';
import 'package:nike_flutter/features/root/auth/register/presentation/pages/sign_in_screen.dart';
import 'package:nike_flutter/features/root/cart/domain/entities/cart_entity.dart';
import 'package:nike_flutter/features/root/cart/presentation/bloc/cart_bloc.dart';
import 'package:nike_flutter/features/root/cart/presentation/widgets/cart_product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    NikeNotifiers.authRefreshNotifier.addListener(_cartStart);
    NikeNotifiers.cartRefreshNotifier.addListener(_cartStart);
    NikeNotifiers.tryConnection.addListener(_cartStart);
    _cartStart();
    super.initState();
  }

  void _cartStart() {
    context.read<CartBloc>().add(CartStarted());
  }

  @override
  void dispose() {
    NikeNotifiers.cartRefreshNotifier.removeListener(_cartStart);
    NikeNotifiers.authRefreshNotifier.removeListener(_cartStart);
    NikeNotifiers.tryConnection.removeListener(_cartStart);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartMessage) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: _cartUI(),
      ));

  ///cart UI
  Widget _cartUI() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _cartAppBar(),
        body: BlocBuilder<CartBloc, CartState>(
          buildWhen: (previous, current) {
            if (current is CartMessage) {
              return false;
            } else {
              return true;
            }
          },
          builder: (context, state) {
            debugPrint("CartState -> $state");
            if (state is CartLoading) {
              return const Loading();
            } else if (state is CartSuccess) {
              debugPrint("CartScreen -> user: ${state.carts}");
              return _successStateUI(
                  data: state.carts.carts, totalPayment: state.totalPayment);
            } else if (state is CartError) {
              return ErrorPage(error: state.error);
            } else if (state is CartNotAuthentication) {
              return _emptyShoppingCart();
            } else if (state is CartEmpty) {
              return const Center(child: Text("Your shopping cart is empty"));
            } else {
              throw Exception("this state is not supported");
            }
          },
        ));
  }

  ///AppBar
  PreferredSizeWidget _cartAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Image.asset('assets/icons/nike_logo.png',
          fit: BoxFit.cover, height: getHeight(0.03)),
      centerTitle: true,
    );
  }

  ///show this UI if state is success
  Widget _successStateUI(
      {required List<CartEntity> data, required String totalPayment}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(0.05)),
      child: Stack(
        children: [
          AnimatedList(
              key: listKey,
              initialItemCount: data.length + 1,
              itemBuilder: (context, index, animation) {
                if (index < data.length) {
                  return _cartList(
                      dataEntity: data, index: index, animation: animation);
                } else {
                  return _totalPaymentUI(totalPayment: totalPayment);
                }
              }),
          Positioned(bottom: 0, child: _opaqueUI()),
          Positioned(bottom: getHeight(0.01), child: _checkButton())
        ],
      ),
    );
  }

  /// list of carts
  Widget _cartList(
      {required List<CartEntity> dataEntity,
      required int index,
      required Animation<double> animation}) {
    final cart = dataEntity[index];
    final count = int.parse(cart.count!);
    return Padding(
        padding: EdgeInsets.only(bottom: getHeight(0.02)),
        child: CartProduct(
            cart: cart,
            animation: animation,
            onDecreaseButtonClicked: () {
              debugPrint("Cart -> Decrease");
              if (count >= 1) {
                context.read<CartBloc>().add(CartDecreaseCount(cart));
              }
            },
            onIncreaseButtonClicked: () {
              debugPrint("Cart -> increase");
              context.read<CartBloc>().add(CartIncreaseCount(cart));
            },
            checkedForDelete: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 3),
                content: const Text("Do you want to delte this item?"),
                action: SnackBarAction(
                    label: "Yes",
                    onPressed: () {
                      _removeItem(dataEntity, index);
                      context
                          .read<CartBloc>()
                          .add(CartDeleteProducts(cart.cartId!));
                    }),
              ));
            }));
  }

  /// total payment UI
  Widget _totalPaymentUI({required String totalPayment}) {
    final total = double.parse(totalPayment).toStringAsFixed(2);
    return Column(
      children: [
        SizedBox(height: getHeight(0.015)),
        Divider(height: 1, color: Colors.black.withOpacity(0.5)),
        SizedBox(height: getHeight(0.015)),
        Row(
          children: [
            Expanded(
                child: Text("Total Payment",
                    style: TextStyle(
                        color: NikeColor.mainColor,
                        fontSize: getFontSize(0.017),
                        fontWeight: FontWeight.w700))),
            Text("\$ $total",
                maxLines: 1,
                style: TextStyle(
                    color: NikeColor.mainColor,
                    fontSize: getFontSize(0.017),
                    fontWeight: FontWeight.w700)),
          ],
        ),
        SizedBox(height: getHeight(0.12))
      ],
    );
  }

  /// opaque UI for behind checkOut button
  Widget _opaqueUI() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: getHeight(0.075),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.white, Colors.white.withOpacity(0.7)])),
    );
  }

  /// CheckOut button
  Widget _checkButton() {
    return SizedBox(
      width: getWidth(0.9),
      height: getHeight(0.055),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(NikeColor.mainColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)))),
        onPressed: () {},
        child: Text("Check Out",
            style:
                TextStyle(color: Colors.white, fontSize: getFontSize(0.018))),
      ),
    );
  }

  ///empty shopping cart UI
  Widget _emptyShoppingCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "To view the shopping cart, please login",
            style: TextStyle(fontSize: getFontSize(0.017)),
          ),
          SizedBox(height: getHeight(0.01)),
          OutlinedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(getWidth(0.5), getHeight(0.045))),
                  overlayColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0.3)),
                  foregroundColor:
                      MaterialStateProperty.all(NikeColor.mainColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)))),
              onPressed: () {
                Navigator.of(context).pushNamed(SignInScreen.routeName);
              },
              child: Text(
                "login",
                style: TextStyle(
                    fontSize: getFontSize(0.016), fontWeight: FontWeight.w400),
              )),
        ],
      ),
    );
  }

  /// remove item form cart
  void _removeItem(List<CartEntity> items, int index) {
    final removedItem = items[index];
    items.removeAt(index);
    listKey.currentState!.removeItem(
        index,
        (context, animation) => CartProduct(
            cart: removedItem,
            animation: animation,
            onIncreaseButtonClicked: () {},
            onDecreaseButtonClicked: () {},
            checkedForDelete: () {}),
        duration: const Duration(milliseconds: 400));
  }
}
