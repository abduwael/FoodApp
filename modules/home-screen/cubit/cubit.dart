
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/layout/home/cubit/states.dart';
import 'package:food/models/cart_food.dart';
import 'package:food/modules/add-to-cart-screen/add-to-cart.dart';
import 'package:food/modules/feeds-screen/feeds.dart';
import 'package:food/modules/home-screen/cubit/states.dart';
import 'package:food/shared/shared.network/remote/dio_helper.dart';
import 'package:food/shared/styles/colors.dart';
import '../../../models/popular_food.dart';
import '../../../models/recommeded_food.dart';
import '../../../modules/home-screen/home.dart';
import '../../../modules/setting-screen/setting.dart';
import '../../../shared/shared.components/components.dart';

class FoodPopularCubit extends Cubit<FoodPopularAppStates> {
  FoodPopularCubit() : super(FoodPopularAppInitialState());

  static FoodPopularCubit get(context) => BlocProvider.of(context);

  // static  double screenHeight(context) => MediaQuery.of(context).size.height;
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPage = 0.0;
  double scaleFactor = 0.8;

  void changeView() {
    pageController.addListener(() {
      currentPage = pageController.page!;
      emit(FoodChangeViewState());
    });
  }

  PopularFoodModel? popularFoodModel;

  void getPopularData() {
    emit(FoodPopularGetDataLoadingState());
    DioHelper.getData(
      url: 'v1/products/popular',
    ).then((value) {
      popularFoodModel = PopularFoodModel.fromJson(value.data);

      emit(FoodPopularGetDataSuccessState());
    }).catchError((e) {
      emit(FoodPopularGetDataErrorState(e));
    });
  }

  RecommendedFoodModel? recommendedFoodModel;

  void getRecommendedFoodData() {
    emit(FoodRecommendedGetDataLoadingState());
    DioHelper.getData(
      url: 'v1/products/recommended',
    ).then((value) {
      recommendedFoodModel = RecommendedFoodModel.fromJson(value.data);

      emit(FoodRecommendedGetDataSuccessState());
    });
  }

  int quantityCubit = 0;

  void setQuantity(bool increment, context) {
    if (increment) {
      quantityCubit = checkQuantity(quantityCubit + 1, context);
      emit(QuantityIncreaseState());
    } else {
      quantityCubit = checkQuantity(quantityCubit - 1, context);
      emit(QuantityDecreaseState());
    }
  }
late int cartItems=0;
  int get cartItemsList=>cartItems+quantityCubit;
  int checkQuantity(int quantity, context) {
    if (quantity < 0) {
      final snackbar = displaySnackBar(
          context: context,
          text: 'Item count , "You Can not reduce more" ',
          color: Colors.white,
          backGroundColor: AppColors.mainColor);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return 0;
    } else if (quantity > 20) {
      final snackbar = displaySnackBar(
          context: context,
          text: 'Item count , "You Can not add more" ',
          color: Colors.white,
          backGroundColor: AppColors.mainColor);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct()
  {
    quantityCubit=0;
    cartItems=0;
  }
  Map<int, CartModel> items = {};

  Map<int, CartModel> get list => items;

  void addItem(ProductsPopular product, int quantity, context) {
    if(quantity>0)
      {
        if (items.containsKey(product.id)) {
          items.update(product.id!, (value) {
            return CartModel(
                id: value.id,
                name: value.name,
                price: value.price,
                img: value.img,
                quantity: value.quantity! + quantity,
                isExist: true,
                time: DateTime.now().toString());
          });
          items.forEach((key, value) {
            print('updated is id  ${value.id.toString()} ' +
                ' the quantity updated is ${value.quantity!.toString()}');
          }
          );
          quantity=0;
        }

        if(items.containsKey(product.id) ==false)
        items.putIfAbsent(product.id!, () {
          print('${product.id.toString()}  ' + 'Quantity' + ' $quantity');
          items.forEach((key, value) {
            print('quantity previuos ' + " ${value.quantity}");
          });
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString());
        });
        quantity=0;
      }
    else {
      final snackbar = displaySnackBar(
          context: context,
          text: 'Item count , "You Should add at least one item" ',
          color: Colors.white,
          backGroundColor: AppColors.mainColor);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    emit(QuantityChangeSuccess());
  }
}
