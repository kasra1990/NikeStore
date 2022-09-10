import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/utils/nike_notifiers.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/core/widgets/error_page.dart';
import 'package:nike_flutter/core/widgets/loading.dart';
import 'package:nike_flutter/features/root/category/presentation/bloc/category_bloc.dart';
import 'package:nike_flutter/features/root/category/presentation/widgets/category_product.dart';
import 'package:nike_flutter/features/root/category/presentation/widgets/category_search_edit_text.dart';
import 'package:nike_flutter/features/root/category/presentation/widgets/category_sort_button.dart';
import '../../../../../core/di/dependencies.dart';
import '../../domain/entities/category_entity.dart';

/// Category Screen Page
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    NikeNotifiers.authRefreshNotifier.addListener(_categoryStart);
    NikeNotifiers.tryConnection.addListener(_categoryStart);
    _categoryStart();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    NikeNotifiers.authRefreshNotifier.removeListener(_categoryStart);
    NikeNotifiers.tryConnection.removeListener(_categoryStart);
  }

  void _categoryStart() {
    context.read<CategoryBloc>().add(const CategoryStarted(category: "0"));
  }

  @override
  Widget build(BuildContext context) => _categoryUI();

  /// Category UI
  Widget _categoryUI() {
    return SafeArea(
        child: GestureDetector(
      // unfocus from current focuse node (Search TextFormField)
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(
              top: getHeight(0.015),
              left: getWidth(0.04),
              right: getWidth(0.04)),
          child: Column(
            children: [
              const CategorySearchEditText(),
              SizedBox(height: getHeight(0.015)),
              const CategorySortButton(),
              SizedBox(height: getHeight(0.015)),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategorySuccess) {
                    return Expanded(child: _successUI(entity: state.entity));
                  } else if (state is CategoryLoading) {
                    return const Expanded(child: Loading());
                  } else if (state is CategoryError) {
                    return Expanded(child: ErrorPage(error: state.error));
                  } else {
                    throw Exception("State is not supported");
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
  }

  ///successfull state UI
  Widget _successUI({required CategoryEntity entity}) => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20, childAspectRatio: 0.82, crossAxisCount: 2),
      itemCount: entity.categories!.length,
      itemBuilder: (context, index) {
        return CategoryProduct(
          product: entity.categories![index],
        );
      });
}
