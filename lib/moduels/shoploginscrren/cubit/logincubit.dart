import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/model/shoploginmodel/shoploginmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/netwok/endpoints.dart';
import 'package:shopapp/shared/netwok/remote/dio_helper.dart';

import 'loginstate.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInit());
  ShopLoginModel? loginmodel;
  static LoginCubit get(context){
   return BlocProvider.of(context);
  }
  void userLogin({@required String?email,@required String?password}){
   DioHelper.postData(
       method_url:LOGIN,
       data:{
         'email':email,
         'password':password,
   } ,
   ).then((value){
     print(value.data);
     loginmodel=ShopLoginModel.fromjson(value.data);
     emit(ShopLoginSucsess(loginmodel));

   }).catchError((error){
     print('${error.toString()}');
     emit(ShopLoginError());
   });
  }
  bool obscure=false;
  IconData suffixIcon=Icons.visibility;
  void changepassvisbility(){
    obscure=!obscure;
    obscure?suffixIcon=Icons.visibility:suffixIcon=Icons.visibility_off;
    emit(LoginChangePassVisibilty());
  }
}