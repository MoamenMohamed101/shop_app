import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Login_Model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';

import '../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? shopLoginModel;
  void userLogin({String? email, String? password}) {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
        url: 'login', data: {'email': email, 'password': password})!
        .then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessStates(shopLoginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(
        ShopLoginErrorStates(
          error.toString(),
        ),
      );
    });
  }
}