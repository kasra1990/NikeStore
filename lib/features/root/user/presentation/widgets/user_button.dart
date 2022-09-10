import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/size_config.dart';

class UserButton extends StatelessWidget {
  final String name;
  final String icon;
  final Function() onClick;
  const UserButton(
      {Key? key, required this.name, required this.icon, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Divider(height: 0, color: Colors.grey.withOpacity(0.8)),
      SizedBox(
        width: double.infinity,
        height: getHeight(0.07),
        child: TextButton.icon(
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.grey.withOpacity(0.15)),
                alignment: Alignment.centerLeft,
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(left: getWidth(0.05)))),
            onPressed: () {
              onClick();
            },
            icon: SvgPicture.asset(icon, color: NikeColor.mainColor),
            label: Text(name,
                style: TextStyle(
                    color: NikeColor.mainColor, fontSize: getFontSize(0.018)))),
      ),
    ]);
  }
}
