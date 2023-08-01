import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shoplayout/shoplayout.dart';
import 'package:shopapp/moduels/onboarding/onboarding.dart';
import 'package:shopapp/moduels/shopregister/shopregister.dart';
import 'package:shopapp/shared/commponent/commponent.dart';
import 'package:shopapp/shared/netwok/local/sharedpreffernce.dart';

import '../../shared/commponent/constent.dart';
import 'cubit/logincubit.dart';
import 'cubit/loginstate.dart';

class ShopLoginSrceen extends StatelessWidget {
  var emailcontroller=TextEditingController();
  var passcontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSucsess){
            if(state.loginmodel!.status!){
              print(state.loginmodel!.message);
              print(state.loginmodel!.data!.token);
              showToast(message:state.loginmodel!.message,state:ToastStates.SUCCESS);
              CacheHelper.setData(key:'token', value:state.loginmodel!.data!.token).then((value){
                token=state.loginmodel!.data!.token!;
                Nvigateandfinish(context,ShopLayout());
              });
            }
            else
              {
                print(state.loginmodel!.message);
                showToast(message:state.loginmodel!.message,state:ToastStates.ERROR);
              }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:(){Nvigateandfinish(context,ShoponBoarding());}, ),),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Text('Login',
                          style:Theme.of(context).textTheme.headline4!.
                          copyWith(color: Colors.blue),),
                        SizedBox(height: 10),
                        Text('login now to browes our offers',
                            style:Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey)),
                        SizedBox(height: 35),
                        defaulTextFormField(
                            controller: emailcontroller,
                            labelText: 'email',
                            prefixIcon:Icons.email_outlined,
                            type:TextInputType.emailAddress,
                            validate:(value){
                              if(value.isEmpty){
                                return('Email must not empty');
                              }
                              else return null;
                            }
                        ),
                        SizedBox(height: 15),
                        defaulTextFormField(
                            controller: passcontroller,
                            labelText: 'enter passward',
                            prefixIcon:Icons.lock_outline_sharp,
                            suffixIcon:LoginCubit.get(context).suffixIcon,
                            obscureText:LoginCubit.get(context).obscure,
                            suffixpressed: () {
                              LoginCubit.get(context).changepassvisbility();
                            },
                            type:TextInputType.visiblePassword,
                            validate:(value){
                              if(value.isEmpty){
                                return('password must not empty');
                              }
                              else return null;
                            },
                            onFieldSubmitted: (value){
                              if (formkey.currentState!.validate())
                              {
                                LoginCubit.get(context).userLogin(
                                  email:emailcontroller.text,
                                  password: passcontroller.text,

                                );
                              }
                            }

                        ),
                        SizedBox(height: 15,),
                        defaultMaterialButton(text: 'login', function:(){
                          if (formkey.currentState!.validate())
                          {
                            LoginCubit.get(context).userLogin(
                              email:emailcontroller.text,
                              password: passcontroller.text,

                            );
                          }
                        }),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an acount'),
                            TextButton(onPressed: (){
                              Nvigateandfinish(context, ShopRegister());
                            }, child: Text('REGISTER'.toUpperCase()))
                          ],)



                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
