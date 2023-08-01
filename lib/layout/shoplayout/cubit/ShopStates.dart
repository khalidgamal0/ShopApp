import '../../../model/ChangefavoriteModel.dart';

abstract class ShopStates{}

class ShopIntialStates extends ShopStates{}

class ShopHomeLoadingStates extends ShopStates{}

class ShopHomeSuccessStates extends ShopStates{}

class ShopHomeErrortates extends ShopStates{}

class ChoseBottomScrren extends ShopStates{}

class ShopSuccsessCategory extends ShopStates{}

class ShopFailCategory extends ShopStates{}

class ShopSuccsessChangeFavorite extends ShopStates{
  ChangeFavoriteModel x;
  ShopSuccsessChangeFavorite(this.x);
}
class ShoploadingUserData extends ShopStates{}

class ShopSuccsessUserData extends ShopStates{}

class ShopupdateloadingUserData extends ShopStates{}

class ShopupdateSuccsessUserData extends ShopStates{}

class ShopupdateFailUserData extends ShopStates{}

class ShopFailUserData extends ShopStates{}
class ShopSuccsessFavorite extends ShopStates{}

class ShopErrorChangeFavorite extends ShopStates{}

class ShopLoadingGetFavorite extends ShopStates{}

class ShopSuccsessGetFavorite extends ShopStates{}

class ShopErrorGetFavorite extends ShopStates{}