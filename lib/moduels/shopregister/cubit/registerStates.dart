import '../../../model/shoploginmodel/shoploginmodel.dart';

abstract class registerStates{}

class registerInitialState extends registerStates{}

class registerLoadingState extends registerStates{}

class registerSuccessState extends registerStates{
  ShopLoginModel registerModel;
  registerSuccessState(this.registerModel);
}

class registerErrorState extends registerStates{}

class passVisibility extends registerStates{}


