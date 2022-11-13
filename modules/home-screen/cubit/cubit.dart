
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/models/cart_food.dart';
import 'package:food/modules/home-screen/cubit/states.dart';
import 'package:food/shared/shared.network/local/cache_helper.dart';
import 'package:food/shared/shared.network/remote/dio_helper.dart';
import 'package:food/shared/styles/colors.dart';
import '../../../models/popular_food.dart';
import '../../../models/recommeded_food.dart';
import '../../../shared/shared.components/components.dart';
import '../../../shared/shared.components/constants.dart';

class FoodPopularCubit extends Cubit<FoodPopularAppStates> {
  FoodPopularCubit() : super(FoodPopularAppInitialState());

  static FoodPopularCubit get(context) => BlocProvider.of(context);

  // static  double screenHeight(context) => MediaQuery.of(context).size.height;
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPage = 0.0;
  double scaleFactor = 0.8;
  int quantityCubit = 0;

  List<CartModel>storageItems=[];
  void changeView() {
    pageController.addListener(() {
      currentPage = pageController.page!;
      emit(FoodChangeViewState());
    });

  }

  PopularFoodModel? popularFoodModel;

 Future<void>  getPopularData()async {
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

  Future<void> getRecommendedFoodData() async{
    emit(FoodRecommendedGetDataLoadingState());
    DioHelper.getData(
      url: 'v1/products/recommended',
    ).then((value) {
      recommendedFoodModel = RecommendedFoodModel.fromJson(value.data);

      emit(FoodRecommendedGetDataSuccessState());
    });
  }


  void setQuantity(bool increment, context) {
    if (increment) {
      quantityCubit = checkQuantity(quantityCubit + 1, context);
      emit(QuantityIncreaseState());
    } else {
      quantityCubit = checkQuantity(quantityCubit - 1, context);
      print('decrement ' + quantityCubit.toString());
      emit(QuantityDecreaseState());
    }
  }

   int cartItems=0;
  int get cartItemsList=>cartItems+quantityCubit;
  int checkQuantity(int quantity, context) {
    if ((cartItems+quantity) < 0) {

      final snackbar = displaySnackBar(
          context: context,
          text: 'Item count , "You Can not reduce more" ',
          color: Colors.white,
          backGroundColor: AppColors.mainColor);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
       if(cartItems>0)
         {
           quantityCubit=-cartItems;
           return quantityCubit;
         }
      return 0;
    } else if ((cartItems+quantity) > 20) {
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

  void initProduct(ProductsModel? product)
  {
    quantityCubit=0;
    cartItems=0;
    var exist=false;
    exist=isExistInCart(product);
    if(exist)
      {
        cartItems=getQuantity(product);
        emit(IsExistChangeSuccess());
      }



  }
  bool isExistInCart(ProductsModel? product)
  {
    if(items.containsKey(product!.id))
    {
      return true;
    }else
      {
        return false;
      }
  }
  int  getQuantity(ProductsModel? product)
  {
    var quantity=0;
    if(items.containsKey(product!.id))
    {
      items.forEach((key, value) {
        if(key==product.id)
          {
            quantity=value.quantity!;
          }
      });
    }
    return quantity;
  }
  Map<int, CartModel> items = {};

  Map<int, CartModel> get list => items;

   addItem( ProductsModel? product, int quantity, context) {
     var totalQuantity=0;
     if (items.containsKey(product!.id))
     {
          items.update(product.id!, (value) {
            totalQuantity=value.quantity!+quantity;
            return CartModel(
              product: product,
                id: value.id,
                name: value.name,
                price: value.price,
                img: value.img,
                quantity:value.quantity!+quantity,
                isExist: true,
                time: DateTime.now().toString(),
            );
          });
          if((totalQuantity)<=0)
          {
            items.remove(product.id);
          }
        }
     else {
          if (quantity > 0) {
            if (items.containsKey(product.id) == false) {
              items.putIfAbsent(product.id!, () {
                return CartModel(
                    id: product.id,
                    name: product.name,
                    price: product.price,
                    img: product.img,
                    quantity: quantity,
                    isExist: true,
                    time: DateTime.now().toString(),
                       product: product,
                );
              });
              final snackbar = displaySnackBar(
                  context: context,
                  text: 'Item added to cart ',
                  color: Colors.white,
                  backGroundColor:Colors.grey);
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
            else {
              final snackbar = displaySnackBar(
                  context: context,
                  text: 'Item count , "You Should add at least one item" ',
                  color: Colors.white,
                  backGroundColor: AppColors.mainColor);
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          }
        }
     addToCart(getCart());
     cartItems =getQuantity(product);
     quantity=0;
    emit(QuantityChangeSuccess());
  }

  int get totalItems{
    int totalCartList=0;
     items.forEach((key, value) {
       totalCartList+=value.quantity!;
     });
    return totalCartList;
  }
  List<CartModel> getCart(){
   return   items.entries.map((e) {
     return e.value;
   }).toList();

  }
  int get totalPrice{
    int totalAmount=0;
    items.forEach((key, value) {
      totalAmount+=value.quantity!*value.price!;
    });
    return totalAmount;
  }
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
  List<CartModel>getToCartList=[];
  List<String>carts=[];
   List<CartModel> getCartListData()
   {
     if(CacheHelper.sharedPreferences!.containsKey('Cart'))
     {
      carts=CacheHelper.sharedPreferences!.getStringList('Cart')!;
      print('inside get to cart list'+carts.toString());
     }

     carts.forEach((element) {

       return  getToCartList.add(CartModel.fromJson(jsonDecode(element)));
     });
     return getToCartList;
   }

   List<CartModel>getCartStorageData()
   {
     setCartList=getCartListData();
     emit(ItemSavedInStorage());
     return storageItems;

   }

  set setCartList(List<CartModel> cartItem)
  {
    storageItems=cartItem;
    print('storage item length  '+storageItems.length.toString());
    for(int i=0; i < storageItems.length; i++)
    {

       items.putIfAbsent(storageItems[i].product!.id!, () {
         return CartModel(
           product: storageItems[i].product!,
           id: storageItems[i].product!.id!,
           name: storageItems[i].name,
           price: storageItems[i].price,
           img: storageItems[i].img,
           quantity:storageItems[i].quantity,
           isExist: storageItems[i].isExist,
           time: storageItems[i].time,
         );
       });


    }

  }

   //  'List<Object?>' is not a subtype of type 'List<String>'
}
