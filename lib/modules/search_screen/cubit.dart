import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search_screen/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);
  ShopSearchModel? searchModel;

  void search(var text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: Search,
      data: {
        'text': text,
      },
      authorization: token,
      lang: 'en',
    )!
        .then((value) {
      searchModel = ShopSearchModel.fromJson(value.data);
      print(searchModel!.data!.data![0].name);
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}