import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/layout/home/cubit/states.dart';
import 'package:food/models/cart_food.dart';
import 'package:food/modules/add-to-cart-screen/add-to-cart.dart';
import 'package:food/modules/add-to-cart-screen/cubit/states.dart';
import 'package:food/modules/feeds-screen/feeds.dart';
import 'package:food/modules/home-screen/cubit/cubit.dart';
import 'package:food/shared/shared.network/remote/dio_helper.dart';
import '../../../modules/home-screen/home.dart';
import '../../../modules/setting-screen/setting.dart';
import '../../../shared/shared.network/local/cache_helper.dart';


class AddToCartStorageCubit extends Cubit<AddToCartStates> {
  AddToCartStorageCubit() : super(AddToCartAppInitialState());

  static AddToCartStorageCubit get(context) => BlocProvider.of(context);


}

class CartRepo{
  late final FoodPopularCubit foodPopularCubit;

  List<String>cartData=[];
  void addToCart(List<CartModel> cartModel)
  {
    cartData=[];
    cartModel.forEach((element) {
      return  cartData.add(jsonEncode(element));
    }
    );

    CacheHelper.saveData(key: 'Cart', value: cartData);
    getCartListData();
  }
  List<CartModel> getCartListData()
  {

    List<String>carts=[];
    List<CartModel>getToCartList=[];

    if(CacheHelper.sharedPreferences!.containsKey('Cart'))
    {
      carts=CacheHelper.sharedPreferences!.getStringList('Cart')!;
      print('inside get to cart list '+carts.toString());

    }

    carts.forEach((element) {
      //  print(getToCartList.map((e) => e.name));
      getToCartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return getToCartList;
  }
  List<CartModel>storageItems=[];

  List<CartModel>getCartStorageData()
  {
    setCartList=getCartListData();
    return storageItems;
  }

  set setCartList(List<CartModel> cartItem)
  {
    storageItems=cartItem;
    print('storage item length  '+storageItems.length.toString());
    for(int i=0; i < storageItems.length; i++)
    {

      foodPopularCubit.items.putIfAbsent(storageItems[i].product!.id!, () =>CartModel(
        product: storageItems[i].product,
        id: storageItems[i].id,
        img: storageItems[i].img,
        quantity: storageItems[i].quantity,
        isExist: storageItems[i].isExist,
        name: storageItems[i].name,
        price: storageItems[i].price,
        time: storageItems[i].time,

      ));
    }


  }
}