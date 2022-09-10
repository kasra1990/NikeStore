import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/nike_color.dart';
import '../../../../../core/utils/size_config.dart';
import '../bloc/category_bloc.dart';

/// Search edit text
class CategorySearchEditText extends StatelessWidget {
  const CategorySearchEditText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        onChanged: (value) {
          debugPrint("Search: $value");
          context.read<CategoryBloc>().add(CategorySearchQuery(value));
        },
        style: TextStyle(fontSize: getFontSize(0.02)),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: getFontSize(0.02)),
          hintText: "Search here...",
          prefixIconConstraints:
              const BoxConstraints(maxWidth: 30, maxHeight: 30),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide:
                  const BorderSide(color: NikeColor.mainColor, width: 2)),
        ),
        cursorColor: NikeColor.mainColor,
      );
}
