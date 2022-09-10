import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nike_flutter/features/root/cart/presentation/pages/cart_screen.dart';
import 'package:nike_flutter/features/root/category/presentation/pages/category_screen.dart';
import 'package:nike_flutter/features/root/home/presentation/bloc/home_bloc.dart';
import 'package:nike_flutter/features/root/home/presentation/pages/home_screen.dart';
import 'package:nike_flutter/features/root/salomon_bottom_bar.dart';
import 'package:nike_flutter/features/root/user/presentation/bloc/user_bloc.dart';
import '../../core/di/dependencies.dart';
import 'cart/presentation/bloc/cart_bloc.dart';
import 'category/presentation/bloc/category_bloc.dart';
import 'user/presentation/pages/user_screen.dart';

/// fot show and creaete navigationButtonBar
class RootScreen extends StatefulWidget {
  static const String routeName = "route_screen";
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

const int homeIndex = 0;
const int categoryIndex = 1;
const int cartIndex = 2;
const int userIndex = 3;

class _RootScreenState extends State<RootScreen> {
  final List<String> iconsPath = [
    "assets/icons/home.svg",
    "assets/icons/category.svg",
    "assets/icons/cart.svg",
    "assets/icons/user.svg"
  ];

  final List<String> itemsName = ["Home", "Category", "Cart", "User"];
  int selectedScreenIndex = homeIndex;

  @override
  Widget build(BuildContext context) {
    debugPrint("RootScreen --> build");
    return Scaffold(
        bottomNavigationBar: SalomonBottomBar(
            currentIndex: selectedScreenIndex,
            selectedItemColor: const Color(0xFF212121),
            unselectedItemColor: const Color(0xFF212121),
            onTap: (index) {
              setState(() {
                selectedScreenIndex = index;
              });
            },
            items: [
              SalomonBottomBarItem(
                  icon: SvgPicture.asset(iconsPath[0]),
                  title: Text(itemsName[0])),
              SalomonBottomBarItem(
                  icon: SvgPicture.asset(iconsPath[1]),
                  title: Text(itemsName[1])),
              SalomonBottomBarItem(
                  icon: SvgPicture.asset(iconsPath[2]),
                  title: Text(itemsName[2])),
              SalomonBottomBarItem(
                  icon: SvgPicture.asset(iconsPath[3]),
                  title: Text(itemsName[3])),
            ]),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => di<HomeBloc>()),
            BlocProvider(create: (context) => di<CategoryBloc>()),
            BlocProvider(create: (context) => di<CartBloc>()),
            BlocProvider(create: (context) => di<UserBloc>()),
          ],
          child: IndexedStack(index: selectedScreenIndex, children: const [
            HomeScreen(),
            CategoryScreen(),
            CartScreen(),
            UserScreen()
          ]),
        ));
  }
}
