import 'package:bloc/bloc.dart';
import 'package:chats_app/modules/shop_app/shop_register/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/shop_app/login_model.dart';
import '../../../../shared/network/end_point.dart';
import '../../../../shared/network/remote/dio_helpeer.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitiat());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(ShopRegisterLoading());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      print(value.data);
     loginModel= ShopLoginModel.FormJson(value.data);
      print(value.data['message']);
      emit(ShopRegisterSuccess(loginModel!));
    }).catchError((error) {
      emit(ShopRegisterError(error.toString()));
    });
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVsibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibility());
  }

}
