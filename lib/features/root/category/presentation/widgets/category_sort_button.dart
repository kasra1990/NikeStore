import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/nike_color.dart';
import '../../../../../core/utils/size_config.dart';
import '../bloc/category_bloc.dart';

// filter list of category
class CategorySortButton extends StatefulWidget {
  const CategorySortButton({Key? key}) : super(key: key);

  @override
  State<CategorySortButton> createState() => _CategorySortButtonState();
}

class _CategorySortButtonState extends State<CategorySortButton> {
  var selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    List<String> categoriesButton = [
      "All",
      "Men",
      "Women",
      "Newest",
      "Most Popular"
    ];
    return SizedBox(
      height: getHeight(0.045),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: categoriesButton.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var selected = selectedCategory == index;
            return Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : getWidth(0.02)),
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          selected ? NikeColor.mainColor : Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: getWidth(0.05))),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: const BorderSide(color: NikeColor.mainColor),
                          borderRadius: BorderRadius.circular(17))),
                      overlayColor: MaterialStateProperty.all(
                          Colors.grey.withOpacity(0.3))),
                  onPressed: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    setState(() {
                      selectedCategory = index;
                    });
                    context
                        .read<CategoryBloc>()
                        .add(CategoryStarted(category: index.toString()));
                  },
                  child: Text(categoriesButton[index],
                      style: TextStyle(
                          fontSize: getFontSize(0.015),
                          color:
                              selected ? Colors.white : NikeColor.mainColor))),
            );
          }),
    );
  }
}
