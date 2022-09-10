import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_flutter/core/api/entities/product_entity.dart';
import 'package:nike_flutter/core/utils/nike_color.dart';
import 'package:nike_flutter/core/utils/nike_notifiers.dart';
import 'package:nike_flutter/core/utils/size_config.dart';
import 'package:nike_flutter/core/utils/system_ui_controller.dart';
import 'package:nike_flutter/core/widgets/loading.dart';
import 'package:nike_flutter/features/root/home/data/model/home_data_model.dart';
import 'package:nike_flutter/features/root/home/presentation/bloc/home_bloc.dart';
import 'package:nike_flutter/features/root/home/presentation/widgets/product_list.dart';
import 'package:nike_flutter/features/root/home/presentation/widgets/slider.dart';
import '../../../../../core/widgets/error_page.dart';

/// Home Screen Page
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    NikeNotifiers.authRefreshNotifier.addListener(_homeStart);
    NikeNotifiers.tryConnection.addListener(_homeStart);
    _homeStart();
  }

  @override
  void dispose() {
    super.dispose();
    NikeNotifiers.authRefreshNotifier.removeListener(_homeStart);
    NikeNotifiers.tryConnection.removeListener(_homeStart);
  }

  void _homeStart() {
    context.read<HomeBloc>().add(HomeStarted());
  }

  @override
  Widget build(BuildContext context) {
    systemUIController();
    SizeConfig().init(context);
    return _createHomeUI();
  }

  // Home UI
  Widget _createHomeUI() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeSuccess) {
              return _successState(dataModel: state.homeDataModel);
            } else if (state is HomeLoading) {
              return const Loading();
            } else if (state is HomeError) {
              return ErrorPage(error: state.error);
            } else {
              throw Exception("State is not support : $state");
            }
          },
        ));
  }

  //UI Screen if state success
  Widget _successState({required HomeDataModel dataModel}) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return _applicationIcon();
            case 1:
              return BannerSlider(banners: dataModel.sliders);
            case 2:
              return _productRow(
                  title: "New Arrivals", products: dataModel.newArrivals);
            case 3:
              return _productRow(
                  title: "Most Popular", products: dataModel.mostPopular);
            default:
              return Container();
          }
        });
  }

  // nike logo in top
  Widget _applicationIcon() => Padding(
        padding: EdgeInsets.only(top: getHeight(0.01), bottom: getHeight(0.02)),
        child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/icons/nike_logo.png',
              fit: BoxFit.cover,
              height: getHeight(0.03),
            )),
      );

  // row of product
  Widget _productRow(
          {required String title, required List<ProductEntity>? products}) =>
      Padding(
        padding: EdgeInsets.only(
            top: getHeight(0.01), left: getWidth(0.03), right: getWidth(0.03)),
        child: ProductList(
          title: title,
          products: products,
        ),
      );
}
