import 'package:flutter/material.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/features/root/cart/domain/entities/cart_entity.dart';

class CartProduct extends StatelessWidget {
  final CartEntity cart;
  final Animation<double> animation;
  final GestureTapCallback onIncreaseButtonClicked;
  final GestureTapCallback onDecreaseButtonClicked;
  final GestureTapCallback checkedForDelete;

  const CartProduct(
      {Key? key,
      required this.cart,
      required this.animation,
      required this.onIncreaseButtonClicked,
      required this.onDecreaseButtonClicked,
      required this.checkedForDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SizeTransition(
      key: ValueKey(cart.product!.image1),
      sizeFactor: animation,
      child: _builderItem());

  Widget _builderItem() {
    final price =
        double.parse(cart.product!.price!) * double.parse(cart.count!);
    return Card(
      color: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          SizedBox(
            height: getHeight(0.15),
            child: Row(
              children: [
                SizedBox(
                    width: getWidth(0.3),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(15)),
                      child: Image.network(
                        cart.product!.image4!,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(width: getWidth(0.03)),
                SizedBox(
                  width: getWidth(0.52),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: getHeight(0.02)),
                      Expanded(
                        child: Text(cart.product!.name!,
                            style: TextStyle(
                                color: NikeColor.mainColor,
                                fontWeight: FontWeight.w700,
                                fontSize: getFontSize(0.016),
                                overflow: TextOverflow.ellipsis),
                            maxLines: 1),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text(cart.product!.gender!,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: getFontSize(0.015))),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text("Size: ${cart.shoesSize}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: getFontSize(0.015))),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("\$${price.toStringAsFixed(2)}",
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: NikeColor.mainColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: getFontSize(0.016),
                                    ))),
                            InkWell(
                              onTap: onDecreaseButtonClicked,
                              child: Icon(
                                  Icons.indeterminate_check_box_outlined,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            SizedBox(width: getWidth(0.01)),
                            Text(cart.count!,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: getFontSize(0.017))),
                            SizedBox(width: getWidth(0.01)),
                            InkWell(
                              onTap: onIncreaseButtonClicked,
                              child: Icon(Icons.add_box_outlined,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 0),
          SizedBox(
            width: double.infinity,
            child: TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: checkedForDelete,
                child: Text("Delete",
                    style: TextStyle(
                        color: NikeColor.mainColor,
                        fontSize: getFontSize(0.016)))),
          )
        ],
      ),
    );
  }
}
