import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/cubit_register/states.dart';
import 'package:shopapp/models/login_model.dart';

import 'package:shopapp/shared/network/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());
  
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url:'register',
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);


      emit(ShopRegisterSuccessState(loginModel!));

    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordRegisterVisibilityState());
  }
}