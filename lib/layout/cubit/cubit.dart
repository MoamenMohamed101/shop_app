import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorites_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/shared/componants/constants.dart';
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

  void getData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(url: Home, authorization: token)!.then((value) {
      emit(ShopSuccessHomeDataStates());
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel.toString());
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
      print(categoriesModel.toString());
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesStates());
    });
  }
}
