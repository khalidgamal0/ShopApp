import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/layout/shoplayout/shoplayout.dart';
import 'package:shopapp/moduels/shoploginscrren/shopLoginScreen.dart';
import 'package:shopapp/shared/block-observer.dart';
import 'package:shopapp/shared/commponent/constent.dart';
import 'package:shopapp/shared/netwok/local/sharedpreffernce.dart';
import 'package:shopapp/shared/netwok/remote/dio_helper.dart';
import 'package:shopapp/shared/style/color.dart';
import 'package:shopapp/shared/style/thememode.dart';
import 'moduels/onboarding/onboarding.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
   token=CacheHelper.getData(key:'token');
  bool? onboarding=CacheHelper.getData(key:'onboarding');
  if(onboarding==true){
    if(token!=null){
      widget=ShopLayout();
    }else{widget=ShopLoginSrceen();}
  }else{
    widget=ShoponBoarding();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget? StartWidget;
  MyApp(this.StartWidget);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme:lightthem ,
      darkTheme:darkthem,
      themeMode:ThemeMode.light ,
      home:StartWidget,
    );
  }
}