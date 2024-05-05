import 'package:bloc/bloc.dart';
import 'package:chats_app/modules/shop_app/shop_login/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/shop_app/login_model.dart';
import '../../../../shared/network/end_point.dart';
import '../../../../shared/network/remote/dio_helpeer.dart';


class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoaginInitiat());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoagLoading());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
     loginModel= ShopLoginModel.FormJson(value.data);
      print(value.data['message']);
      // emit(ShopLoaginSuccess(loginModel!));
    }).catchError((error) {
      emit(ShopLoaginError(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVsibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibility());
  }

}
