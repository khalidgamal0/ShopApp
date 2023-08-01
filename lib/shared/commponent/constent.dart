
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/ChangefavoriteModel.dart';
import '../../model/favoriteModel/favoritemodel.dart';
import '../../moduels/shoploginscrren/shopLoginScreen.dart';
import '../netwok/local/sharedpreffernce.dart';
import 'commponent.dart';

Widget singout(context)=>TextButton(child: Text('signout'),onPressed: (){
  CacheHelper.removedata(key:'token').then((value){
    Nvigateandfinish(context, ShopLoginSrceen());});
});

String? token='';
void signOut(context){
  CacheHelper.removedata(key:'token').then((value){
    Nvigateandfinish(context, ShopLoginSrceen());
  });
}
 Map<int ,dynamic> favorites={};
FavoriteModel?favoritmodel;
ChangeFavoriteModel?changefavoritemodel;



