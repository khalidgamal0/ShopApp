import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/moduels/shopregister/cubit/registerStates.dart';
import 'package:shopapp/shared/netwok/remote/dio_helper.dart';

import '../../../model/shoploginmodel/shoploginmodel.dart';
import '../../../shared/netwok/endpoints.dart';

class registerCubit extends Cubit<registerStates>{
  registerCubit():super(registerLoadingState());
  static registerCubit get(context){
    return BlocProvider.of(context);
  }

  bool obscureText =true;
  IconData suffixIcon=Icons.visibility;
  void changePassvisbility(){
    obscureText=!obscureText;
    obscureText?suffixIcon=Icons.visibility:suffixIcon=Icons.visibility_off;
    emit(passVisibility());
  }
  ShopLoginModel? registermodel;
  void userRegister({
    String? name,
    String? phone,
    String? email,
    String? password,
  }){
    emit(registerLoadingState());
    DioHelper.postData(
        method_url:REGISTER ,
        data: {
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
        },

       ).then((value){
      registermodel=ShopLoginModel.fromjson(value.data);
      emit(registerSuccessState(registermodel!));
    }).catchError((onError){
      print(onError.toString());
      emit(registerErrorState());
    });
  }
}