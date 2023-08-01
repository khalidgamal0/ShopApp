import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shoplayout/cubit/ShopStates.dart';

import '../../../model/ChangefavoriteModel.dart';
import '../../../model/ProductModel/ProductModel.dart';
import '../../../model/categorymodel.dart';
import '../../../model/favoriteModel/favoritemodel.dart';
import '../../../model/shoploginmodel/shoploginmodel.dart';
import '../../../moduels/categories/Categories.dart';
import '../../../moduels/favorite/Favorite.dart';
import '../../../moduels/product/Home.dart';
import '../../../moduels/settings/Settings.dart';
import '../../../shared/commponent/constent.dart';
import '../../../shared/netwok/endpoints.dart';
import '../../../shared/netwok/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopIntialStates());
  static ShopCubit get(context){
    return BlocProvider.of(context);
  }

  int cuurent_index=0;
  List<Widget>BottomScreens=[HomeScreen(),CategoriesScreen(),FavoriteScreen(),SettingScreen()];

  void changeBottomScreens(int index){
    cuurent_index=index;
    emit(ChoseBottomScrren());
  }

  HomeModel? homeModel;

  void UserHomeData(){
    emit(ShopHomeLoadingStates());
    DioHelper.getData(
        method_url:HOME,
        token:token,
    ).then((value){
      homeModel=HomeModel.fromjson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!:element.in_favorites});
      });
      emit(ShopHomeSuccessStates());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopHomeErrortates());
    });
  }

  void changeFavorite(int product_id){
    favorites[product_id]=!favorites[product_id]!;
    emit(ShopSuccsessFavorite());
    DioHelper.postData(
        method_url: Favorites,
        data: {'product_id':product_id},
      token: token
    ).
    then((value){
      changefavoritemodel=ChangeFavoriteModel.fromjson(value.data);
      if(!changefavoritemodel!.status!){
        favorites[product_id]=!favorites[product_id]!;
      }else{
        getfavoriteproduct();
      }
      emit(ShopSuccsessChangeFavorite(changefavoritemodel!));
    }).
    catchError((onError){
      favorites[product_id]=!favorites[product_id]!;
      emit(ShopErrorChangeFavorite());
    });
  }
  void getfavoriteproduct(){
    emit(ShopLoadingGetFavorite());
    DioHelper.getData(method_url:Favorites, token: token,)
        .then((value){
      favoritmodel=FavoriteModel.fromjson(value.data);
      emit(ShopSuccsessGetFavorite());
    })
        .catchError((onError){
      print(onError.toString());
      emit(ShopErrorGetFavorite());
    });
  }
  CategoryModel? categorymodel;
  void getcategoryData(){
    DioHelper.getData(method_url:Category).then((value){
      categorymodel= CategoryModel.fromjson(value.data);
      emit(ShopSuccsessCategory ());
    }).catchError((error){
      print(error.toString());
      emit(ShopFailCategory());
    });
  }


  ShopLoginModel? UserModel;
  void getUserDatatosettingscreen(){
    emit(ShoploadingUserData());
    DioHelper.getData(
      method_url:PROFILE,
      token: token,
    ).then((value){
      UserModel= ShopLoginModel.fromjson(value.data);
      // printFullText(UserModel!.data!.name.toString());
      emit(ShopSuccsessUserData ());
    }).catchError((error){
      print(error);
      emit(ShopFailUserData());
    });
  }
  void updateUserDatatosettingscreen({
    String? name,
    String? email,
    String? phone,
  }){
    emit(ShopupdateloadingUserData());
    DioHelper.PutData(
        method_url:UpdateProfile,
        token: token,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        }
    ).then((value){
      UserModel= ShopLoginModel.fromjson(value.data);
      // printFullText(UserModel!.data!.name.toString());
      emit(ShopupdateSuccsessUserData ());
    }).catchError((error){
      print(error);
      emit(ShopupdateFailUserData());
    });
  }
}

