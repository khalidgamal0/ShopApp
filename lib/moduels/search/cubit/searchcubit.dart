import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/moduels/search/cubit/searchStates.dart';

import '../../../../shared/commponent/constent.dart';
import '../../../model/ChangefavoriteModel.dart';
import '../../../model/SearchModel.dart';
import '../../../model/favoriteModel/favoritemodel.dart';
import '../../../shared/netwok/endpoints.dart';
import '../../../shared/netwok/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit():super(searchintial());
  static SearchCubit get(context){
    return BlocProvider.of(context);
  }

  SearchModel? searchmodel;
  void getsearch(String text,){
    emit(searchloading());

    DioHelper.postData(
        method_url: SEARCH,
        token:token,
        data: {
          'text':text
        }
    ).then((value){
      searchmodel=SearchModel.fromJson(value.data);
      for (var element in searchmodel!.data!.data) {
        favorites.addAll({element.id!:element.inFavorites});
      }
      emit(searcsuccess());
    }).catchError((error){
          print(error.toString());

          emit(searcherror());
    }
    );
  }
  void changeFavorite(int product_id){
    favorites[product_id]=!favorites[product_id]!;
    emit(ShopChangeFavorite());
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
      emit(ShopSuccessChangeFavorite());

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
      emit(ShopSuccessGetFavorite());
    })
        .catchError((onError){
      print(onError.toString());
      emit(ShopErrorGetFavorite());
    });
  }
}
