import 'package:shop_app/models/Login_Model.dart';
import 'package:shop_app/models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataStates extends ShopStates {}

class ShopSuccessHomeDataStates extends ShopStates {}

class ShopErrorHomeDataStates extends ShopStates {}

class ShopLoadingCategoriesStates extends ShopStates {}

class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErrorCategoriesStates extends ShopStates {}

class ShopLoadingFavoritesStates extends ShopStates {}

class ShopSuccessFavoritesStates extends ShopStates {
  final ChangeFavoritesModel changeFavoritesModel;

  ShopSuccessFavoritesStates(this.changeFavoritesModel);
}

class ShopErrorFavoritesStates extends ShopStates {}

class ShopLoadingGetFavoritesStates extends ShopStates {}

class ShopSuccessGetFavoritesStates extends ShopStates {}

class ShopErrorGetFavoritesStates extends ShopStates {}

class ShopLoadingGetProfileStates extends ShopStates {}

class ShopSuccessGetProfileStates extends ShopStates {
  final ShopLoginModel userModel;

  ShopSuccessGetProfileStates(this.userModel);
}

class ShopErrorGetProfileStates extends ShopStates {}