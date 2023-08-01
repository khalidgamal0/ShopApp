import 'package:shopapp/model/shoploginmodel/shoploginmodel.dart';

abstract class LoginStates{}
class LoginInit extends LoginStates{}

class LoginChangePassVisibilty  extends LoginStates{}

class ShopLoginLoading extends LoginStates{}
class ShopLoginSucsess extends LoginStates{
  final ShopLoginModel? loginmodel;
  ShopLoginSucsess(this.loginmodel);
}
class ShopLoginError extends LoginStates{}