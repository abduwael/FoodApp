

import 'package:food/models/cart_food.dart';

abstract class FoodPopularAppStates{}

class FoodPopularAppInitialState extends FoodPopularAppStates{}

class FoodPopularGetDataLoadingState extends FoodPopularAppStates{}

class FoodPopularGetDataSuccessState extends FoodPopularAppStates{}

class  FoodPopularGetDataErrorState extends FoodPopularAppStates{
  final dynamic error;
  FoodPopularGetDataErrorState(this.error);
}


class FoodRecommendedGetDataLoadingState extends FoodPopularAppStates{}

class FoodRecommendedGetDataSuccessState extends FoodPopularAppStates{}

class  FoodRecommendedGetDataErrorState extends FoodPopularAppStates{}

class  FoodChangeViewState extends FoodPopularAppStates{}

class  AddedToCartStorageItem extends FoodPopularAppStates{}



class QuantityIncreaseState extends FoodPopularAppStates{}
class QuantityDecreaseState extends FoodPopularAppStates{}

class QuantityChangeSuccess extends FoodPopularAppStates{
 /* final List<CartModel> cartModel;

  QuantityChangeSuccess ({required this.cartModel});*/
}

class IsExistChangeSuccess extends FoodPopularAppStates{}

class ItemSavedInStorage extends FoodPopularAppStates{}