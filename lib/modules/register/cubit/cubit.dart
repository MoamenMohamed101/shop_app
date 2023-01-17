import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Login_Model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? shopLoginModel;

  void userRegister({
    String? email,
    String? password,
    String? name,
    String? phone,
  }) {
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(
            url: Register, data: {'email': email, 'password': password})!
        .then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      print(shopLoginModel!.data);
      emit(ShopRegisterSuccessStates(shopLoginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(
        ShopRegisterErrorStates(
          error.toString(),
        ),
      );
    });
  }
}
