import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorites_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottom(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(url: Home, authorization: token)!.then((value) {
      emit(ShopSuccessHomeDataStates());
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
    }).catchError((error) {
      print(error.toString());
      emit(ShopSuccessHomeDataStates());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopLoadingCategoriesStates());
    DioHelper.getData(url: Categories, lang: 'en')!.then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesStates());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavourites(int? productId) {
    favorites[productId!] = !favorites[productId]!;
    emit(ShopLoadingFavoritesStates());
    DioHelper.postData(
            url: Favorites,
            data: {'product_id': productId},
            authorization: token)!
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (changeFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessFavoritesStates(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorFavoritesStates());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(url: Favorites, authorization: token)!.then((value) {
      emit(ShopSuccessGetFavoritesStates());
      favoritesModel = FavoritesModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesStates());
    });
  }
}
