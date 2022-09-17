import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/layout/home/cubit/states.dart';
import 'package:food/modules/add-to-cart-screen/add-to-cart.dart';
import 'package:food/modules/feeds-screen/feeds.dart';
import 'package:food/shared/shared.network/remote/dio_helper.dart';
import '../../../modules/home-screen/home.dart';
import '../../../modules/setting-screen/setting.dart';


class FoodAppCubit extends Cubit<FoodAppState> {
  FoodAppCubit() : super(FoodAppInitialState());

  static FoodAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
 // static  double screenHeight(context) => MediaQuery.of(context).size.height;


  void botnavbarindex(int index) {
    currentIndex = index;
    emit(FoodBottNavBar());
  }

  List<BottomNavigationBarItem> item = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
      backgroundColor: Colors.blue,
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.feed_outlined,
      ),
      label: 'feeds',
      backgroundColor: Colors.blue,
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.add_shopping_cart_outlined,
      ),
      label: 'Cart',
      backgroundColor: Colors.blue,
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.people_outlined,
      ),
      label: 'Settings',
      backgroundColor: Colors.blue,
    ),
  ];
  List<Widget> screen = [
    HomeScreen(),
    FeedsScreen(),
    AddToCartScreen(),
    SettingScreen(),
  ];

/*  void getPopularData()
  {
    DioHelper.getData(url: 'v1/products/popular',).then((value) {
    print(value.data);

    });
    emit(FoodGetData());

  }*/

}
