

abstract class FoodAppState{}

class FoodAppInitialState extends FoodAppState{}

class FoodBottNavBar  extends FoodAppState{}

class FoodBusinessData extends FoodAppState{}
class FoodBusinessDataError extends FoodAppState
{
  final String error;
  FoodBusinessDataError(this.error);}
class  FoodBusinessGetDataLoading extends FoodAppState{}


class FoodSportsData extends FoodAppState{}
class FoodSportsDataError extends FoodAppState
{
  final String error;
  FoodSportsDataError(this.error);}
class  FoodSportsGetDataLoading extends FoodAppState{}

class FoodScienceData extends FoodAppState{}
class FoodScienceDataError extends FoodAppState
{
  final String error;
  FoodScienceDataError(this.error);}
class  FoodScienceGetDataLoading extends FoodAppState{}


class FoodSearchData extends FoodAppState{}
class FoodSearchDataError extends FoodAppState
{
  final String error;
  FoodSearchDataError(this.error);}
class  FoodSearchGetDataLoading extends FoodAppState{}

class FoodGetData extends FoodAppState{}



