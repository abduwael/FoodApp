

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


class QuantityIncreaseState extends FoodPopularAppStates{}
class QuantityDecreaseState extends FoodPopularAppStates{}

class QuantityChangeSuccess extends FoodPopularAppStates{}